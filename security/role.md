How to test role

### 1. Create a role
```
POST /_xpack/security/role/hotel-japan
{
  "run_as": [ "harutan" ],
  "cluster": [ "monitor" ],
  "indices": [
    {
      "names": [ "hotel" ],
      "privileges": [ "read" ],
      "field_security" : {
        "grant" : [ "country", "city", "star" ]
      },
      "query": "{\"match\": {\"country\": \"japan\"}}"
    }
  ]
}

GET /_xpack/security/role/hotel-japan
```

### 2. Create a user with the role you just created.

```
POST /_xpack/security/user/harutan
{
  "password" : "harutokun",
  "roles" : [ "hotel-japan" ],
  "full_name" : "Haruto",
  "email" : "haruto@harumi.com"
}
```

### 3. Run sample requests in all.sh
```
curl -s -u harutan:harutokun -XGET 'localhost:9200/hotel/_search?size=0' -H 'Content-Type: application/json' 
curl -s -u elastic:changeme -XGET 'localhost:9200/hotel/_search?size=0' -H 'Content-Type: application/json' 
```

#### Note that 2nd query returns 20 documents while 1st only returns 2 documents.
```
[mbp:user.role.test]$ sh all.sh | jq
{
  "took": 0,
  "timed_out": false,
  "_shards": {
    "total": 5,
    "successful": 5,
    "failed": 0
  },
  "hits": {
    "total": 2,
    "max_score": 0,
    "hits": []
  }
}
{
  "took": 0,
  "timed_out": false,
  "_shards": {
    "total": 5,
    "successful": 5,
    "failed": 0
  },
  "hits": {
    "total": 20,
    "max_score": 0,
    "hits": []
  }
}
```
