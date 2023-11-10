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
      "simple": {
        "data": [
          {
            "ipAddress": "196.216.89.89",
            "countryCode": "ZA",
            "abuseConfidenceScore": 100,
            "lastReportedAt": "2023-11-09T11:17:01+00:00",
            "@timestamp": "2023-11-09T11:42:28.603Z"
          },
          {
            "ipAddress": "181.47.247.179",
            "countryCode": "AR",
            "abuseConfidenceScore": 100,
            "lastReportedAt": "2023-11-09T11:17:01+00:00",
            "@timestamp": "2023-11-09T11:42:28.603Z"
          },
          {
            "ipAddress": "178.128.84.226",
            "countryCode": "SG",
            "abuseConfidenceScore": 100,
            "lastReportedAt": "2023-11-09T11:17:01+00:00",
            "@timestamp": "2023-11-09T11:42:28.603Z"
          }
        ]
      }
    },
    "condition": {
      "always": {}
    },
    "actions": {
      "index_payload": {
        "foreach": "ctx.payload.data",
        "index": {
          "index": "my-index-000001"
         
        }
      }
    }
  }
}
```
