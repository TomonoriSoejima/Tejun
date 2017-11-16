PUT my_index
{
  "mappings": {
    "my_type": {
      "properties": {
        "user": {
          "type": "nested" 
        }
      }
    }
  }
}

PUT my_index/my_type/2
{
  "group" : "fans",
  "user" : [
    {
      "first" : "John",
      "last" :  "Smith"
    },
    {
      "first" : "Alice",
      "last" :  "White"
    }
  ]
}

GET my_index/_search
{
  "aggs": {
    "aaa": {
      "nested": {
        "path": "user"
      },
      "aggs": {
        "group_by_user": {
          "terms": {
            "field" : "user.first.keyword"
          }
        }
      }
    }
  }
}

response
{
  "took": 0,
  "timed_out": false,
  "_shards": {
    "total": 5,
    "successful": 5,
    "skipped": 0,
    "failed": 0
  },
  "hits": {
    "total": 1,
    "max_score": 1,
    "hits": [
      {
        "_index": "my_index",
        "_type": "my_type",
        "_id": "2",
        "_score": 1,
        "_source": {
          "group": "fans",
          "user": [
            {
              "first": "John",
              "last": "Smith"
            },
            {
              "first": "Alice",
              "last": "White"
            }
          ]
        }
      }
    ]
  },
  "aggregations": {
    "aaa": {
      "doc_count": 2,
      "group_by_user": {
        "doc_count_error_upper_bound": 0,
        "sum_other_doc_count": 0,
        "buckets": [
          {
            "key": "Alice",
            "doc_count": 1
          },
          {
            "key": "John",
            "doc_count": 1
          }
        ]
      }
    }
  }
}
