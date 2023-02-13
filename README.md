# sui-node
  
## Build
    docker build . -t sui

## Make foler data
    cd /mnt/blockstore/sui
  
    wget -O fullnode.yaml https://raw.githubusercontent.com/MystenLabs/sui/testnet/crates/sui-config/data/fullnode-template.yaml
  
    wget -O genesis.blob https://github.com/MystenLabs/sui-genesis/raw/main/testnet/genesis.blob
  
  `update fullnode.yaml > nano fullnode.yaml`.
      * db
      * genesis
      * /data
## Run
    docker run -it -d -p 9000:9000 -p 9184:9184 -v /mnt/blockstore/sui:/var/sui --name sui sui-node 
    


## Check
detail https://nodes.guru/sui/setup-guide/en
  https://www.scale3labs.com/check/sui
