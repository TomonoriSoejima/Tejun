```
PUT /_watcher/watch/status-check
{
  "trigger": {
    "schedule": {
      "hourly": {
        "minute": 30
      }
    }
  },
  "input": {
    "http": {
      "request": {
        "host": "localhost",
        "port": 9200,
        "method": "get",
        "path": "_nodes/stats/indices/fielddata"
      }
    }
  },
  "metadata": {
    "node1": "Z4mhl4m8RLSFwZusaUWE-w",
    "threshhold": 400
  },
  "condition": {
    "script": {
      "source": """
      return ctx.payload.nodes[ctx.metadata.node1].indices.fielddata.memory_size_in_bytes > ctx.metadata.threshhold;
      
      """
    }
  },
  "actions": {
    "log": {
      "logging": {
        "text": "fielddata usage is high"
      }
    }
  }
} 

POST _watcher/watch/status-check/_execute
```
