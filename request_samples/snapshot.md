putting some request to play with snapshot.

https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-register-repository.html

```
PUT /_snapshot/my_backup
{
  "type": "fs",
  "settings": {
    "location": "/Users/surfer/elastic/labs/7.6.0/elasticsearch/repo"
  }
}
```

```
PUT /_snapshot/my_backup/snapshot_2?wait_for_completion=true
```

- viewing content of snapshot

```
GET /_snapshot/_all
GET /_snapshot/my_backup/_all
```
