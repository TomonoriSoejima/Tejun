```
POST _scripts/demo_script
{
  "script": {
    "lang": "painless",
    "source": """
      Map all_result = new HashMap();
      def total = ctx.payload.hits.total;
      Map result = new HashMap();
      def city = ctx.payload.hits.hits.0._source.city;
      def action_time = new SimpleDateFormat('yyyy-MM-dd HH:mm:ss').format(new Date());
      result.put("city", city);
      result.put("action_time",action_time);
      all_result.put("result", result);
      all_result.put("total", total);
      return ['result' : all_result ];
    """
  }
}

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
          "indices": "hotel",
          "body": {
            "size": 1,
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
        "id": "demo_script"
      }
    },
    "actions": {
      "log": {
        "logging": {
          "text": """
          
          executed at {{ctx.payload.result}}
          total : {{ctx.payload.result.total}}
          
          """
        }
      },
      "index_payload": {
        "index": {
          "index": "testtest",
          "doc_id": "my-id"
        }
      }
    }
  }
}
```


The given code is written in Elasticsearch's Watcher API and is used for creating a watch that executes a script and performs actions based on certain conditions. 

In summary, the code does the following:

1. Creates a script named "demo_script" using the `_scripts/demo_script` endpoint. The script is written in the Painless scripting language. [Documentation for creating scripts](https://www.elastic.co/guide/en/elasticsearch/reference/current/modules-scripting.html)

2. Defines a watch using the `_watcher/watch/_execute` endpoint. The watch is triggered every 5 minutes and performs the following actions:
   - Executes a search request on the "hotel" index and retrieves only one document.
   - Transforms the search result using the "demo_script" script defined earlier.
   - Logs the result and total in the watch output. [Documentation for watch triggers](https://www.elastic.co/guide/en/elasticsearch/reference/current/watcher-api-execute-watch.html)

   - Indexes the transformed payload in the "testtest" index with a document ID of "my-id". If the index already exists, it is deleted first using the DELETE request. [Documentation for watcher action](https://www.elastic.co/guide/en/elasticsearch/reference/current/watcher-api-index-action.html)

Overall, the code sets up a watch that regularly executes a search, applies a transformation script, and logs the result. It also indexes the transformed payload in a designated index.
