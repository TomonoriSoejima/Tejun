## add documents

```
DELETE test
PUT test
POST test/_doc/1
{
  "field1" : "test"
}

POST test/_doc/2
{
  "field1" : "test",
  "field2" : "test"
}

GET test/_refresh

GET test/_search
GET test
```

## delete 1 document

```
POST /test/_update/2
{
    "script" : "ctx._source.remove(\"field2\")"
}
```

## add 2 documents that has field2 respectively  

```
DELETE test
PUT test
POST test/_doc/1
{
  "field1" : "test"
}

POST test/_doc/2
{
  "field1" : "test",
  "field2" : "test_1"
}

POST test/_doc/3
{
  "field1" : "test",
  "field2" : "test_1"
}
```

## remove field2 field if the documents has it.

```
POST test/_update_by_query?conflicts=proceed
{
      "query": {
        "exists": {
            "field": "field2"
        }
    },
   "script" : "ctx._source.remove(\"field2\")"
}
```
