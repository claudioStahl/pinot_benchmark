#! /bin/bash

# Create table
docker run -it --network pinot_vpcbr -v $(pwd)/config:/tmp/config apachepinot/pinot:0.10.0 AddTable -tableConfigFile /tmp/config/transcripts-table-offline.json -schemaFile /tmp/config/transcripts-schema.json -controllerHost pinot-controller -controllerPort 9000 -exec

# Launch batch job
docker run -it --network pinot_vpcbr -v $(pwd)/config:/tmp/config -v $(pwd)/tmp/data3:/tmp/data apachepinot/pinot:0.10.0 LaunchDataIngestionJob -jobSpecFile /tmp/config/transcripts-ingestionjobspec.yaml
