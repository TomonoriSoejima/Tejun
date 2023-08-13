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


Summary:

This code is creating a Watcher which performs an Elasticsearch query and logs the results. The goal of the Watcher is to monitor the "sales" index and execute the query every 5 minutes. 

The first two POST requests add documents to the "sales" index with different purchase dates.

The PUT request creates the Watcher named "mywatch". It defines the trigger as a schedule that runs every 5 minutes. The input specifies the search request, targeting the "sales" index and retrieving 10 documents using a match_all query. The condition is set to "always", meaning the actions will always be executed. The transform section contains a script that calculates the total number of hits and creates a new list of purchase dates with additional information. The actions section defines a logging action that logs the purchase dates.

The final POST request executes the Watcher.

Hyperlinks to relevant documentation:

- Elasticsearch Document API: [https://www.elastic.co/guide/en/elasticsearch/reference/current/docs.html]
- Elasticsearch Watcher API: [https://www.elastic.co/guide/en/elasticsearch/reference/current/watcher-api.html]
- Elasticsearch Query DSL: [https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl.html]
- Elasticsearch Scripting: [https://www.elastic.co/guide/en/elasticsearch/painless/current/index.html]
- Elasticsearch Watcher Logging Action: [https://www.elastic.co/guide/en/elasticsearch/reference/current/actions-logging.html]

