```
DELETE test

POST test/_doc/1
{
  "field1": "test"
}


POST test/_doc/2
{
  "field1" : "test"
}


GET test/_refresh

POST test/_update_by_query?conflicts=proceed
{
  "query": {
    "bool": {
      "must_not": {
        "exists": {
          "field": "field2"
        }
      }
    }
  },
  "script": {
    "source": "ctx._source['field2'] = 'test'"
  }
}

GET test/_search
```


- with template

```
PUT _template/template_1
{
  "index_patterns": ["tes*"],
  "settings": {
    "number_of_shards": 1
  },
  "mappings": {
    "_source": {
      "enabled": true
    },
    "properties": {
      "field1": {
        "type": "keyword"
      }
    }
  }
}

DELETE test

POST test/_doc/1
{
  "field1": "test"
}



POST test/_doc/2
{
  "field1" : "test"
}


GET test/_refresh

POST test/_update_by_query?conflicts=proceed
{
  "query": {
    "bool": {
      "must_not": {
        "exists": {
          "field": "field2"
        }
      }
    }
  },
  "script": {
    "source": "ctx._source['field2'] = 'test'"
  }
}

GET test/_search
```
