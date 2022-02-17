```

PUT my-index-000001/
{
  "mappings": {
    "_size": {
      "enabled": true
    },
    "runtime": {
      "size": {
        "type": "long",
        "script": {
          "source": "emit(doc['_size'].value)"
        }
      }
    }
  }
}

# Example documents
PUT my-index-000001/_doc/1
{
  "text": "This is a document"
}

GET my-index-000001/_search
PUT my-index-000001/_doc/2
{
  "text": "This is another document"
}



GET my-index-000001/_search
{
  "fields": ["_size"]
}
```
