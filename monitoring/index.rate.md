**1. enable slow log against the index you are interested in.**


```
PUT .monitoring-es-6-2018.10.29/_settings
{
 "index.search.slowlog.threshold.query.debug": "0ms"
}
```

**2. Look for `indices_stats._all.total.indexing.index_total` in slow log file.**

`ag indices_stats._all.total.indexing.index_total elasticsearch_index_search_slowlog.log`
(Assuming `elasticsearch` is your cluster name)

The metric name is found in this file.

https://github.com/elastic/kibana/blob/master/x-pack/plugins/monitoring/server/lib/metrics/elasticsearch/metrics.js

**3. Once the request is found, you can parse it and replay in Kibana.**

Assuming the line containing the relevant request is found in line 10 of elasticsearch_index_search_slowlog.log

```
sed -n 10p elasticsearch_index_search_slowlog.log > bingo.log
sh slow.log.parser.sh bingo.log | pbcopy
```

slow.log.parser.sh should look like this.

```
if [ $# -eq 0 ]
  then
    echo "No arguments supplied"
    echo "Please specify full path to slow log file"
    exit
fi
path=$1

cat $path | while read line
do
	index=$(echo $line | awk -F ' ' '{print $3}' | sed -e 's/^\[//' -e s/\]// | awk -F '[' '{print $1}')
	echo "GET $index/_search"
	echo $line | awk -F ' ' '{print $11}' | sed -e s,^source,,  -e 's/^\[//'  -e s/\],$// | jq -r  . 
	echo ""
done
```

**4. The query should now look like this**
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
```

**5. `metric_deriv` should be the Index Rate found in monitoring UI**

```
        {
          "key_as_string": "2018-10-29T06:03:30.000Z",
          "key": 1540793010000,
          "doc_count": 3,
          "metric": {
            "value": 5202
          },
          "metric_deriv": {
            "value": 5202,
            "normalized_value": 173.4
          }
        },
```


**6. disable slow log**
Once you capture the monitoring request, you can turn off slowlog.

```
PUT .monitoring-es-6-2018.10.29/_settings
{
 "index.search.slowlog.threshold.query.debug": "-1"
}
```
