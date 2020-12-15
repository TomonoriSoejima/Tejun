```
POST _watcher/watch/_execute
{
  "watch": {
    "trigger": {
      "schedule": {
        "interval": "10h"
      }
    },
    "input": {
      "simple": {
        "aggregations": {
          "failed_urls": {
            "buckets": [
              {
                "doc_count": 30,
                "failed_in_hostname": {
                  "doc_count_error_upper_bound": 0,
                  "sum_other_doc_count": 13,
                  "buckets": [
                    {
                      "doc_count": 4,
                      "key": "bwp10427071"
                    },
                    {
                      "doc_count": 4,
                      "key": "bwp10427072"
                    },
                    {
                      "doc_count": 4,
                      "key": "bwp10427075"
                    },
                    {
                      "doc_count": 3,
                      "key": "bwp10427070"
                    },
                    {
                      "doc_count": 2,
                      "key": "bwp10427020"
                    }
                  ]
                },
                "key": "http@http://localhost:61020/BT.SaaS.MDMAPI.CustomerService/CustomerService.svc"
              },
              {
                "doc_count": 30,
                "failed_in_hostname": {
                  "doc_count_error_upper_bound": 0,
                  "sum_other_doc_count": 13,
                  "buckets": [
                    {
                      "doc_count": 4,
                      "key": "bwp10427071"
                    },
                    {
                      "doc_count": 4,
                      "key": "bwp10427072"
                    },
                    {
                      "doc_count": 4,
                      "key": "bwp10427075"
                    },
                    {
                      "doc_count": 3,
                      "key": "bwp10427070"
                    },
                    {
                      "doc_count": 2,
                      "key": "bwp10427020"
                    }
                  ]
                },
                "key": "http@http://localhost:61020/BT.SaaS.MDMAPI.ProductMappingService/ProductMappingService.svc"
              },
              {
                "doc_count": 30,
                "failed_in_hostname": {
                  "doc_count_error_upper_bound": 0,
                  "sum_other_doc_count": 13,
                  "buckets": [
                    {
                      "doc_count": 4,
                      "key": "bwp10427071"
                    },
                    {
                      "doc_count": 4,
                      "key": "bwp10427072"
                    },
                    {
                      "doc_count": 4,
                      "key": "bwp10427075"
                    },
                    {
                      "doc_count": 3,
                      "key": "bwp10427070"
                    },
                    {
                      "doc_count": 2,
                      "key": "bwp10427020"
                    }
                  ]
                },
                "key": "http@http://localhost:61020/BT.SaaS.MDMAPI.ProductService/BillingTariffService.svc"
              },
              {
                "doc_count": 30,
                "failed_in_hostname": {
                  "doc_count_error_upper_bound": 0,
                  "sum_other_doc_count": 13,
                  "buckets": [
                    {
                      "doc_count": 4,
                      "key": "bwp10427071"
                    },
                    {
                      "doc_count": 4,
                      "key": "bwp10427072"
                    },
                    {
                      "doc_count": 4,
                      "key": "bwp10427075"
                    },
                    {
                      "doc_count": 3,
                      "key": "bwp10427070"
                    },
                    {
                      "doc_count": 2,
                      "key": "bwp10427020"
                    }
                  ]
                },
                "key": "http@http://localhost:61020/BT.SaaS.MDMAPI.ProductService/CacheService.svc"
              },
              {
                "doc_count": 30,
                "failed_in_hostname": {
                  "doc_count_error_upper_bound": 0,
                  "sum_other_doc_count": 13,
                  "buckets": [
                    {
                      "doc_count": 4,
                      "key": "bwp10427071"
                    },
                    {
                      "doc_count": 4,
                      "key": "bwp10427072"
                    },
                    {
                      "doc_count": 4,
                      "key": "bwp10427075"
                    },
                    {
                      "doc_count": 3,
                      "key": "bwp10427070"
                    },
                    {
                      "doc_count": 2,
                      "key": "bwp10427020"
                    }
                  ]
                },
                "key": "http@http://localhost:61020/BT.SaaS.MDMAPI.ProductService/DiscountDataService.svc"
              }
            ]
          }
        }
      }
    },
    "actions": {
      "log_hits": {
        "logging": {
          "text": 
          """
           {{#ctx.payload.aggregations.failed_urls.buckets}} 
             Monitor.id - {{key}}
             host -
             {{#failed_in_hostname.buckets}}
              {{key}}
             {{/failed_in_hostname.buckets}}
           {{/ctx.payload.aggregations.failed_urls.buckets}}"
          """
        }
      }
    }
  }
}
```
