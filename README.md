A project to explore the performance of Apache Pinot.

## Setup

Up containers
```
docker compose up -d
```

Prepare topic and table
```
./prepare.sh
```

Start app
```
./start_app.sh
```

Open grafana and configure dashboards on http://localhost:3000.

## Example queries

```sql
select * from transcript where tsDay = toEpochDays(fromDateTime('2019-10-24', 'yyyy-MM-dd'));

select sum(score) from transcript where tsDay = toEpochDays(fromDateTime('2019-10-24', 'yyyy-MM-dd')) and gender = 'Female';

select sum(score) from transcript where tsDay = toEpochDays(fromDateTime('2022-08-17', 'yyyy-MM-dd')) and gender = 'Female';

select count(*) from transcript where tsDay = toEpochDays(fromDateTime('2022-08-17', 'yyyy-MM-dd')) and gender = 'Female';

select count(*) from transcript where tsSecond >= toEpochSeconds(fromDateTime('2022-08-18 18:45:40', 'yyyy-MM-dd HH:mm:ss')) and tsSecond <= toEpochSeconds(fromDateTime('2022-08-18 18:45:50', 'yyyy-MM-dd HH:mm:ss')) and studentID = 5299;

select sum(score) from transcript where tsSecond >= toEpochSeconds(fromDateTime('2022-08-18 18:45:40', 'yyyy-MM-dd HH:mm:ss')) and tsSecond <= toEpochSeconds(fromDateTime('2022-08-18 18:45:50', 'yyyy-MM-dd HH:mm:ss')) and studentID = 5299;

select count(*) from transcript;
```
