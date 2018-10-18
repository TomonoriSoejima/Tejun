curl -X POST -H "Content-Type: application/json" -H "kbn-xsrf: true"  'http://localhost:5601/api/reporting/generate/csv?jobParams=(conflictedTypesFields:!(),fields:!(_id,_index,_score,_type,busy_month,capacity,city,cloesd,country,created,group,has_parking,hotel_name,menu,price,star),indexPatternId:f2334f70-d26c-11e8-b545-dbdac9813fee,metaFields:!(_source,_id,_type,_index,_score),searchRequest:(body:(_source:(excludes:!()),docvalue_fields:!((field:created,format:date_time)),query:(bool:(filter:!((match_all:())),must:!((range:(created:(format:epoch_millis,gte:1539218231049,lte:1539823031049)))),must_not:!(),should:!())),script_fields:(),sort:!((created:(order:desc,unmapped_type:boolean))),stored_fields:!(%27*%27),version:!t),index:%27hotel*%27),title:last.20.days,type:search)'


RESPONSE

{
  "path": "/api/reporting/jobs/download/jnduzxpo08lib17e282nlleu",
  "job": {
    "id": "jnduzxpo08lib17e282nlleu",
    "index": ".reporting-2018.10.14",
    "type": "esqueue",
    "jobtype": "csv",
    "created_by": false,
    "payload": {
      "headers": "WTW3XFtkm8B6THi2HaablveQ2NA4eaBcEsu2QSPIQo9XyaEEEE40scGs8PkAGs0xnb1GMHrqdIqMv6ULMRltBPh+w1vuj7VLJgCwNE3ksqzFFkFzXdlYzTiV8P6cDWtzMMXrBwyOVmTo0+LTAv+fGfUNS5BDLjEcETTJhU02U4ajwVmGVeJ195os4D7D81h/BnQKVZyXLHLtbbAJlXDf5A0UW7fGbEmbejyE+Fte1VriYBVobohzfYcTWj1uKTG0+kLG3ARDO08g2mNBAwj0e0PYig==",
      "indexPatternSavedObject": {
        "id": "f2334f70-d26c-11e8-b545-dbdac9813fee",
        "type": "index-pattern",
        "updated_at": "2018-10-18T00:30:01.021Z",
        "version": 2,
        "attributes": {
          "title": "hotel*",
          "timeFieldName": "created",
          "fields": "[{\"name\":\"_id\",\"type\":\"string\",\"count\":0,\"scripted\":false,\"searchable\":true,\"aggregatable\":true,\"readFromDocValues\":false},{\"name\":\"_index\",\"type\":\"string\",\"count\":0,\"scripted\":false,\"searchable\":true,\"aggregatable\":true,\"readFromDocValues\":false},{\"name\":\"_score\",\"type\":\"number\",\"count\":0,\"scripted\":false,\"searchable\":false,\"aggregatable\":false,\"readFromDocValues\":false},{\"name\":\"_source\",\"type\":\"_source\",\"count\":0,\"scripted\":false,\"searchable\":false,\"aggregatable\":false,\"readFromDocValues\":false},{\"name\":\"_type\",\"type\":\"string\",\"count\":0,\"scripted\":false,\"searchable\":true,\"aggregatable\":true,\"readFromDocValues\":false},{\"name\":\"busy_month\",\"type\":\"string\",\"count\":0,\"scripted\":false,\"searchable\":true,\"aggregatable\":false,\"readFromDocValues\":false},{\"name\":\"busy_month.keyword\",\"type\":\"string\",\"count\":0,\"scripted\":false,\"searchable\":true,\"aggregatable\":true,\"readFromDocValues\":true},{\"name\":\"capacity\",\"type\":\"number\",\"count\":0,\"scripted\":false,\"searchable\":true,\"aggregatable\":true,\"readFromDocValues\":true},{\"name\":\"city\",\"type\":\"string\",\"count\":0,\"scripted\":false,\"searchable\":true,\"aggregatable\":false,\"readFromDocValues\":false},{\"name\":\"city.keyword\",\"type\":\"string\",\"count\":0,\"scripted\":false,\"searchable\":true,\"aggregatable\":true,\"readFromDocValues\":true},{\"name\":\"cloesd\",\"type\":\"string\",\"count\":0,\"scripted\":false,\"searchable\":true,\"aggregatable\":false,\"readFromDocValues\":false},{\"name\":\"cloesd.keyword\",\"type\":\"string\",\"count\":0,\"scripted\":false,\"searchable\":true,\"aggregatable\":true,\"readFromDocValues\":true},{\"name\":\"country\",\"type\":\"string\",\"count\":0,\"scripted\":false,\"searchable\":true,\"aggregatable\":false,\"readFromDocValues\":false},{\"name\":\"country.keyword\",\"type\":\"string\",\"count\":0,\"scripted\":false,\"searchable\":true,\"aggregatable\":true,\"readFromDocValues\":true},{\"name\":\"created\",\"type\":\"date\",\"count\":0,\"scripted\":false,\"searchable\":true,\"aggregatable\":true,\"readFromDocValues\":true},{\"name\":\"group\",\"type\":\"string\",\"count\":0,\"scripted\":false,\"searchable\":true,\"aggregatable\":false,\"readFromDocValues\":false},{\"name\":\"group.keyword\",\"type\":\"string\",\"count\":0,\"scripted\":false,\"searchable\":true,\"aggregatable\":true,\"readFromDocValues\":true},{\"name\":\"has_parking\",\"type\":\"string\",\"count\":0,\"scripted\":false,\"searchable\":true,\"aggregatable\":false,\"readFromDocValues\":false},{\"name\":\"has_parking.keyword\",\"type\":\"string\",\"count\":0,\"scripted\":false,\"searchable\":true,\"aggregatable\":true,\"readFromDocValues\":true},{\"name\":\"hotel_name\",\"type\":\"string\",\"count\":0,\"scripted\":false,\"searchable\":true,\"aggregatable\":false,\"readFromDocValues\":false},{\"name\":\"hotel_name.keyword\",\"type\":\"string\",\"count\":0,\"scripted\":false,\"searchable\":true,\"aggregatable\":true,\"readFromDocValues\":true},{\"name\":\"menu\",\"type\":\"string\",\"count\":0,\"scripted\":false,\"searchable\":true,\"aggregatable\":false,\"readFromDocValues\":false},{\"name\":\"menu.keyword\",\"type\":\"string\",\"count\":0,\"scripted\":false,\"searchable\":true,\"aggregatable\":true,\"readFromDocValues\":true},{\"name\":\"price\",\"type\":\"number\",\"count\":0,\"scripted\":false,\"searchable\":true,\"aggregatable\":true,\"readFromDocValues\":true},{\"name\":\"star\",\"type\":\"number\",\"count\":0,\"scripted\":false,\"searchable\":true,\"aggregatable\":true,\"readFromDocValues\":true}]"
        }
      },
      "conflictedTypesFields": [],
      "fields": [
        "_id",
        "_index",
        "_score",
        "_type",
        "busy_month",
        "capacity",
        "city",
        "cloesd",
        "country",
        "created",
        "group",
        "has_parking",
        "hotel_name",
        "menu",
        "price",
        "star"
      ],
      "indexPatternId": "f2334f70-d26c-11e8-b545-dbdac9813fee",
      "metaFields": ["_source", "_id", "_type", "_index", "_score"],
      "searchRequest": {
        "body": {
          "_source": { "excludes": [] },
          "docvalue_fields": [{ "field": "created", "format": "date_time" }],
          "query": {
            "bool": {
              "filter": [{ "match_all": {} }],
              "must": [
                {
                  "range": {
                    "created": {
                      "format": "epoch_millis",
                      "gte": 1539218231049,
                      "lte": 1539823031049
                    }
                  }
                }
              ],
              "must_not": [],
              "should": []
            }
          },
          "script_fields": {},
          "sort": [
            { "created": { "order": "desc", "unmapped_type": "boolean" } }
          ],
          "stored_fields": ["*"],
          "version": true
        },
        "index": "hotel*"
      },
      "title": "last.20.days",
      "type": "search"
    },
    "timeout": 120000,
    "max_attempts": 3,
    "priority": 10
  }
}
