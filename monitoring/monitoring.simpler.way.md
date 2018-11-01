You need to change time range value yourself.
```
cluster_uuid=$(curl -s  http://localhost:9200 | jq -r .cluster_uuid)

curl -s -X POST -H "Content-Type: application/json" -H "kbn-xsrf: true" -d \
'{"showSystemIndices":false,"timeRange":{"min":"2018-10-31T22:53:17.664Z","max":"2018-10-31T23:53:17.664Z"}}' \
http://localhost:5601/api/monitoring/v1/clusters/${cluster_uuid}/elasticsearch/indices \
| jq -r .
```
