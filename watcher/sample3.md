PUT foo/_doc/1
{
  "name": {
    "first": "Kobe",
    "last": "Bryant"
  }
} 
PUT foo/_doc/2
{
  "name": {
    "first": "Stephen",
    "last": "Curry"
  }
} 

PUT foo/_doc/3
{
  "name": {
    "first": "Dirk",
    "last": "Nowitzki"
  }
} 

DELETE foo

PUT /_watcher/watch/mustache-test
{
  "trigger": {
    "schedule": {
      "interval": "1h"
    }
  },
  "input": {
    "http": {
      "request": {
        "host": "localhost",
        "port": 9200,
        "path": "/foo/_search",
             "auth" : {
        "basic" : {
          "username" : "elastic",
          "password" : "changeme"
        }
      }
      }
    }
  },
  "actions": {
    "log": {
      "logging": {
        "text": "{{ctx.payload.hits.hits.0._source.name.first}}"
      }
    }
  }
} 



POST _xpack/watcher/watch/mustache-test/_execute

GET /_watcher/watch/mustache-test



```
