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
        "url": "http://icanhazip.com/",
        "method": "get"
      }
    }
  },
  "condition": {
    "always" : {}
  },
  "actions": {
    "log": {
      "logging": {
        "text": "{{ctx.payload._value}}"
      }
    }
  }
} 

POST /_watcher/watch/status-check/_execute
```
