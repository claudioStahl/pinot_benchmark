Download pinot
```
PINOT_VERSION=0.10.0
wget https://downloads.apache.org/pinot/apache-pinot-$PINOT_VERSION/apache-pinot-$PINOT_VERSION-bin.tar.gz
tar -zxvf apache-pinot-$PINOT_VERSION-bin.tar.gz
mv apache-pinot-$PINOT_VERSION-bin pinot
```

Produce messages to topic
```sh
docker cp ./config/transcripts-data.json pinot-kafka-1:/tmp/transcripts-data.json

docker exec -it pinot-kafka-1 bash -c "/usr/bin/kafka-console-producer --broker-list localhost:9092 --topic transcripts < /tmp/transcripts-data.json"

cd app && mix app.produce_transcripts
```

Create schema
```sh
./pinot/bin/pinot-admin.sh AddSchema -schemaFile ./config/transcripts-schema.json -controllerHost localhost -controllerPort 9000 -exec
```

Create table
```sh
./pinot/bin/pinot-admin.sh AddTable -tableConfigFile ./config/transcripts-table.json -controllerHost localhost -controllerPort 9000 -exec
```

Queries
```sql
select * from transcript where tsDay = toEpochDays(fromDateTime('2019-10-24', 'yyyy-MM-dd'));

select sum(score) from transcript where tsDay = toEpochDays(fromDateTime('2019-10-24', 'yyyy-MM-dd')) and gender = 'Female';

select sum(score) from transcript where tsDay = toEpochDays(fromDateTime('2022-08-17', 'yyyy-MM-dd')) and gender = 'Female';

select count(*) from transcript where tsDay = toEpochDays(fromDateTime('2022-08-17', 'yyyy-MM-dd')) and gender = 'Female';

select count(*) from transcript where tsSecond >= toEpochSeconds(fromDateTime('2022-08-17 20:50:40', 'yyyy-MM-dd HH:mm:ss')) and tsSecond <= toEpochSeconds(fromDateTime('2022-08-17 20:50:50', 'yyyy-MM-dd HH:mm:ss')) and studentID = 5983;

select sum(score) from transcript where tsSecond >= toEpochSeconds(fromDateTime('2022-08-17 20:50:40', 'yyyy-MM-dd HH:mm:ss')) and tsSecond <= toEpochSeconds(fromDateTime('2022-08-17 20:50:50', 'yyyy-MM-dd HH:mm:ss')) and studentID = 5983;

select count(*) from transcript;
```
