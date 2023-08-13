```
POST index1/_doc/1
{
  "data" : "index1_data",
  "status" : "error"
}

POST index2/_doc/1
{
  "data": "index2_data",
  "status": "error"
}

POST index3/_doc/1
{
  "data": "index3_data",
  "status": "error"
}


PUT _watcher/watch/make_new_index
{
  "trigger": {
    "schedule": {
      "interval": "5m"
    }
  },
  "input": {
    "search": {
      "request": {
        "indices": "index*",
        "body": {
          "query": {
            "match": {
              "status": "error"
            }
          }
        }
      }
    }
  },
  "condition": {
    "compare": {
      "ctx.payload.hits.total": {
        "gt": 0
      }
    }
  },
  "actions": {
    "index_payload": {
      "index": {
        "index": "testtest"
      }
    }
  }
}


POST _watcher/watch/make_new_index/_execute
GET testtest/_search
```


This code is using Elasticsearch's Watcher feature to create a new index called "testtest" and populate it with documents from other indexes where the "status" field is set to "error". 

In the first part of the code, three documents are added to different indexes, each with a "data" field and a "status" field set to "error".

In the second part of the code, a watch named "make_new_index" is created. It is triggered every 5 minutes using the "schedule" option. The input for the watch is a search request that searches for documents in indexes that match the pattern "index*" and have a "status" field set to "error". 

The condition for the watch is that the total number of hits from the search request should be greater than 0. If this condition is met, an action is performed. The action is to index the payload (the matched documents) into the "testtest" index with a document ID of "my-id".

At the end of the code, the watch is executed by sending a POST request to "_watcher/watch/make_new_index/_execute". Finally, a GET request is sent to "testtest/_search" to retrieve the documents that were indexed.

Hyperlinks to relevant documentation:
- Elasticsearch Watcher: [https://www.elastic.co/guide/en/elasticsearch/reference/current/watcher-api.html](https://www.elastic.co/guide/en/elasticsearch/reference/current/watcher-api.html)
- Index API: [https://www.elastic.co/guide/en/elasticsearch/reference/current/docs-index_.html](https://www.elastic.co/guide/en/elasticsearch/reference/current/docs-index_.html)
- Search API: [https://www.elastic.co/guide/en/elasticsearch/reference/current/search-search.html](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-search.html)
