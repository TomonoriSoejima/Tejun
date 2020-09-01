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
        "host": "localhost",
        "port": 9200,
        "method": "get",
        "path": "_cat/nodes"
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
```
