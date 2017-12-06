POST hotel/_shrink/hotel2
{
  "settings": {
    "index.number_of_replicas": 1,
    "index.number_of_shards": 1, 
    "index.codec": "best_compression" 
  }
}




POST /_aliases
{
    "actions" : [
        { "add":  { "index": "hotel2", "alias": "hotel" } },
        { "remove_index": { "index": "hotel" } }  
    ]
}
