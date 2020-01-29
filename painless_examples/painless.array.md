
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
    "display_order_2": {
      "script": {
        "lang": "painless",
        "inline" : """
         def sum = 0;
         for (item in params._source.treatment_menu) 
          if (item.display_order <= 2) {
            sum += item.display_order
          }
          return sum;
          
        """
      }
    
    }
  }
}

```

doc : https://www.elastic.co/guide/en/elasticsearch/painless/current/painless-field-context.html
