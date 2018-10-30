**1. enable slow log against the index you are interested in.**


```
PUT .monitoring-es-6-2018.10.29/_settings
{
 "index.search.slowlog.threshold.query.debug": "0ms"
}
```


GET .monitoring-es-6-2018.10.29/_search
{
  "size": 0,
  "query": {
    "bool": {
      "filter": [
        {
          "term": {
            "cluster_uuid": {
              "value": "L5eAC8vETVK-13x9djYv3g",
              "boost": 1
            }
          }
        },
        {
          "term": {
            "index_stats.index": {
              "value": "hotel",
              "boost": 1
            }
          }
        },
        {
          "range": {
            "timestamp": {
              "from": 1540789530031,
              "to": 1540793190031,
              "include_lower": true,
              "include_upper": true,
              "format": "epoch_millis",
              "boost": 1
            }
          }
        }
      ],
      "adjust_pure_negative": true,
      "boost": 1
    }
  },
  "aggregations": {
    "check": {
      "date_histogram": {
        "field": "timestamp",
        "interval": "30s",
        "offset": 0,
        "order": {
          "_key": "asc"
        },
        "keyed": false,
        "min_doc_count": 0
      },
      "aggregations": {
        "metric": {
          "max": {
            "field": "index_stats.total.indexing.index_total"
          }
        },
        "metric_deriv": {
          "derivative": {
            "buckets_path": [
              "metric"
            ],
            "gap_policy": "skip",
            "unit": "1s"
          }
        }
      }
    }
  }
}
