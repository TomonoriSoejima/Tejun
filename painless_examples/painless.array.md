
```
GET small_clinic/_search?size=1
{
  "script_fields": {
    "test": {
      "script": {
        "source": "return params['_source']['array_field']"
      }
    }
  }
}
```
with `inline` you can see in better format.

```
GET small_clinic/_search?size=1
{
  "script_fields": {
    "test": {
      "script": {
             "lang": "painless",
        "inline" : """
         return params['_source']['treatment_menu']
        """
      }
    
    }
  }
}
```

doc : https://www.elastic.co/guide/en/elasticsearch/painless/current/painless-field-context.html
