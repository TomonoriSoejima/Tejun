`curl -X POST -H "Content-Type: application/json" -H "kbn-xsrf: true" -d @body.json 'http://localhost:9200/test/_search'`

```
cat body.json 
{
  "query": {
    "match": {
      "name": "mike"
    }
  }
}
```
