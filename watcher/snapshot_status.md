```
PUT /_watcher/watch/snapshot-check
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
        "host": "single-node-7-17-1.es.asia-northeast1.gcp.cloud.es.io",
        "scheme": "https",
        "port": 9243,
        "method": "get",
        "path": "_snapshot/found-snapshots/_all",
        "params": {
          "order": "desc",
          "size": "1"
        },
        "auth": {
          "basic": {
            "username": "elastic",
            "password": "xxxx"
          }
        }
      }
    }
  },
  "condition": {
    "script": {
      "source": """
      def state = ctx.payload.snapshots.0.state;
      
      return state != "SUCCESS";
    """
    }
  },
  "actions": {
    "log": {
      "logging": {
        "text": """
          {{#ctx.payload.snapshots}} 
            state: {{state}}
            failures: {{failures}}
            shards: {{shards}}
            start_time: {{start_time}}
          {{/ctx.payload.snapshots}} 
"""
      }
    }
  }
} 

POST /_watcher/watch/snapshot-check/_execute


```

- reponse sample

```
          "logging" : {
            "logged_text" : """
             state: fail
            failures: {}
            shards: {total=16, failed=0, successful=16}
            start_time: 2022-10-24T09:59:59.808Z
 """
          }
```
