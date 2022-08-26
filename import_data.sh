#! /bin/bash

current_dir=$(pwd)

# Create offline data
cd app
mix app.create_offline_transcripts

# Launch batch job
docker run -it --network pinot_vpcbr -v ${current_dir}/config:/tmp/config -v ${current_dir}/tmp/data:/tmp/data apachepinot/pinot:0.10.0 LaunchDataIngestionJob -jobSpecFile /tmp/config/transcripts-ingestionjobspec.yaml
