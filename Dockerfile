FROM rust:1.67 as builder
RUN apt update && DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt install  -y  make clang pkg-config libssl-dev build-essential git jq ncdu bsdmainutils htop
RUN git clone https://github.com/MystenLabs/sui.git --branch testnet
WORKDIR /sui
RUN cargo build --release -p sui-node
FROM debian:bullseye-slim
RUN apt-get update && apt-get install -y extra-runtime-dependencies sudo wget curl && rm -rf /var/lib/apt/lists/*
COPY --from=builder /usr/local/cargo/bin/sui-node /usr/local/bin/sui-node
COPY script.sh script.sh
RUN chmod +x script.sh

EXPOSE 9000
EXPOSE 9184
RUN mkdir /data
VOLUME /data
CMD /bin/bash script.sh
# ENTRYPOINT ["sui-node"] 
