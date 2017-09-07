
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



create ruby sample script to emit document to fluentd

```
require 'fluent-logger'

logger = Fluent::Logger::FluentLogger.new(nil, :host => "localhost", :port => 8888)
logger.post("some_tag", { "your" => "data", "here" => "yay!" })
```


