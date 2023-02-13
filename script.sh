#!/bin/bash

exists()
{
  command -v "$1" >/dev/null 2>&1
}
if exists curl; then
	echo ''
else
  sudo apt update && sudo apt install curl -y < "/dev/null"
fi
bash_profile=$HOME/.bash_profile
if [ -f "$bash_profile" ]; then
    . $HOME/.bash_profile
fi
sleep 1 && curl -s https://api.nodes.guru/logo.sh | bash && sleep 2
echo -e 'Setting up swapfile...\n'
curl -s https://api.nodes.guru/swap8.sh | bash

# echo -e '\n\e[42mInstall software\e[0m\n' && sleep 1
# apt-get update && DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get install -y --no-install-recommends tzdata git ca-certificates curl build-essential libssl-dev pkg-config libclang-dev cmake jq
# echo -e '\n\e[42mInstall Rust\e[0m\n' && sleep 1
# sudo curl https://sh.rustup.rs -sSf | sh -s -- -y
source $HOME/.cargo/env

# rm -rf /var/sui/suidb /var/sui/genesis.blob $HOME/sui
# mkdir -p /var/sui/suidb
# cd $HOME
# git clone https://github.com/MystenLabs/sui.git
# cd sui
# git remote add upstream https://github.com/MystenLabs/sui
# git fetch upstream
# git checkout -B testnet --track upstream/testnet
cp crates/sui-config/data/fullnode-template.yaml /var/sui/fullnode.yaml
sed -i.bak "s/db-path:.*/db-path: \"\/var\/sui\/suidb\"/ ; s/genesis-file-location:.*/genesis-file-location: \"\/var\/sui\/genesis.blob\"/" /var/sui/fullnode.yaml
wget -O /var/sui/genesis.blob https://github.com/MystenLabs/sui-genesis/raw/main/testnet/genesis.blob
sui-node --config-path /var/sui/fullnode.yaml

# mv ~/sui/target/release/sui-node /usr/local/bin/ || exit
