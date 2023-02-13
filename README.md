# sui-node
  
## Build
    docker build . -t sui

## Make foler data
    cd /mnt/blockstore/sui
  
    wget -O fullnode.yaml https://raw.githubusercontent.com/MystenLabs/sui/testnet/crates/sui-config/data/fullnode-template.yaml
  
    wget -O genesis.blob https://github.com/MystenLabs/sui-genesis/raw/main/testnet/genesis.blob
  
  `update fullnode.yaml > nano fullnode.yaml`.
      
          p2p-config:
            seed-peers:
             - address: "/ip4/65.109.32.171/udp/8084"
             - address: "/ip4/65.108.44.149/udp/8084"
             - address: "/ip4/95.214.54.28/udp/8080"
             - address: "/ip4/136.243.40.38/udp/8080"
             - address: "/ip4/84.46.255.11/udp/8084"
             - address: "/ip4/135.181.6.243/udp/8088"
## Run
    docker run -it -d -p 9000:9000 -p 9184:9184 -p 8080:8080 -v /mnt/blockstore/sui:/var/sui --name sui sui-node 
    


## Check
detail https://nodes.guru/sui/setup-guide/en
  https://www.scale3labs.com/check/sui
