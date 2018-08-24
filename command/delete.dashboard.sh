# the key is you should use single line for json string.
title="dash1"
HOGE=$(cat << EOS
{"query":{"match":{"dashboard.title":"${title}"}},"script_fields":{"id":{"script":{"source":"doc['_id'].value.replace('dashboard:','')"}}}}
EOS
)

id=$(curl -s -X POST -H "Content-Type: application/json" -H "kbn-xsrf: true" -d  $HOGE 'http://localhost:9200/.kibana/doc/_search' | jq -r '.hits.hits[0].fields.id[0]')

curl -X DELETE -H "kbn-xsrf: true" "http://localhost:5601/api/saved_objects/dashboard/${id}"
