### How to get started with Kibana map

1. create a mapping 

<details>
  <summary>mapping</summary>

```
{
    "mappings" : {
      "properties" : {
        "cell" : {
          "type" : "text",
          "fields" : {
            "keyword" : {
              "type" : "keyword",
              "ignore_above" : 256
            }
          }
        },
        "dob" : {
          "properties" : {
            "age" : {
              "type" : "long"
            },
            "date" : {
              "type" : "date"
            }
          }
        },
        "email" : {
          "type" : "text",
          "fields" : {
            "keyword" : {
              "type" : "keyword",
              "ignore_above" : 256
            }
          }
        },
        "gender" : {
          "type" : "text",
          "fields" : {
            "keyword" : {
              "type" : "keyword",
              "ignore_above" : 256
            }
          }
        },
        "id" : {
          "properties" : {
            "name" : {
              "type" : "text",
              "fields" : {
                "keyword" : {
                  "type" : "keyword",
                  "ignore_above" : 256
                }
              }
            },
            "value" : {
              "type" : "text",
              "fields" : {
                "keyword" : {
                  "type" : "keyword",
                  "ignore_above" : 256
                }
              }
            }
          }
        },
        "location" : {
          "properties" : {
            "city" : {
              "type" : "text",
              "fields" : {
                "keyword" : {
                  "type" : "keyword",
                  "ignore_above" : 256
                }
              }
            },
            "country" : {
              "type" : "text",
              "fields" : {
                "keyword" : {
                  "type" : "keyword",
                  "ignore_above" : 256
                }
              }
            },
            "geo" : {
              "type" : "geo_point",
              "fields" : {
                "keyword" : {
                  "type" : "keyword",
                  "ignore_above" : 256
                }
              }
            },
            "postcode" : {
              "type" : "text",
              "fields" : {
                "keyword" : {
                  "type" : "keyword",
                  "ignore_above" : 256
                }
              }
            },
            "state" : {
              "type" : "text",
              "fields" : {
                "keyword" : {
                  "type" : "keyword",
                  "ignore_above" : 256
                }
              }
            },
            "street" : {
              "properties" : {
                "name" : {
                  "type" : "text",
                  "fields" : {
                    "keyword" : {
                      "type" : "keyword",
                      "ignore_above" : 256
                    }
                  }
                },
                "number" : {
                  "type" : "long"
                }
              }
            },
            "timezone" : {
              "properties" : {
                "description" : {
                  "type" : "text",
                  "fields" : {
                    "keyword" : {
                      "type" : "keyword",
                      "ignore_above" : 256
                    }
                  }
                },
                "offset" : {
                  "type" : "text",
                  "fields" : {
                    "keyword" : {
                      "type" : "keyword",
                      "ignore_above" : 256
                    }
                  }
                }
              }
            }
          }
        },
        "name" : {
          "properties" : {
            "first" : {
              "type" : "text",
              "fields" : {
                "keyword" : {
                  "type" : "keyword",
                  "ignore_above" : 256
                }
              }
            },
            "last" : {
              "type" : "text",
              "fields" : {
                "keyword" : {
                  "type" : "keyword",
                  "ignore_above" : 256
                }
              }
            },
            "title" : {
              "type" : "text",
              "fields" : {
                "keyword" : {
                  "type" : "keyword",
                  "ignore_above" : 256
                }
              }
            }
          }
        },
        "nat" : {
          "type" : "text",
          "fields" : {
            "keyword" : {
              "type" : "keyword",
              "ignore_above" : 256
            }
          }
        },
        "phone" : {
          "type" : "text",
          "fields" : {
            "keyword" : {
              "type" : "keyword",
              "ignore_above" : 256
            }
          }
        },
        "registered" : {
          "properties" : {
            "age" : {
              "type" : "long"
            },
            "date" : {
              "type" : "date"
            }
          }
        }
      }
    }
} 
```
</details>


2. send data
3. create index pattern 

you want to install https://httpie.org/ first.

https://httpie.org/docs#installation lists how to install on your platform.


```
output="100.json"

# delete old index
http delete localhost:9200/people
# create mapping
http put localhost:9200/people < mapping.json 

http get https://randomuser.me/api?results=300 | jq -c '.results[] | { index: {_index:"people", _id:.login.uuid }},  .location += {geo: (.location.coordinates.latitude + "," +  .location.coordinates.longitude)} | del (.location.coordinates, .picture, .info, .login)' > $output
http localhost:9200/_bulk < $output

# create index pattern

printf '{
"attributes": {
 "title": "people*",
 "timeFieldName": "registered.date"
 }
}'| http  --follow --timeout 3600 post localhost:5601/api/saved_objects/index-pattern/people \
 kbn-xsrf:'True' \
 Content-Type:'application/json;charset=UTF-8' \
 Authorization:'Basic ZWxhc3RpYzpEU09hclFsMlRkdlllQk5vdlN1dA==' \
 Content-Type:'text/plain'
```



4. import the attachd map configuration

`http -f POST localhost:5601/api/saved_objects/_import kbn-xsrf:true file@export.ndjson`

5. Map object is now created
