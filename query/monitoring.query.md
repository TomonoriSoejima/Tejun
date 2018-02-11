
```
GET .monitoring-es-6-2018.02.11/_search
{
  "size": 0,
  "query": {
    "bool": {
      "filter": [
        {
          "bool": {
            "should": [
              {
                "term": {
                  "_type": {
                    "value": "index_stats",
                    "boost": 1
                  }
                }
              },
              {
                "term": {
                  "type": {
                    "value": "index_stats",
                    "boost": 1
                  }
                }
              }
            ],
            "disable_coord": false,
            "adjust_pure_negative": true,
            "boost": 1
          }
        },
        {
          "term": {
            "cluster_uuid": {
              "value": "79BUf_2LQ3ykfIczYBxd_A",
              "boost": 1
            }
          }
        },
        {
          "bool": {
            "must_not": [
              {
                "prefix": {
                  "index_stats.index": {
                    "value": ".",
                    "boost": 1
                  }
                }
              }
            ],
            "disable_coord": false,
            "adjust_pure_negative": true,
            "boost": 1
          }
        },
        {
          "range": {
            "timestamp": {
              "from": null,
              "to": null,
              "include_lower": true,
              "include_upper": true,
              "boost": 1
            }
          }
        }
      ],
      "disable_coord": false,
      "adjust_pure_negative": true,
      "boost": 1
    }
  },
  "aggregations": {
    "items": {
      "terms": {
        "field": "index_stats.index",
        "size": 10000,
        "min_doc_count": 1,
        "shard_min_doc_count": 0,
        "show_term_doc_count_error": false,
        "order": [
          {
            "_count": "desc"
          },
          {
            "_term": "asc"
          }
        ]
      },
      "aggregations": {
        "index_document_count": {
          "date_histogram": {
            "field": "timestamp",
            "interval": "3600s",
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
                "field": "index_stats.primaries.docs.count"
              }
            },
            "metric_deriv": {
              "derivative": {
                "buckets_path": [
                  "metric"
                ],
                "gap_policy": "skip",
                "unit": "second"
              }
            }
          }
        },
        "index_size": {
          "date_histogram": {
            "field": "timestamp",
            "interval": "3600s",
            "offset": 0,
            "order": {
              "_key": "asc"
            },
            "keyed": false,
            "min_doc_count": 0
          },
          "aggregations": {
            "metric": {
              "avg": {
                "field": "index_stats.total.store.size_in_bytes"
              }
            },
            "metric_deriv": {
              "derivative": {
                "buckets_path": [
                  "metric"
                ],
                "gap_policy": "skip",
                "unit": "second"
              }
            }
          }
        },
        "index_search_request_rate": {
          "date_histogram": {
            "field": "timestamp",
            "interval": "3600s",
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
                "field": "index_stats.total.search.query_total"
              }
            },
            "metric_deriv": {
              "derivative": {
                "buckets_path": [
                  "metric"
                ],
                "gap_policy": "skip",
                "unit": "second"
              }
            }
          }
        },
        "index_request_rate_primary": {
          "date_histogram": {
            "field": "timestamp",
            "interval": "3600s",
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
                "field": "index_stats.primaries.indexing.index_total"
              }
            },
            "metric_deriv": {
              "derivative": {
                "buckets_path": [
                  "metric"
                ],
                "gap_policy": "skip",
                "unit": "second"
              }
            }
          }
        }
      }
    }
  }
} 
```
