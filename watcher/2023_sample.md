```
POST _bulk
{ "index" : { "_index" : "your_index_name", "_id" : "1" } }
{ "errors_count": 1, "error_name": "InvalidRequest", "status": "400" }
{ "index" : { "_index" : "your_index_name", "_id" : "2" } }
{ "errors_count": 2, "error_name": "Unauthorized", "status": "401" }
{ "index" : { "_index" : "your_index_name", "_id" : "3" } }
{ "errors_count": 3, "error_name": "Forbidden", "status": "403" }
{ "index" : { "_index" : "your_index_name", "_id" : "4" } }
{ "errors_count": 4, "error_name": "NotFound", "status": "404" }
{ "index" : { "_index" : "your_index_name", "_id" : "5" } }
{ "errors_count": 5, "error_name": "InternalServerError", "status": "500" }


PUT _watcher/watch/my_watcher
{
  "trigger": {
    "schedule": {
      "interval": "5m"
    }
  },
  "input": {
    "search": {
      "request": {
        "indices": ["your_index_name"],
        "body": {
          "query": {
            "bool": {
              "must": [

                {
                  "term": {
                    "status": "401"
                  }
                }
              ]
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
  "actions": {
    "index_action": {
      "index": {
        "index": "watcher-alerts"
      },
      "transform": {
        "script": {
          "source": "return ['timestamp': ctx.trigger.scheduled_time, 'errors_count': ctx.payload.hits.total]"
        }
      }
    }
  }
}

POST _watcher/watch/my_watcher/_execute


GET watcher-alerts/_search
```
