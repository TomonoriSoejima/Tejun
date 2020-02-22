## you need to fee data first.


1. create index

`curl -H 'Content-Type: application/x-ndjson' -XPOST 'localhost:9200/_bulk?pretty' --data-binary @user-activity.json`

2. create index pattern

```
curl --location --request POST 'http://localhost:5601/api/saved_objects/index-pattern/hotel' \
--header 'kbn-xsrf: True' \
--header 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{
"attributes": {
 "title": "hotel*",
 "timeFieldName": "created"
 }
}'
```
3. create job
4. create datafeed
5. open the job
6. start the datafeed


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

