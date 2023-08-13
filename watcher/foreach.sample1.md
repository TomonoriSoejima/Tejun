
```
POST test_a/_bulk
{"index": {"_id": "1"}}
{"tenantId": "001", "eventId": "111", "memo": "test1","@timestamp": "yyyy-MM-dd'T'HH:mm:ss.SSS+09:00"}
{"index": {"_id": "2"}}
{"tenantId": "002", "eventId": "111", "memo": "test2","@timestamp": "yyyy-MM-dd'T'HH:mm:ss.SSS+09:00"}
{"index": {"_id": "3"}}
{"tenantId": "001", "eventId": "111", "memo": "test3","@timestamp": "yyyy-MM-dd'T'HH:mm:ss.SSS+09:00"}


PUT _watcher/watch/_execute
{
  "watch": {
    "trigger": {
      "schedule": {
        "interval": "5m"
      }
    },
    "input": {
      "search": {
        "request": {
          "indices": "test_a",
          "body": {
            "query": {
              "match_all": {}
            },
            "aggs": {
              "agg1": {
                "terms": {
                  "field": "memo.keyword",
                  "size": 10
                }
              }
            }
          }
        }
      }
    },
    "condition": {
      "always": {}
    },
    "actions": {
      "log_hits": {
        "foreach": "ctx.payload.aggregations.agg1.buckets",
        "max_iterations": 500,
        "logging": {
          "text": "Found id {{ctx.payload.key}}"
        }
      }
    }
  }
}

```

- another example

```
POST myindex/_doc/
{
  "users": [
    {
      "name": "John",
      "email": "john@example.com"
    },
    {
      "name": "Jane",
      "email": "jane@example.com"
    },
    {
      "name": "Bob",
      "email": "bob@example.com"
    }
  ]
}


PUT _watcher/watch/_execute
{
  "watch": {
    "trigger": {
      "schedule": {
        "interval": "1m"
      }
    },
    "input": {
      "search": {
        "request": {
          "indices": [
            "myindex"
          ],
          "body": {
            "query": {
              "match_all": {
               
              }
            }
          }
        }
      }
    },
    "condition": {
      "compare": {
        "ctx.payload.hits.total": {
          "gt": 0
        }
      }
    },
    "transform": {
      "script": {
        "source": "return [ 'users': ctx.payload.hits.hits[0]._source.users ];"
      }
    },
    "actions": {
      "log_hits": {
        "foreach": "ctx.payload.users",
        "max_iterations": 100,
      
          "logging": {
            "text": "{{ctx.payload}}",
            "level": "info"
          }
        
      }
    }
  }
}
```



1. **Bulk Indexing Data**
    
    * The `POST test_a/_bulk` request is used to bulk index data into Elasticsearch.
    * Three documents are being indexed into the `test_a` index with specific `_id` values and associated data.
    * Each document contains a `tenantId`, `eventId`, `memo`, and a `@timestamp` field.
    
    [Read more about Elasticsearch Bulk API](https://www.elastic.co/guide/en/elasticsearch/reference/current/docs-bulk.html)
    
2. **Elasticsearch Watcher Execution**
    
    * The `PUT _watcher/watch/_execute` request is used to execute a watch without saving it.
    * The watch triggers every 5 minutes.
    * As an input, it searches the `test_a` index and matches all documents. It also aggregates the results based on the `memo.keyword` field, aiming to return the top 10 terms.
    * The condition set for this watch is `always`, which means the subsequent action is always executed when the watch is triggered.
    * The action logs the ids of the found documents, iterating over the aggregated buckets (up to 500 iterations).
    
    [Read more about Elasticsearch Watcher](https://www.elastic.co/guide/en/elasticsearch/reference/current/watcher-api-execute-watch.html)
    

This code is primarily about indexing some test documents into Elasticsearch and then setting up a watcher to periodically search, aggregate, and log certain data from those documents.
