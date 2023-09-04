```
PUT _watcher/watch/my_reindex_watch
{
  "trigger": {
    "schedule": {
      "interval": "1h"  // Execute every hour
    }
  },
  "condition": {
    "always": {}
  },
  "actions": {
    "reindex_action": {
      "webhook": {
        "url": "https://new.es.asia-northeast1.gcp.cloud.es.io",
        "port": 9243,
        "method": "POST",
        "path": "/_reindex",
        "headers": {
          "Content-Type": "application/json"
        },
        "body": """{
          "source": {
            "index": "new_hotel"
          },
          "dest": {
            "index": "index-static"
          }
        }""",
        "auth" : {
          "basic" : {
            "username" : "elastic", 
            "password" : "fsC64p8aQMXTobf8vQpW0Hp2"
          }
        }
      }
    }
  }
}

POST _watcher/watch/my_reindex_watch/_execute
```
