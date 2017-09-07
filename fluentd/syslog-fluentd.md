`sudo logger -p authpriv.1 "test"`

```
<ROOT>
  <match td.*.*>
    @type tdlog
    apikey xxxxxx
    auto_create_table 
    buffer_type file
    buffer_path /var/log/td-agent/buffer/td
    buffer_chunk_limit 33554432
    <secondary>
      @type file
      path /var/log/td-agent/failed_records
      buffer_path /var/log/td-agent/failed_records.*
    </secondary>
  </match>
  <match system.authpriv.info>
    @type forward
    <server>
      host localhost
      port 4000
    </server>
  </match>
  <source>
    @type forward
  </source>
  <source>
    @type http
    port 8888
  </source>
  <source>
    @type debug_agent
    bind 127.0.0.1
    port 24230
  </source>
  <source>
    @type syslog
    port 5140
    bind 0.0.0.0
    tag system
    with_priority true
  </source>
  <match system.authpriv.info>
    @type file
    time_slice_wait 1m
    path /var/log/td-agent/access/access.log
    buffer_path /var/log/td-agent/access/access.log.*
  </match>
</ROOT>
```


But getting this error.
```
but getting this error
```
2017-09-07 13:39:42 +0900 [warn]: detached forwarding server 'localhost:4000' host="localhost" port=4000 phi=16.014217520797512
2017-09-07 13:40:07 +0900 [warn]: temporarily failed to flush the buffer. next_retry=2017-09-07 13:40:08 +0900 error_class="RuntimeError" error="no nodes are available" plugin_id="object:3fc7b58b0a44"
  2017-09-07 13:40:07 +0900 [warn]: /opt/td-agent/embedded/lib/ruby/gems/2.1.0/gems/fluentd-0.12.36/lib/fluent/plugin/out_forward.rb:222:in `write_objects'
  2017-09-07 13:40:07 +0900 [warn]: /opt/td-agent/embedded/lib/ruby/gems/2.1.0/gems/fluentd-0.12.36/lib/fluent/output.rb:490:in `write'
  2017-09-07 13:40:07 +0900 [warn]: /opt/td-agent/embedded/lib/ruby/gems/2.1.0/gems/fluentd-0.12.36/lib/fluent/buffer.rb:354:in `write_chunk'
  2017-09-07 13:40:07 +0900 [warn]: /opt/td-agent/embedded/lib/ruby/gems/2.1.0/gems/fluentd-0.12.36/lib/fluent/buffer.rb:333:in `pop'
  2017-09-07 13:40:07 +0900 [warn]: /opt/td-agent/embedded/lib/ruby/gems/2.1.0/gems/fluentd-0.12.36/lib/fluent/output.rb:342:in `try_flush'
  2017-09-07 13:40:07 +0900 [warn]: /opt/td-agent/embedded/lib/ruby/gems/2.1.0/gems/fluentd-0.12.36/lib/fluent/output.rb:149:in `run'
2017-09-07 13:40:08 +0900 [warn]: temporarily failed to flush the buffer. next_retry=2017-09-07 13:40:10 +0900 error_class="RuntimeError" error="no nodes are available" plugin_id="object:3fc7b58b0a44"
  2017-09-07 13:40:08 +0900 [warn]: suppressed same stacktrace
2017-09-07 13:40:10 +0900 [warn]: temporarily failed to flush the buffer. next_retry=2017-09-07 13:40:14 +0900 error_class="RuntimeError" error="no nodes are available" plugin_id="object:3fc7b58b0a44"
  2017-09-07 13:40:10 +0900 [warn]: suppressed same stacktrace
2017-09-07 13:40:14 +0900 [warn]: temporarily failed to flush the buffer. next_retry=2017-09-07 13:40:22 +0900 error_class="RuntimeError" error="no nodes are available" plugin_id="object:3fc7b58b0a44"
  2017-09-07 13:40:14 +0900 [warn]: suppressed same stacktrace
2017-09-07 13:40:22 +0900 [warn]: temporarily failed to flush the buffer. next_retry=2017-09-07 13:40:40 +0900 error_class="RuntimeError" error="no nodes are available" plugin_id="object:3fc7b58b0a44"
  2017-09-07 13:40:22 +0900 [warn]: suppressed same stacktrace
2017-09-07 13:40:40 +0900 [warn]: temporarily failed to flush the buffer. next_retry=2017-09-07 13:41:11 +0900 error_class="RuntimeError" error="no nodes are available" plugin_id="object:3fc7b58b0a44"
  2017-09-07 13:40:40 +0900 [warn]: suppressed same stacktrace
2017-09-07 13:41:11 +0900 [warn]: temporarily failed to flush the buffer. next_retry=2017-09-07 13:42:16 +0900 error_class="RuntimeError" error="no nodes are available" plugin_id="object:3fc7b58b0a44"
  2017-09-07 13:41:11 +0900 [warn]: suppressed same stacktrace
2017-09-07 13:42:16 +0900 [warn]: temporarily failed to flush the buffer. next_retry=2017-09-07 13:44:24 +0900 error_class="RuntimeError" error="no nodes are available" plugin_id="object:3fc7b58b0a44"
  2017-09-07 13:42:16 +0900 [warn]: suppressed same stacktrace
```

Slowly gettig there
