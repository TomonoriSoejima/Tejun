```
PUT _watcher/watch/mywatch
{
  "metadata" : { 
    "color" : "nara"
  },
  "trigger" : { 
    "schedule" : {
      "interval" : "5m"
    }
  },
  "input" : { 
    "search" : {
      "request" : {
        "indices" : "hotel",
        "body" : {
          "size" : 10,
          "query" : { "match" : { "city" : "{{ctx.metadata.color}}" }}
        }
      }
    }
  },
  "condition" : { 
     "script": {
      "source": "return true"
    }
  },
   "actions": {
  "log": {
      "logging": {
        "text": "{{#ctx.payload.hits.hits}}contry={{_source.city}} \n{{/ctx.payload.hits.hits}} {{#ctx.payload.second.hits.hits}}city={{_source.city}} \n{{/ctx.payload.second.hits.hits}}"
      }
    }

  }
}


POST _watcher/watch/mywatch/_execute
```

This code is creating a Watcher watch in Elasticsearch, which periodically performs a search on the "hotel" index. The search query is based on the value of the "color" field in the metadata. The search returns a maximum of 10 results where the "city" field matches the value of the "color" field.

The watch is triggered every 5 minutes based on a schedule. The condition for executing the watch is always true, as specified in the script condition.

When the watch is executed, the result is logged, displaying the "city" field value for each hit in the search results.

Here are the relevant documentation links:
- [Watcher API](https://www.elastic.co/guide/en/elasticsearch/reference/current/watcher-api.html)
- [Watcher Actions](https://www.elastic.co/guide/en/elasticsearch/reference/current/watcher-api-logging-action.html)
- [Elasticsearch Query DSL](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl.html)
