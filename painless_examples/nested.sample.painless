DELETE test2

PUT test2/test/1
{
  "address": "tokyo",
  "name": [
    {
      "first": "elastic",
      "last" : "tiger"
    }
  ]
}

GET test2/_search

GET test2/_search
{
  "size": 20, 
   "_source": [
    "address",
    "company.name"
  ],
  "query": {
    "match_all": {}
  },
  "script_fields": {
    "today": {
      "script": {
        "lang": "painless",
        "source": "params._source.name[0].first + ' guy'"
      }
    }
  }
}
