```

# make pipeline
PUT _ingest/pipeline/monthlyindex
{
  "description": "monthly date-time index naming",
  "processors" : [
    {
      "date_index_name" : {
        "field" : "date1",
        "index_name_prefix" : "apigee-response-content-",
        "date_rounding" : "d",
        "index_name_format": "yyyy.MM.dd"
      }
    }
  ]
}

# make data

POST apigee-1/_doc/1
{
  "data" : 1,
  "date1" : "2020-04-25T12:02:01.789Z"
}

POST apigee-2/_doc/2
{
  "data" : 1,
  "date1" : "2020-04-25T12:02:01.789Z"
}


# POST _reindex
{
  "source": {
    "index": ["apigee-1", "apigee-2"]
 
  },
  "dest": {
    "index": "anything",
    "pipeline": "monthlyindex"
  }
}

# check the new index is made

GET _cat/indices/api*

```


- reference

https://www.elastic.co/guide/en/elasticsearch/reference/master/date-index-name-processor.html
https://www.elastic.co/guide/en/elasticsearch/reference/7.6/docs-reindex.html
