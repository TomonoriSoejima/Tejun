```
POST _watcher/watch/_execute
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
          "indices": "hello",
          "body": {
            "size": 10,
            "query": {
              "match_all": {}
            }
          }
        }
      }
    },
    "condition": {
      "always": {}
    },
    "transform": {
      "script": {
        "id" : "demo_script"
      }
    },
    "actions": {
      "mail_api": {
        "logging": {
          "level": "info",
          "text": "ctx=>{{ctx.payload}}"
        }
      }
    }
  }
}


POST _scripts/demo_script
{
  "script": {
  "lang": "painless",
  "source": 

    """
      def payload = ctx.payload;
      return ['payload' : payload ];
    """
  }
}
```
