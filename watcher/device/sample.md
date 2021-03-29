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
  "aggregations" : {
    "severity" : {
      "doc_count_error_upper_bound" : 0,
      "sum_other_doc_count" : 0,
      "buckets" : [
        {
          "key" : "3",
          "doc_count" : 1282,
          "device" : {
            "doc_count_error_upper_bound" : 0,
            "sum_other_doc_count" : 20,
            "buckets" : [
              {
                "key" : "10.120.203.0",
                "doc_count" : 1015
              },
              {
                "key" : "10.120.143.105",
                "doc_count" : 66
              },
              {
                "key" : "10.120.143.71",
                "doc_count" : 64
              },
              {
                "key" : "10.120.141.89",
                "doc_count" : 45
              },
              {
                "key" : "10.120.140.154",
                "doc_count" : 33
              }
            ]
          }
        },
        {
          "key" : "5",
          "doc_count" : 504,
          "device" : {
            "doc_count_error_upper_bound" : 0,
            "sum_other_doc_count" : 0,
            "buckets" : [
              {
                "key" : "10.120.143.105",
                "doc_count" : 205
              },
              {
                "key" : "10.120.143.71",
                "doc_count" : 186
              },
              {
                "key" : "10.120.140.154",
                "doc_count" : 58
              },
              {
                "key" : "10.120.140.155",
                "doc_count" : 40
              }
            ]
          }
        },
        {
          "key" : "4",
          "doc_count" : 147,
          "device" : {
            "doc_count_error_upper_bound" : 0,
            "sum_other_doc_count" : 0,
            "buckets" : [
              {
                "key" : "10.120.136.66",
                "doc_count" : 31
              },
              {
                "key" : "10.120.141.63",
                "doc_count" : 28
              },
              {
                "key" : "10.120.141.62",
                "doc_count" : 22
              },
              {
                "key" : "10.120.136.68",
                "doc_count" : 20
              }
            ]
          }
        }
      ]
    }
        }
      }
    },
    "actions": {
      "log_hits": {
        "logging": {
          "text": """
           {{#ctx.payload.aggregations.severity.buckets}} 
            
            key : {{key}}
            
             {{#device.buckets}}
             doc_count : {{doc_count}}
            device :  {{key}}
             {{/device.buckets}}
           {{/ctx.payload.aggregations.severity.buckets}}"
          """
        }
      }
    }
  }
}
```
