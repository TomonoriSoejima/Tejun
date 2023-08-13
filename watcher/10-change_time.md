```

POST /sales/_doc/
{
  "purchase_date": "2023-08-13T12:34:56Z"
}

POST /sales/_doc/
{
  "purchase_date": "2023-08-12T14:54:10Z"
}

PUT _watcher/watch/mywatch
{
  "trigger": {
    "schedule": {
      "interval": "5m"
    }
  },
  "input": {
    "search": {
      "request": {
        "indices": "sales",
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
      "source": """
      def total = ctx.payload.hits.hits.size();
      List new_dates = new ArrayList();
      for (int i = 0; i < total; i++) {
        
        
        new_dates.add("old : " + ctx.payload.hits.hits[i]._source.purchase_date + ", unix time:" + ZonedDateTime.parse(ctx.payload.hits.hits[i]._source.purchase_date).toInstant().toEpochMilli());
        
      }
      
      return ['purchase_dates' : new_dates];
      """
    }
  },
  "actions": {
    "log": {
      "logging": {
        "text": """
        {{#ctx.payload.purchase_dates}} 
        {{.}}
        {{/ctx.payload.purchase_dates}} 
        """
      }
    }
  }
}

POST _watcher/watch/mywatch/_execute
```
