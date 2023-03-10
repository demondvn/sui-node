FROM rust:1.67 as builder
RUN apt update && DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt install  -y  make clang pkg-config libssl-dev build-essential git jq ncdu bsdmainutils htop
RUN git clone https://github.com/MystenLabs/sui.git --branch testnet
WORKDIR /sui
RUN cargo build --release -p sui-node
FROM debian:bullseye-slim
RUN apt-get update && apt-get install -y sudo wget curl && rm -rf /var/lib/apt/lists/*
COPY --from=builder /sui/target/release/sui-node /usr/local/bin/sui-node
COPY script.sh script.sh
RUN chmod +x script.sh

EXPOSE 9000
EXPOSE 9184
EXPOSE 8080
RUN mkdir /var/sui
VOLUME /var/sui
CMD /bin/bash script.sh && sui-node --config-path "/var/sui/fullnode.yaml"
# ENTRYPOINT ["sui-node"] 
