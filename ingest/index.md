```
PUT _ingest/pipeline/my_index
{
  "description": "use index:my_index",
  "processors": [
    {
      "script": {
        "source": """
            def type = ctx.message;
            if (type == 'apache') { ctx._index = 'apache-log';}
            if (type == 'appA') { ctx._index = 'appa-log';}
         """
      }
    }
  ]
}


PUT any_index/_doc/1?pipeline=my_index
{
  "message": "apache"
}
PUT any_index/_doc/2?pipeline=my_index
{
  "message": "appA"
}


GET apache-log/_search

GET appa-log/_search
```
