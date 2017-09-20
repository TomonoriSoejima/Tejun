GET hotel/_search
{
  "size": 0,
  "query": {
    "bool": {
      "must": [
        {
          "query_string": {
            "query": "*",
            "analyze_wildcard": true
          }
        },
        {
          "range": {
            "created": {
              "gte": 1505574000000,
              "lte": 1506178799999,
              "format": "epoch_millis"
            }
          }
        }
      ],
      "must_not": []
    }
  },
  "_source": {
    "excludes": []
  },
  "aggs": {
    "2": {
      "filters": {
        "filters": {
          "japan": {
            "query_string": {
              "query": "japan",
              "analyze_wildcard": true
            }
          },
          "baa": {
            "query_string": {
              "query": "baa",
              "analyze_wildcard": true
            }
          },
          "china": {
            "query_string": {
              "query": "china",
              "analyze_wildcard": true
            }
          }
        }
      },
      "aggs": {
        "1": {
          "max": { 
            "script": "doc['daily_rate'].value + 1"
          }
        }
      }
    }
  }
}
