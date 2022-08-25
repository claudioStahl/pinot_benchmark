#! /bin/bash

current_dir=$(pwd)

# Install app packages
asdf install
cd app
mix deps.get

# Create offline data
mix app.create_offline_transcripts

# Create topic
docker exec -it kafka bash -c "/usr/bin/kafka-topics --create --topic transcripts --partitions 10 --replication-factor 1 --zookeeper zookeeper:2181"

# Create offline table
docker exec -it pinot-controller bash -c "JAVA_OPTS="" && /opt/pinot/bin/pinot-admin.sh AddTable -tableConfigFile /config/transcripts-table-offline.json -schemaFile /config/transcripts-schema.json -exec"

# Create realtime table
docker exec -it pinot-controller bash -c "JAVA_OPTS="" && /opt/pinot/bin/pinot-admin.sh AddTable -tableConfigFile /config/transcripts-table.json -schemaFile /config/transcripts-schema.json -exec"

# Launch batch job
docker run -it --network pinot_vpcbr -v ${current_dir}/config:/tmp/config -v ${current_dir}/tmp/data:/tmp/data apachepinot/pinot:0.10.0 LaunchDataIngestionJob -jobSpecFile /tmp/config/transcripts-ingestionjobspec.yaml
