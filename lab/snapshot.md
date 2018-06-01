## create snapshot

```
PUT _snapshot/snap_test
{
    "type": "fs",
    "settings": {
        "location": "/Users/surfer/elastic/labs/6.2.4/snap",
        "compress": true
    }
}


PUT snaptest/type/1
{
  "name" : "test1"
}

PUT /_snapshot/snap_test/snap1?wait_for_completion=true
{
  "indices": "snaptest",
  "include_global_state": true
}


```
