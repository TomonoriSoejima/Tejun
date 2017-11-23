from elasticsearch import Elasticsearch

try:
  es = Elasticsearch(
      ['localhost'],
      http_auth=('elastic', 'changeme'),
      port=9200,
  )

  data = {
    'body' : "file body"
  }
  es.index(index='test_index', doc_type='post', id=1, body= data)
  print("Connected", es.info())
except Exception as ex:
  print ("Error:", ex)
