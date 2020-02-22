## You need to create job and datafeed to play with anomaly detection.

```
PUT _ml/anomaly_detectors/helloml
{
	"description": "",
	"analysis_config": {
		"bucket_span": "15m",
		"detectors": [
			{
				"function": "mean",
				"field_name": "bytesSent"
			}
		],
		"influencers": [],
		"summary_count_field_name": "doc_count"
	},
	"data_description": {
		"time_field": "@timestamp",
		"time_format": "epoch_ms"
	}
}


PUT _ml/datafeeds/datafeed-helloml
{
  "indices": [
    "user*"
  ],
  "query": {
    "bool": {
      "must": [
        {
          "match_all": {}
        }
      ]
    }
  },
  "scroll_size": 1000,
  "chunking_config": {
    "mode": "manual",
    "time_span": "90000000ms"
  },
  "delayed_data_check_config": {
    "enabled": true
  },
  "job_id": "helloml",
  "datafeed_id": "datafeed-helloml",
  "aggregations": {
    "buckets": {
      "date_histogram": {
        "field": "@timestamp",
        "fixed_interval": "90000ms"
      },
      "aggregations": {
        "bytesSent": {
          "avg": {
            "field": "bytesSent"
          }
        },
        "@timestamp": {
          "max": {
            "field": "@timestamp"
          }
        }
      }
    }
  }
}

POST _ml/anomaly_detectors/helloml/_open
POST _ml/datafeeds/datafeed-helloml/_start
```

`curl -H 'Content-Type: application/x-ndjson' -XPOST 'localhost:9200/_bulk?pretty' --data-binary @user-activity.json`

you can downlod [user-activity.json]()
