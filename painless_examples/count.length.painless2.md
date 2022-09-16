```
PUT my-index-000004
{
  "mappings": {
    "properties": {
      "text": {
        "type": "keyword",
        "fields": {
          "keyword": {
            "type": "keyword",
            "ignore_above": 256
          }
        },
        "index": true,
        "doc_values": false
      }
    }
  }
}

POST my-index-000004/_doc/1
{
  "text": "hi"
}

GET my-index-000004/_search
{
  "fields": [
    "_size",
    "text",
    "text_length"
  ],
  "script_fields": {
    "text_length": {
      "script": "doc['text.keyword'].value.length()"
    }
  }
}


```
