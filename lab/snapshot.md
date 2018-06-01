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
```
