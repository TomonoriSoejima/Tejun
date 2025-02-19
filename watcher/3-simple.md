```
DELETE foo

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



POST _watcher/watch/mustache-test/_execute

GET /_watcher/watch/mustache-test



```


This code is performing various actions using Elasticsearch and Watcher.

1. It starts by deleting the index called "foo".
   - [DELETE API Documentation](https://www.elastic.co/guide/en/elasticsearch/reference/current/docs-delete.html)

2. Then it creates three documents in the "foo" index, each containing a name with a "first" and "last" attribute.
   - [PUT API Documentation](https://www.elastic.co/guide/en/elasticsearch/reference/current/docs-create.html)

3. Next, it creates a Watcher with the ID "mustache-test".
   - [PUT Watch API Documentation](https://www.elastic.co/guide/en/elasticsearch/reference/current/watcher-api-put-watch.html)

4. The Watcher is triggered every 1 hour to execute an HTTP request to the Elasticsearch cluster on localhost and port 9200. It sends a GET request to the "/foo/_search" path with basic authentication.
   - [Watcher Documentation](https://www.elastic.co/guide/en/elasticsearch/reference/current/watcher-api.html)

5. After the response is received, the value of the first name from the first hit in the search results is logged.
   - [Logging Action Documentation](https://www.elastic.co/guide/en/elasticsearch/reference/current/actions-logging.html)

6. The Watcher is then manually executed using the `POST _xpack/watcher/watch/mustache-test/_execute` API.
   - [Watcher Execution API Documentation](https://www.elastic.co/guide/en/elasticsearch/reference/current/watcher-api-execute-watch.html)

7. Finally, the Watcher configuration is retrieved using the `GET /_watcher/watch/mustache-test` API.
   - [GET Watch API Documentation](https://www.elastic.co/guide/en/elasticsearch/reference/current/watcher-api-get-watch.html)
