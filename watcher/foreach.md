- sample data
```
POST test_a/_bulk
{"index": {"_id": "1"}}
{"tenantId": "001", "eventId": "111", "memo": "test1","@timestamp": "yyyy-MM-dd'T'HH:mm:ss.SSS+09:00"}
{"index": {"_id": "2"}}
{"tenantId": "002", "eventId": "111", "memo": "test2","@timestamp": "yyyy-MM-dd'T'HH:mm:ss.SSS+09:00"}
{"index": {"_id": "3"}}
{"tenantId": "001", "eventId": "111", "memo": "test3","@timestamp": "yyyy-MM-dd'T'HH:mm:ss.SSS+09:00"}

POST test_b/_bulk
{"index": {"_id": "1"}}
{"tenantId": "001", "address": "aaa@test.com"}
{"index": {"_id": "2"}}
{"tenantId": "002", "address": "bbb@test.com"}
```


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
                                    "tenantId",
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
    "transform": {
      "script": {
        "source": """
          List test_b_set = new ArrayList();
         
          for (int i = 0; i < ctx.payload.test_b.hits.hits.size(); ++i) {
            Map document = new HashMap();
            def address = ctx.payload.test_b.hits.hits[i]._source.address;
            def tenantId = ctx.payload.test_b.hits.hits[i]._source.tenantId;
            document.put("address", address);
            document.put("tenantId", tenantId);

            test_b_set.add(document);
          }
          
          
          List result_set = new ArrayList();
         
          for (int i = 0; i < ctx.payload.test_a.aggregations.tenants.buckets.size(); ++i) {
            Map document = new HashMap();
              def tenantId =  ctx.payload.test_a.aggregations.tenants.buckets[i].key;
              
              // check if key is found in test_b index
              for (HashMap hashmap : test_b_set) {
                if (hashmap.tenantId == tenantId) {
                  
                  document.put("address", hashmap.address);
                }
              }
              
              // handling memo
              def memo_count = ctx.payload.test_a.aggregations.tenants.buckets[i].events.data.hits.hits.size();
              List memos = new ArrayList();
              for (int j = 0; j < memo_count; ++j) {
                   memos.add(ctx.payload.test_a.aggregations.tenants.buckets[i].events.data.hits.hits[j]._source.memo);
              }
           
              document.put("memo", memos);
              result_set.add(document);
          }       

        
        return ['data_merged' : result_set];
        """
      }
    },
    "actions": {
      "log_hits": {
        "foreach": "ctx.payload.data_merged",
        "max_iterations": 500,
        "logging": {
          "text": """
           {{ctx.payload}}
          """
        }
      }
    }
  }
}
```
