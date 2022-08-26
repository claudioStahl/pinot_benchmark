#! /bin/bash

current_dir=$(pwd)

# Install app packages
asdf install
cd app
mix deps.get

# Create topic
docker exec -it kafka bash -c "/usr/bin/kafka-topics --create --topic transcripts --partitions 10 --replication-factor 1 --zookeeper zookeeper:2181"

# Create offline table
docker exec -it pinot-controller bash -c "JAVA_OPTS="" && /opt/pinot/bin/pinot-admin.sh AddTable -tableConfigFile /config/transcripts-table-offline.json -schemaFile /config/transcripts-schema.json -exec"

# Create realtime table
docker exec -it pinot-controller bash -c "JAVA_OPTS="" && /opt/pinot/bin/pinot-admin.sh AddTable -tableConfigFile /config/transcripts-table.json -schemaFile /config/transcripts-schema.json -exec"
