```
http GET http://localhost:9200/_template > template.json
loop_count=$(cat template.json | jq ' . | length')
for i in $(seq 0 $loop_count); do

    cat template.json | jq  --arg v "$i" '. | to_entries[$v | tonumber] | del(.value.version, .value.order) | {template: .value, index_patterns: .value.index_patterns} | del(.template.index_patterns, .template.key)' > body.json

    template_name=$(cat template.json | jq --arg v "$i" -r '. | to_entries[$v | tonumber].key')
    http PUT http://localhost:9200/_index_template/$template_name < body.json

done

```
