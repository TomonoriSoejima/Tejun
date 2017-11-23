import sys
from elasticsearch import Elasticsearch

def get(filename):
    returndata = {}
    try:
        fd = open(filename, 'r')
        text = fd.read()
        fd.close()
        returndata = text

    except: 
        print('could not read:', filename)
    return returndata


def makedoc(file):
    try:
      es = Elasticsearch(
          ['localhost'],
          http_auth=('elastic', 'changeme'),
          port=9200,
      )

      data = {
        'body' : get(file)
      }

      res = es.index(index='test_index', doc_type='post', id=1, body=data)
      print(res)
      # print("Connected", es.info())
    except Exception as ex:
      print ("Error:", ex)



def main(file):
    makedoc(file)

if __name__ == "__main__":
    main(sys.argv[1])
