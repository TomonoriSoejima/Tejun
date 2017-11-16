```
delete mail_info
PUT mail_info
{
  "mappings": {
    "t": {
      "properties": {
        "mail": {
          "type": "nested" 
        }
      }
    }
  }
}

PUT mail_info/t/1
{
  "mail": [
    {
      "address": "user1@mail.com"
    },
    {
      "address": "user2@mail.com"
    },
    {
      "address": "user3@mail.com"
    }
  ]
}

GET mail_info/_search
{
  "aggs": {
    "aaa": {
      "nested": {
        "path": "mail"
      },
      "aggs": {
        "group_by_mail": {
          "terms": {
            "field" : "mail.address.keyword"
          }
        }
      }
    }
  }
}
```

response
```
{
  "took": 1,
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
        "_index": "mail_info",
        "_type": "t",
        "_id": "1",
        "_score": 1,
        "_source": {
          "mail": [
            {
              "address": "user1@mail.com"
            },
            {
              "address": "user2@mail.com"
            },
            {
              "address": "user3@mail.com"
            }
          ]
        }
      }
    ]
  },
  "aggregations": {
    "aaa": {
      "doc_count": 3,
      "group_by_mail": {
        "doc_count_error_upper_bound": 0,
        "sum_other_doc_count": 0,
        "buckets": [
          {
            "key": "user1@mail.com",
            "doc_count": 1
          },
          {
            "key": "user2@mail.com",
            "doc_count": 1
          },
          {
            "key": "user3@mail.com",
            "doc_count": 1
          }
        ]
      }
    }
  }
}
```
