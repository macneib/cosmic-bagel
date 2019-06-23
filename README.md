## Two Parallel Sinks

### Topology

```
                   +-------------+
                   |             |
                   |    MsSQL    |
                   |             |
                   +------+------+
                          |
                          |
                          |
          +---------------v------------------+
          |                                  |
          |           Kafka Connect          |
          |  (Debezium, JDBC, ES connectors) |
          |                                  |
          +---+-----------------------+------+
              |                       |
              |                       |
              |                       |
              |                       |
+-------------v--+                +---v---------------+
|                |                |                   |
|   PostgreSQL   |                |   ElasticSearch   |
|                |                |                   |
+----------------+                +-------------------+

```
We are using Docker Compose to deploy the following components:

* MsSQL
* Kafka
  * ZooKeeper
  * Kafka Broker
  * Kafka Connect with [Debezium](http://debezium.io/), [JDBC](https://github.com/confluentinc/kafka-connect-jdbc) and  [Elasticsearch](https://github.com/confluentinc/kafka-connect-elasticsearch) Connectors
* PostgreSQL
* Elasticsearch

### Usage

How to run:

```shell
# Start the application
export DEBEZIUM_VERSION=0.9
docker-compose up

# Start Elasticsearch connector
curl -i -X POST -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:8083/connectors/ -d @es-sink.json

# Start PostgreSQL connector
curl -i -X POST -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:8083/connectors/ -d @jdbc-sink.json

# Initialize database and insert test data
cat debezium-sqlserver-init/inventory.sql | docker exec -i mssql bash -c '/opt/mssql-tools/bin/sqlcmd -U sa -P $SA_PASSWORD'

# Start MsSQL connector
curl -i -X POST -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:8083/connectors/ -d @register-mssql.json


```





Now you can execute commands as defined in the sections for JDBC and Elasticsearch sinks and you can verify that inserts and updates are present in *both* sinks.

End the application:

```shell
# Shut down the cluster
docker-compose down
```
