Data is created using this tool
https://github.com/TomonoriSoejima/myspark


data.json is saved : /Users/surfer/Downloads/data.json

you can invoke bulk as below
curl -H 'Content-Type: application/x-ndjson' -XPOST 'localhost:9200/_bulk?pretty' --data-binary @/Users/surfer/Downloads/data.json
