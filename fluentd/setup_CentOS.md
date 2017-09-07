
# install fluentd
follow instuctions in this [page](https://docs.fluentd.org/v0.12/articles/install-by-rpm#step-0-before-installation)

`curl -L https://toolbelt.treasuredata.com/sh/install-redhat-td-agent2.sh | sh`

install ruby

`yum install -y ruby`

`yum install -y ruby-devel`

install fluent-logger

`gem install fluent-logger`

check `/etc/td-agent/td-agent.conf` to find which port fluend is listening on. By default it runs on 8888

create logstash configuration according to this [page](https://www.elastic.co/guide/en/logstash/current/plugins-codecs-fluent.html)

start logshash first to avoid port conflict.

then start fluentd

create ruby sample script to emit document to fluentd

```
require 'fluent-logger'

logger = Fluent::Logger::FluentLogger.new(nil, :host => "localhost", :port => 8888)
logger.post("some_tag", { "your" => "data", "here" => "yay!" })
```

Push sample document. Assuming the script above is saved as `push.rb`

`ruby push.rb`

(Optional install jq)
`sudo curl -o /usr/bin/jq -L https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 && sudo chmod +x /usr/bin/jq`


```
[surfer@haruto ~]$ curl --silent  -u elastic:changem  -XGET localhost:9200/logstash-2017.09.07/_search  | jq
{
  "took": 0,
  "timed_out": false,
  "_shards": {
    "total": 5,
    "successful": 5,
    "failed": 0
  },
  "hits": {
    "total": 2,
    "max_score": 1,
    "hits": [
      {
        "_index": "logstash-2017.09.07",
        "_type": "logs",
        "_id": "AV5Z5byH1-1tU3vccJa5",
        "_score": 1,
        "_source": {
          "here": "yay!",
          "@timestamp": "2017-09-07T01:13:01.000Z",
          "port": 45984,
          "@version": "1",
          "host": "0:0:0:0:0:0:0:1",
          "your": "life",
          "tags": [
            "some_tag"
          ]
        }
      },
      {
        "_index": "logstash-2017.09.07",
        "_type": "logs",
        "_id": "AV5Z4eBR1-1tU3vccJa4",
        "_score": 1,
        "_source": {
          "here": "yay!",
          "@timestamp": "2017-09-07T01:08:48.000Z",
          "port": 45974,
          "@version": "1",
          "host": "0:0:0:0:0:0:0:1",
          "your": "data",
          "tags": [
            "some_tag"
          ]
        }
      }
    ]
  }
}
```
