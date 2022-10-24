```
PUT /_watcher/watch/status-check
{
  "trigger": {
    "schedule": {
      "hourly": {
        "minute": 30
      }
    }
  },
  "input": {
    "http": {
      "request": {
        "host": "single-node-7-17-1.kb.asia-northeast1.gcp.cloud.es.io",
        "scheme"  : "https",
        "port": 9243,
        "method": "get",
        "path": "_cat/nodes",
             "auth" : {
        "basic" : {
          "username" : "elastic",
          "password" : "7r9PbzSjtPfMa1wTAetRorkS"
        }
      }
      }
    }
  },
  "condition": {
    "always" : {}
  },
  "actions": {
    "log": {
      "logging": {
        "text": "some node in es is down"
      }
    }
  }
} 

POST /_watcher/watch/status-check/_execute
```
