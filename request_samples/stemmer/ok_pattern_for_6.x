DELETE test2
PUT /test2
{
  "settings": {
    "analysis": {
      "analyzer": {
        "my_analyzer": {
          "tokenizer": "standard",
          "filter": [
            "standard",
            "lowercase",
            "my_stemmer"
          ]
        }
      },
      "filter": {
        "my_stemmer": {
          "type": "stemmer",
          "languages": [
            "english",
            "light_english",
            "minimal_english",
            "possessive_english",
            "porter2",
            "lovins"
          ]
        }
      }
    }
  },
  "mappings": {
    "test": {
      "properties": {
        "country": {
          "type": "text",
          "index": "true"
        },
        "hotel_name": {
          "type": "text",
          "analyzer": "my_analyzer"
        },
        "null_test": {
          "type": "text",
          "analyzer": "standard"
        },
        "message": {
          "type": "text"
        },
        "postDate": {
          "type": "date",
          "format": "strict_date_optional_time||epoch_millis"
        },
        "price": {
          "type": "long"
        },
        "user": {
          "type": "text"
        }
      }
    }
  }
}
 

PUT test2/test/4
{
  "hotel_name": "fdfa"
}
