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



## PUT this into action

```
PUT /_ingest/pipeline/my_index
{
 "description": "do something",
 "processors": [
   {
        "script": {
          "lang": "painless",
             "source": """
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
              ctx.name = al;
              """
        }
   }
 ]
}



PUT any_index/_doc/1?pipeline=my_index
{
  "name": [
          "John Tiger",
          "Mike Shark",
          "Tom Tiger",
          "Kris Tiger"
        ]
} 

PUT any_index/_doc/2?pipeline=my_index
{
  "name": [
          "John Tiger",
          "Mike Tiger",
          "Tom Tiger",
          "Kris Tiger"
        ]
} 



GET any_index/_search
{
  "size": 500,
  "query": {
    "bool": {
      "must": [],
      "filter": [
        {
          "bool": {
            "filter": [
              {
                "bool": {
                  "should": [
                    {
                      "match_phrase": {
                        "name.last.keyword": "Tiger"
                      }
                    }
                  ],
                  "minimum_should_match": 1
                }
              },
              {
                "bool": {
                  "should": [
                    {
                      "match": {
                        "last_name_same": true
                      }
                    }
                  ],
                  "minimum_should_match": 1
                }
              }
            ]
          }
        }
      ]
    }
  }
}
```
