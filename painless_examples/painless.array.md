
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

doc : https://www.elastic.co/guide/en/elasticsearch/painless/current/painless-field-context.html
