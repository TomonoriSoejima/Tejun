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
