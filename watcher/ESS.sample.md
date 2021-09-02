```
PUT _watcher/watch/cluster_health_watch
{
  "trigger" : {
    "schedule" : { "interval" : "10s" }
  },
  "input" : {
    "http" : {
      "request" : {
        "host" : "adb10606800a47cd8e0050f699892f0e.asia-northeast1.gcp.cloud.es.io",
        "scheme": "https",
        "port" : 9243,
        "path" : "/_cluster/health",
        "auth": {
          "basic": {
            "username": "elastic",
            "password": "xxxxx"
          }
        }
      }
    }
  }
}


POST _watcher/watch/cluster_health_watch/_execute
```
