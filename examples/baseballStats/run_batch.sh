#! /bin/bash

# Create table
docker run -it --network pinot_vpcbr -v $(pwd)/config:/tmp/config apachepinot/pinot:0.10.0 AddTable -tableConfigFile /tmp/config/baseballStats_offline_table_config.json -schemaFile /tmp/config/baseballStats_schema.json -controllerHost pinot-controller -controllerPort 9000 -exec

# Launch batch job
docker run -it --network pinot_vpcbr -v $(pwd)/config:/tmp/config -v $(pwd)/data:/tmp/data apachepinot/pinot:0.10.0 LaunchDataIngestionJob -jobSpecFile /tmp/config/ingestionJobSpec.yaml
