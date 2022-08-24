#! /bin/bash

# Create topic
docker exec -it kafka bash -c "/usr/bin/kafka-topics --create --topic transcripts --partitions 1 --replication-factor 1 --zookeeper zookeeper:2181"

# Create table
docker run -it --network pinot_vpcbr -v $(pwd)/config:/tmp/config apachepinot/pinot:0.10.0 AddTable -tableConfigFile /tmp/config/transcripts-table.json -schemaFile /tmp/config/transcripts-schema.json -controllerHost pinot-controller -controllerPort 9000 -exec

# Install app packages
asdf install
cd app
mix deps.get
