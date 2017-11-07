# install fluentd
follow instuctions in this [page](https://docs.fluentd.org/v0.12/articles/install-by-dmg)

`sudo launchctl load /Library/LaunchDaemons/td-agent.plist`

check `/etc/td-agent/td-agent.conf` to find which port fluend is listening on.


check whether it is running at certain port `netstat -Waltn | grep 8888`

create logstash configuration according to this [page](https://www.elastic.co/guide/en/logstash/current/plugins-codecs-fluent.html)

install fluent-logger
`sudo gem install fluent-logger`

create ruby sample script to emit document to fluentd

```
require 'fluent-logger'

logger = Fluent::Logger::FluentLogger.new(nil, :host => "localhost", :port => 4000)
logger.post("some_tag", { "your" => "data", "here" => "yay!" })
```

[use this plugin](https://github.com/uken/fluent-plugin-elasticsearch) if you want fluentd to forwward message to elasticsearch



