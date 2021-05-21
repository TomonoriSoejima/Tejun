```
http GET http://localhost:9200/_template > template.json
cat template.json | jq '. | to_entries[0] | del(.value.version, .value.order) | {template: .value, index_patterns: .value.index_patterns} | del(.template.index_patterns, .template.key)' 

```
