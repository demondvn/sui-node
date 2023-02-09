FROM ubuntu:20.04

RUN apt update && DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt install -y wget curl make clang pkg-config libssl-dev build-essential git jq ncdu bsdmainutils htop

COPY script.sh script.sh
RUN chmod +x script.sh
RUN apt install sudo -y
RUN /bin/bash script.sh

EXPOSE 9000
EXPOSE 9184
ENTRYPOINT ["sui-node", "--config-path /var/sui/fullnode.yaml"] 
