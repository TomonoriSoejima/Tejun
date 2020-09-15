```
POST /_ingest/pipeline/_simulate?verbose
{
  "pipeline": {
    "description": "do something",
    "processors": [
      {
        "rename": {
          "field": "name",
          "target_field": "name1"
        },
        "dissect": {
          "field": "name1",
          "pattern": "%{name.first} %{name.last}"
        },
        "remove": {
          "field": [
            "name1"
          ]
        }
      }
    ]
  },
  "docs": [
    {
      "_index": "index",
      "_id": "id",
      "_source": {
        "name": "Taro Suzuki"
      }
    }
  ]
}

# response

 ```
