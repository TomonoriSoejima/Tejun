```
GET small_clinic/_search?size=1
{
  "script_fields": {
    "test": {
      "script": {
        "source": """
        
        return params._source.treatment_menu.stream().filter(e -> e.display_order == 5)
        .collect(Collectors.toList());
        
        """
      }
    }
  }
}
```
