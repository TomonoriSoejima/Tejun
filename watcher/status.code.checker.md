## This sample uses sample data from Kibana

https://www.elastic.co/guide/en/kibana/7.11/get-started.html#gs-get-data-into-kibana

![image](https://user-images.githubusercontent.com/25199092/113078921-03bfd380-920f-11eb-94bd-35e035c22725.png)


```
POST _watcher/watch/_execute
{
  "watch": {
    "trigger": {
      "schedule": {
        "interval": "10h"
      }
    },
    
  "metadata": {
    "status_200": "200",
    "threshold" : 80
  },
    "input": {
      "search": {
        "request": {
          "indices": "kibana_sample_data_logs",
          "body": {
            "size": 0,
            "aggs": {
              "status_code": {
                "terms": {
                  "field": "response.keyword",
                  "size": 10
                }
              }
            },
            "query": {
              "bool": {
                "filter": [
                  {
                    "match_all": {}
                  },
                  {
                    "range": {
                      "timestamp": {
                        "gte": "2021-01-30T23:09:47.311Z",
                        "lte": "2021-03-31T00:09:47.311Z",
                        "format": "strict_date_optional_time"
                      }
                    }
                  }
                ]
              }
            }
          }
        }
      }
    },
    "condition": {
      "script": """
        
        def count_200 = ctx.payload.aggregations.status_code.buckets.stream()
                      .filter(it -> it.key == ctx.metadata.status_200).collect(Collectors.toList()).0.doc_count;

        def total_count = ctx.payload.aggregations.status_code.buckets.stream().mapToInt(o->o.doc_count).sum();

        def result = count_200 * 100 / total_count;
         
        return result < ctx.metadata.threshold;
       
        """
    },

    "actions": {
      "log_hits": {
        "logging": {
          "text": """
          status code {{ctx.metadata.status_200}} is under {{ctx.metadata.threshold}} percent;
      
          """
        }
      }
    }
  }
}
```
