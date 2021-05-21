```
http GET http://localhost:9200/_template > template.json
cat template.json | jq '. | to_entries[0] | del(.value.version, .value.order) | {template: .value, index_patterns: .value.index_patterns} | del(.template.index_patterns, .template.key)' > body.json

template_name=$(cat template.json | jq -r '. | to_entries[0].key')
http PUT http://localhost:9200/_index_template/$template_name < body.json
```
