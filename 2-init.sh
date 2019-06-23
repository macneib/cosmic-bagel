#!/bin/bash

# Start Elasticsearch connector
curl -i -X POST -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:8083/connectors/ -d @es-sink.json
# Start PostgreSQL connector
curl -i -X POST -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:8083/connectors/ -d @jdbc-sink.json
# Initialize database and insert test data

# sink products on poll
curl -i -X POST -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:8083/connectors/ -d @jdbc-sink-products.json
