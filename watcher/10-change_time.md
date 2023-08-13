```
PUT sales/1/1
{
  "purchase_date": "2018-08-05T15:43:13.000Z"
}

PUT sales/1/2
{
  "purchase_date": "2018-08-05T15:43:13.000Z"
}


PUT _xpack/watcher/watch/hhh
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

POST _xpack/watcher/watch/hhh/_execute
```
