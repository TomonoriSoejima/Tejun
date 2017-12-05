you need to do 2 things.

1. setup password

`bin/x-pack/setup-passwords interactive`

see also
https://www.elastic.co/guide/en/elasticsearch/reference/6.0/installing-xpack-es.html

2. setup user in `logstash.yml`

`logstash_system` is built in user.

Most likely you would only need to change `xpack.monitoring.elasticsearch.password`


```
xpack.monitoring.elasticsearch.username: logstash_system
xpack.monitoring.elasticsearch.password: logstashpassword
```

See also
https://www.elastic.co/guide/en/logstash/current/installing-xpack-log.html


Unless the above is done correctly, you would get this nasty error when you start logstash.

```
[mbp:logstash-6.0.0]$ ./bin/logstash 
Sending Logstash's logs to /Users/surfer/elastic/labs/logstash/x-pack-ls-6.0.0/logstash-6.0.0/logs which is now configured via log4j2.properties
[2017-12-05T20:39:12,996][INFO ][logstash.modules.scaffold] Initializing module {:module_name=>"netflow", :directory=>"/Users/surfer/elastic/labs/logstash/x-pack-ls-6.0.0/logstash-6.0.0/modules/netflow/configuration"}
[2017-12-05T20:39:12,998][INFO ][logstash.modules.scaffold] Initializing module {:module_name=>"fb_apache", :directory=>"/Users/surfer/elastic/labs/logstash/x-pack-ls-6.0.0/logstash-6.0.0/modules/fb_apache/configuration"}
[2017-12-05T20:39:13,658][INFO ][logstash.modules.scaffold] Initializing module {:module_name=>"arcsight", :directory=>"/Users/surfer/elastic/labs/logstash/x-pack-ls-6.0.0/logstash-6.0.0/vendor/bundle/jruby/2.3.0/gems/x-pack-6.0.0-java/modules/arcsight/configuration"}
[2017-12-05T20:39:13,693][INFO ][logstash.configmanagement.bootstrapcheck] Using Elasticsearch as config store {:pipeline_id=>["apache", "cloudwatch_logs"], :poll_interval=>"5000000000ns"}
[2017-12-05T20:39:13,974][INFO ][logstash.licensechecker.licensereader] Elasticsearch pool URLs updated {:changes=>{:removed=>[], :added=>[http://logstash_admin_user:xxxxxx@localhost:9200/]}}
[2017-12-05T20:39:13,977][INFO ][logstash.licensechecker.licensereader] Running health check to see if an Elasticsearch connection is working {:healthcheck_url=>http://logstash_admin_user:xxxxxx@localhost:9200/, :path=>"/"}
[2017-12-05T20:39:14,108][WARN ][logstash.licensechecker.licensereader] Attempted to resurrect connection to dead ES instance, but got an error. {:url=>"http://logstash_admin_user:xxxxxx@localhost:9200/", :error_type=>LogStash::Outputs::ElasticSearch::HttpClient::Pool::BadResponseCodeError, :error=>"Got response code '401' contacting Elasticsearch at URL 'http://localhost:9200/'"}
Got response code '401' contacting Elasticsearch at URL 'http://localhost:9200/_xpack'
[2017-12-05T20:39:14,126][ERROR][logstash.licensechecker.licensemanager] Unable to retrieve license information from license server {:message=>"Got response code '401' contacting Elasticsearch at URL 'http://localhost:9200/_xpack'", :class=>"LogStash::Outputs::ElasticSearch::HttpClient::Pool::BadResponseCodeError"}
[2017-12-05T20:39:14,127][WARN ][logstash.licensechecker.xpackinfo] Nil response from License Server
[2017-12-05T20:39:14,135][ERROR][logstash.configmanagement.elasticsearchsource] Configuration Management is not available: License information is currently unavailable. Please make sure you have added your production elasticsearch connection info in the xpack.management.elasticsearch settings.
[2017-12-05T20:39:14,140][FATAL][logstash.runner          ] An unexpected error occurred! {:error=>#<LogStash::LicenseChecker::LicenseError: Configuration Management is not available: License information is currently unavailable. Please make sure you have added your production elasticsearch connection info in the xpack.management.elasticsearch settings.>, :backtrace=>["/Users/surfer/elastic/labs/logstash/x-pack-ls-6.0.0/logstash-6.0.0/vendor/bundle/jruby/2.3.0/gems/x-pack-6.0.0-java/lib/license_checker/licensed.rb:78:in `with_license_check'", "/Users/surfer/elastic/labs/logstash/x-pack-ls-6.0.0/logstash-6.0.0/vendor/bundle/jruby/2.3.0/gems/x-pack-6.0.0-java/lib/config_management/elasticsearch_source.rb:48:in `initialize'", "/Users/surfer/elastic/labs/logstash/x-pack-ls-6.0.0/logstash-6.0.0/vendor/bundle/jruby/2.3.0/gems/x-pack-6.0.0-java/lib/config_management/hooks.rb:52:in `after_bootstrap_checks'", "/Users/surfer/elastic/labs/logstash/x-pack-ls-6.0.0/logstash-6.0.0/logstash-core/lib/logstash/event_dispatcher.rb:34:in `block in fire'", "/Users/surfer/elastic/labs/logstash/x-pack-ls-6.0.0/logstash-6.0.0/logstash-core/lib/logstash/event_dispatcher.rb:32:in `fire'", "/Users/surfer/elastic/labs/logstash/x-pack-ls-6.0.0/logstash-6.0.0/logstash-core/lib/logstash/runner.rb:295:in `execute'", "/Users/surfer/elastic/labs/logstash/x-pack-ls-6.0.0/logstash-6.0.0/vendor/bundle/jruby/2.3.0/gems/clamp-0.6.5/lib/clamp/command.rb:67:in `run'", "/Users/surfer/elastic/labs/logstash/x-pack-ls-6.0.0/logstash-6.0.0/logstash-core/lib/logstash/runner.rb:232:in `run'", "/Users/surfer/elastic/labs/logstash/x-pack-ls-6.0.0/logstash-6.0.0/vendor/bundle/jruby/2.3.0/gems/clamp-0.6.5/lib/clamp/command.rb:132:in `run'", "/Users/surfer/elastic/labs/logstash/x-pack-ls-6.0.0/logstash-6.0.0/lib/bootstrap/environment.rb:71:in `<main>'"]}
[mbp:logstash-6.0.0]$ 
```
