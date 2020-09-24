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
  },
  "docs": [
    {
      "_index": "index",
      "_id": "id",
      "_source": {
        "name": [""]
      }
    }
  ]
}
```

- error

```
{
  "docs" : [
    {
      "processor_results" : [
        {
          "error" : {
            "root_cause" : [
              {
                "type" : "script_exception",
                "reason" : "runtime error",
                "script_stack" : [
                  "java.base/java.util.StringTokenizer.nextToken(StringTokenizer.java:349)",
                  "doc.put(\"first\", st.nextToken()); \n                  String ",
                  "                   ^---- HERE"
                ],
                "script" : """
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
              """,
                "lang" : "painless",
                "position" : {
                  "offset" : 311,
                  "start" : 292,
                  "end" : 352
                }
              }
            ],
            "type" : "script_exception",
            "reason" : "runtime error",
            "script_stack" : [
              "java.base/java.util.StringTokenizer.nextToken(StringTokenizer.java:349)",
              "doc.put(\"first\", st.nextToken()); \n                  String ",
              "                   ^---- HERE"
            ],
            "script" : """
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
              """,
            "lang" : "painless",
            "position" : {
              "offset" : 311,
              "start" : 292,
              "end" : 352
            },
            "caused_by" : {
              "type" : "no_such_element_exception",
              "reason" : null
            }
          }
        }
      ]
    }
  ]
}
```
