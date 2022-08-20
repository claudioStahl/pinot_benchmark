#! /bin/bash

# Create table
# docker run -it --network pinot_vpcbr -v $(pwd)/config_batch:/tmp/config_batch apachepinot/pinot:0.10.0 AddTable -tableConfigFile /tmp/config_batch/baseballStats_offline_table_config.json -schemaFile /tmp/config_batch/baseballStats_schema.json -controllerHost pinot-controller -controllerPort 9000 -exec

# Launch batch job
docker run -it --network pinot_vpcbr -v $(pwd)/config_batch:/tmp/config_batch apachepinot/pinot:0.10.0 LaunchDataIngestionJob -jobSpecFile /tmp/config_batch/ingestionJobSpec.yaml
