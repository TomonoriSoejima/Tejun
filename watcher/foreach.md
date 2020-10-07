```
PUT _watcher/watch/_execute
{
  "watch": {
    "trigger": {
      "schedule": {
        "interval": "5m"
      }
    },
    "input": {
      "chain": {
        "inputs": [
          {
            "test_a": {
              "search": {
                "request": {
                  "search_type": "query_then_fetch",
                  "indices": [
                    "test_a"
                  ],
                  "rest_total_hits_as_int": true,
                  "body": {
                    "size": 0,
                    "query": {
                      "range": {
                        "@timestamp": {
                          "gte": "{{ctx.trigger.scheduled_time}}||-2m"
                        }
                      }
                    },
                    "aggs": {
                      "tenants": {
                        "terms": {
                          "field": "tenantId.keyword",
                          "size": 10
                        },
                        "aggs": {
                          "events": {
                            "filter": {
                              "exists": {
                                "field": "eventId"
                              }
                            },
                            "aggs": {
                              "data": {
                                "top_hits": {
                                  "size": 100,
                                  "_source": [
                                    "eventId",
                                    "memo"
                                  ]
                                }
                              }
                            }
                          },
                          "tenants": {
                            "filter": {
                              "exists": {
                                "field": "address"
                              }
                            },
                            "aggs": {
                              "data": {
                                "top_hits": {
                                  "size": 10,
                                  "_source": "address"
                                }
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }

          },
          {
            "test_b": {
              "search": {
                "request": {
                  "search_type": "query_then_fetch",
                  "indices": [
                    "test_b"
                  ],
                  "rest_total_hits_as_int": true,
                  "body": {
                    "size": 3,
                    "query": {
                      "match_all": {}
                    }
              
                  }
                }
              }
            }
          
          }
        ]
      }
    },
    "condition": {
      "always": {}
    },
    "actions": {
      "log_hits": {
        "foreach": "ctx.payload.test_a.aggregations.tenants.buckets",
        "max_iterations": 500,
        "logging": {
          "text": """
           tenantId : "{{ctx.payload.key}}"
           memo : {{#ctx.payload.events.data.hits.hits}}
           {{_source.memo}}
           {{/ctx.payload.events.data.hits.hits}}

      
          """
   
        }
      }
    }
  }
}
```
