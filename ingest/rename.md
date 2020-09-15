```
POST /_ingest/pipeline/_simulate?verbose
{
  "pipeline": {
    "description": "do something",
    "processors": [
      {
        "rename": {
          "field": "name",
          "target_field": "name1"
        },
        "dissect": {
          "field": "name1",
          "pattern": "%{name.first} %{name.last}"
        },
        "remove": {
          "field": [
            "name1"
          ]
        }
      }
    ]
  },
  "docs": [
    {
      "_index": "index",
      "_id": "id",
      "_source": {
        "name": "Taro Suzuki"
      }
    }
  ]
}

# response

{
  "docs" : [
    {
      "processor_results" : [
        {
          "doc" : {
            "_index" : "index",
            "_type" : "_doc",
            "_id" : "id",
            "_source" : {
              "name1" : "Taro Suzuki"
            },
            "_ingest" : {
              "pipeline" : "_simulate_pipeline",
              "timestamp" : "2020-09-15T10:07:16.991029Z"
            }
          }
        },
        {
          "doc" : {
            "_index" : "index",
            "_type" : "_doc",
            "_id" : "id",
            "_source" : {
              "name" : {
                "last" : "Suzuki",
                "first" : "Taro"
              },
              "name1" : "Taro Suzuki"
            },
            "_ingest" : {
              "pipeline" : "_simulate_pipeline",
              "timestamp" : "2020-09-15T10:07:16.991029Z"
            }
          }
        },
        {
          "doc" : {
            "_index" : "index",
            "_type" : "_doc",
            "_id" : "id",
            "_source" : {
              "name" : {
                "last" : "Suzuki",
                "first" : "Taro"
              }
            },
            "_ingest" : {
              "pipeline" : "_simulate_pipeline",
              "timestamp" : "2020-09-15T10:07:16.991029Z"
            }
          }
        }
      ]
    }
  ]
}


 ```
 
 
 ```
 PUT /_ingest/pipeline/my_index
{
  "description": "do something",
  "processors": [
    {
      "rename": {
        "field": "name",
        "target_field": "name1"
      },
      "dissect": {
        "field": "name1",
        "pattern": "%{name.first} %{name.last}"
      },
      "remove": {
        "field": [
          "name1"
        ]
      }
    }
  ]
}
 
PUT any_index/_doc/1?pipeline=my_index
{
  "name": "Taro Suzuki"
} 

GET any_index/_search

# response
{
  "took" : 0,
  "timed_out" : false,
  "_shards" : {
    "total" : 1,
    "successful" : 1,
    "skipped" : 0,
    "failed" : 0
  },
  "hits" : {
    "total" : {
      "value" : 1,
      "relation" : "eq"
    },
    "max_score" : 1.0,
    "hits" : [
      {
        "_index" : "any_index",
        "_type" : "_doc",
        "_id" : "1",
        "_score" : 1.0,
        "_source" : {
          "name" : {
            "last" : "Suzuki",
            "first" : "Taro"
          }
        }
      }
    ]
  }
}


```
