```
PUT country/_doc/1
{
  "state" : "tokyo",
  "country" : "japan"
}

PUT country/_doc/2
{
  "state" : "chiba",
  "country" : "japan"
}


PUT city/_doc/1
{
  "state" : "tokyo",
  "city" : "choufu"
}



PUT _watcher/watch/mywatch
{
  "trigger": {
    "schedule": {
      "interval": "10m"
    }
  },
  "input": {
    "chain": {
      "inputs": [
        {
          "first": {
            "search": {
              "request": {
                "indices": [
                  "country"
                ],
                "body": {
                  "query": {
                    "bool": {
                      "must": [
                        {
                          "query_string": {
                            "query": "japan"
                          }
                        }
                      ]
                    }
                  }
                }
              }
            }
          }
		},
		{
          "second": {
            "search": {
              "request": {
                "indices": [
                  "city"
                ],
                "body": {
                  "query": {
                    "match": {
                      "state": "{{ctx.payload.first.hits.hits.1._source.state}}"
                      
                    }
                  }
                }
              }
            }
          }
        }
      ]
    }
  },
  "condition": {
    "script": {
      "source": "return true"
    }
  },
  "actions": {
  "log": {
      "logging": {
        "text": "{{#ctx.payload.first.hits.hits}}contry={{_source.state}} \n{{/ctx.payload.first.hits.hits}} {{#ctx.payload.second.hits.hits}}city={{_source.city}} \n{{/ctx.payload.second.hits.hits}}"
      }
    }
  }
}
```


This code performs the following actions:

1. It inserts two documents in the "country" index with the states "tokyo" and "chiba" and the country "japan".
2. It inserts one document in the "city" index with the state "tokyo" and the city "choufu".
3. It creates a watcher named "mywatch" with a trigger that is scheduled to run every 10 minutes.
4. The watcher has an input chain that consists of two searches. The first search retrieves documents from the "country" index that match the query "japan". The second search retrieves documents from the "city" index that match the state value of the first search's result.
5. The condition for executing the actions is always true.
6. The actions log the values of the state from the first search's result and the city from the second search's result.

To execute the watcher and trigger the actions, you can use the following request:

```
POST _watcher/watch/mywatch/_execute
```

You can find more information about the relevant Elasticsearch APIs and concepts in the following documentation:

- [PUT API](https://www.elastic.co/guide/en/elasticsearch/reference/current/docs-create.html)
- [Search API](https://www.elastic.co/guide/en/elasticsearch/reference/current/search.html)
- [Elasticsearch Watcher](https://www.elastic.co/guide/en/elasticsearch/reference/current/watcher.html)




POST _watcher/watch/mywatch/_execute
