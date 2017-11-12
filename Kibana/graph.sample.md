![sample1](https://github.com/TomonoriSoejima/Tejun/blob/master/Kibana/sample.png)


```
{
  "query": {
    "bool": {
      "must": [
        {
          "match_all": {}
        },
        {
          "range": {
            "created": {
              "gte": 1494596732562,
              "lte": 1510494332562,
              "format": "epoch_millis"
            }
          }
        }
      ],
      "must_not": []
    }
  },
  "size": 0,
  "_source": {
    "excludes": []
  },
  "aggs": {
    "2": {
      "date_histogram": {
        "field": "created",
        "interval": "1M",
        "time_zone": "Asia/Tokyo",
        "min_doc_count": 1
      },
      "aggs": {
        "1": {
          "sum": {
            "field": "price"
          }
        }
      }
    }
  }
}
```
