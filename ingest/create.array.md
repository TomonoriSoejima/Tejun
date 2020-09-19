due to the problem https://github.com/elastic/elasticsearch/issues/62674, I used script processor.



```
POST /_ingest/pipeline/_simulate?verbose
{
  "pipeline": {
    "description": "do something",
    "processors": [
      {
        "script": {
          "lang": "painless",
             "source": """
               ArrayList al = new ArrayList();
          
               for (item in ctx.name) {
                  StringTokenizer st = new StringTokenizer(item);
                  Map doc = new HashMap(); 
                  doc.put("first", st.nextToken()); 
                  doc.put("last", st.nextToken()); 
                  al.add(doc);
               }
          
               ctx.name = al;
        """
        }
      }
    ]
  },
  "docs": [
    {
      "_index": "index",
      "_id": "id",
      "_source": {
        "name": [
          "John Tiger",
          "Mike Shark"
        ]
      }
    }
  ]
}
```

- response

```
{
  "docs" : [
    {
      "processor_results" : [
        {
          "doc" : {
            "_index" : "index",
            "_type" : "_doc",
            "_id" : "id",
            "_source" : {
              "name" : [
                {
                  "last" : "Tiger",
                  "first" : "John"
                },
                {
                  "last" : "Shark",
                  "first" : "Mike"
                }
              ]
            },
            "_ingest" : {
              "pipeline" : "_simulate_pipeline",
              "timestamp" : "2020-09-19T06:36:31.10554Z"
            }
          }
        }
      ]
    }
  ]
}
```
