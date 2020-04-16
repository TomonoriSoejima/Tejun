```GET filebeat-2020.04.07/_search?size=1
{
  "_source": [
    "@timestamp"
  ],
  "script_fields": {
    "changed_time": {
      "script": {
        "source": """
          def  datetime = doc['@timestamp'].value;
          String localStr1 = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(datetime);
          ZonedDateTime zdt = ZonedDateTime.parse(localStr1);
          ZonedDateTime updatedZdt = zdt.plusHours(2);
          return  updatedZdt;
        """
      }
    }
  }
}
```

```
{
  "took" : 2,
  "timed_out" : false,
  "_shards" : {
    "total" : 1,
    "successful" : 1,
    "skipped" : 0,
    "failed" : 0
  },
  "hits" : {
    "total" : {
      "value" : 20,
      "relation" : "eq"
    },
    "max_score" : 1.0,
    "hits" : [
      {
        "_index" : "filebeat-2020.04.07",
        "_type" : "_doc",
        "_id" : "CYRmUnEBMbRSjbdFb-S4",
        "_score" : 1.0,
        "_source" : {
          "@timestamp" : "2020-04-07T02:09:35.894Z"
        },
        "fields" : {
          "firstname" : [
            "2020-04-07T04:09:35.894Z"
          ]
        }
      }
    ]
  }
}
```
