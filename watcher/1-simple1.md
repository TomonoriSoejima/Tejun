```
PUT /_watcher/watch/simple_test
{
  "trigger": {
    "schedule": {
      "daily": {
        "at": "noon"
      }
    }
  },
  "input": {
    "simple": {
      "field1": "John",
      "src": [
        "host1",
        "host2"
      ],
      "src_ports": [
        "port1",
        "port2"
      ],
      "importance": "important"
    }
  },
  "actions": {
    "log": {
      "logging": {
        "text": "alert received \n host {{ctx.payload.src}} \n src_ports {{ctx.payload.src_ports}} \n important {{ctx.payload.importance}}"
      }
    }
  }
}


POST _watcher/watch/simple_test/_execute

```

This code creates a watcher that runs daily at noon. The watcher is triggered by a schedule and then performs an action. 

The schedule is set to run at noon daily using the "daily" option. 

The input for the watcher is defined using the "simple" option. It provides values for "field1", "src", "src_ports", and "importance". 

The actions section defines the action to be performed by the watcher. In this case, it logs a message with the received alert, the source hosts, source ports, and the importance value. 

To execute the watcher immediately, a POST request is made to `_watcher/watch/simple_test/_execute`.

For more information on the syntax and options used in this code, you can refer to the following documentation:

- [Watcher API documentation](https://www.elastic.co/guide/en/elasticsearch/reference/current/watcher-api.html)
- [Schedule documentation](https://www.elastic.co/guide/en/elasticsearch/reference/current/watcher-api.html#watcher-schedule)
- [Input documentation](https://www.elastic.co/guide/en/elasticsearch/reference/current/watcher-api.html#watcher-input)
- [Actions documentation](https://www.elastic.co/guide/en/elasticsearch/reference/current/watcher-api.html#watcher-action)

