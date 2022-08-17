Create schema
```sh
curl --location --request POST 'http://192.168.0.116:9000/schemas?override=true' \
--header 'Content-Type: application/json' \
--data-raw '{}'
```

Produce messages to topic
```sh
docker cp ./config/transcripts-data.json pinot-kafka-1:/tmp/transcripts-data.json

docker exec -it pinot-kafka-1 bash -c "/usr/bin/kafka-console-producer --broker-list localhost:9092 --topic transcripts < /tmp/transcripts-data.json"
```

Create table
```sh
curl --location --request POST 'http://192.168.0.116:9000/tables' \
--header 'Content-Type: application/json' \
--header 'Accept: application/json' \
--data-raw '{}'
```

Execute query
```sql
select * from transcript limit 10
```
