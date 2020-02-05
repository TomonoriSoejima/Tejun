

## These samples are based on the data https://github.com/TomonoriSoejima/Tejun/blob/master/watcher/data.zip

```
sample5
aggs_flatten/sample
csv.output
array_test/script5
array_test/for_louis
array_test/script4
array_test/script
array_test/script3
array_test/modified_script
meta.data.sample
csv/csv.watcher
add_field_inside_index_action
array_test/data.json
action sample
csv/bulk.json
```

## The sample data itself is generated using this tool

https://github.com/TomonoriSoejima/myspark

If you download this sample data file, you can load into your local elasticsearch as below.

```
curl -H 'Content-Type: application/x-ndjson' -XPOST 'localhost:9200/_bulk?pretty' --data-binary @/Users/surfer/Downloads/data.json
```
