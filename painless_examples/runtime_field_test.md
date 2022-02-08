```
POST kore/_doc/1
{
  "name" : 33
  
}


POST kore/_doc/2
{
  "name" : 38
  
}
 
GET kore/_search
{
  "runtime_mappings": {
    "copy_id": {
      "type": "long",
      "script": {
        "source": "emit(Integer.parseInt(doc['_id'].value))"
      }
    }
  },
   "fields": [
     "copy_id"
   ],
   "aggs": {
     "whoismax": {
       "max": {
         "field": "copy_id"
       }
     }
   }
}

```

- response

```
#! Loading the fielddata on the _id field is deprecated and will be removed in future versions. If you require sorting or aggregating on this field you should also include the id in the body of your documents, and map this field as a keyword field that has [doc_values] enabled
{
  "took" : 2,
  "timed_out" : false,
  "_shards" : {
    "total" : 1,
    "successful" : 1,
    "skipped" : 0,
    "failed" : 0
  },
  "hits" : {
    "total" : {
      "value" : 2,
      "relation" : "eq"
    },
    "max_score" : 1.0,
    "hits" : [
      {
        "_index" : "kore",
        "_type" : "_doc",
        "_id" : "1",
        "_score" : 1.0,
        "_source" : {
          "name" : 33
        },
        "fields" : {
          "copy_id" : [
            1
          ]
        }
      },
      {
        "_index" : "kore",
        "_type" : "_doc",
        "_id" : "2",
        "_score" : 1.0,
        "_source" : {
          "name" : 38
        },
        "fields" : {
          "copy_id" : [
            2
          ]
        }
      }
    ]
  },
  "aggregations" : {
    "whoismax" : {
      "value" : 2.0
    }
  }
}
```
