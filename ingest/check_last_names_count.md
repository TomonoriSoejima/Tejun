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
            
            int max_unique_last_name = 2;

            ArrayList al = new ArrayList();
             
            Set last_names = new HashSet();
             
            for (item in ctx.name) {
                StringTokenizer st = new StringTokenizer(item);
                Map doc = new HashMap(); 
                doc.put("first", st.nextToken()); 
                String last_name =  st.nextToken();
                doc.put("last", last_name); 
                al.add(doc);
                last_names.add(last_name);
            }
             
            ctx.last_name_same = (last_names.size() == 1) ? true : false;
            ctx.has_2_unique_last_names = (last_names.size() == max_unique_last_name) ? true : false;
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
          "John Tiger",
          "Mike Shark",
          "Tom Tiger",
          "Kris Tiger"
        ]
      }
    }
  ]
}
```

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
                  "last" : "Tiger",
                  "first" : "John"
                },
                {
                  "last" : "Shark",
                  "first" : "Mike"
                },
                {
                  "last" : "Tiger",
                  "first" : "Tom"
                },
                {
                  "last" : "Tiger",
                  "first" : "Kris"
                }
              ],
              "last_name_same" : false,
              "has_2_unique_last_names" : true
            },
            "_ingest" : {
              "pipeline" : "_simulate_pipeline",
              "timestamp" : "2020-09-24T11:10:28.417665Z"
            }
          }
        }
      ]
    }
  ]
}
```
