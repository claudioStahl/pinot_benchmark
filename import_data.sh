#! /bin/bash

# Create offline data
# cd app
# mix app.create_offline_transcripts

# Launch batch job
docker run -it --network pinot_vpcbr -v $(pwd)/config:/config -v $(pwd)/tmp/data:/tmp/data -e CLASSPATH_PREFIX="/config/hadoop/hadoop-hdfs-2.7.1.jar:/config/hadoop/hadoop-annotations-2.7.1.jar:/config/hadoop/hadoop-auth-2.7.1.jar:/config/hadoop/hadoop-common-2.7.1.jar:/config/hadoop/guava-11.0.2.jar:/config/hadoop/gson-2.2.4.jar" apachepinot/pinot:0.10.0 LaunchDataIngestionJob -jobSpecFile /config/transcripts-ingestionjobspec.yaml
