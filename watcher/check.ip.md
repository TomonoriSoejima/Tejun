```
PUT /_watcher/watch/checkip
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

POST /_watcher/watch/checkip/_execute
```
