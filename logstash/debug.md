## Enabling debug on logstash when it is started via service

1. Add `--debug` to `/etc/systemd/system/logstash.service` as below.

`ExecStart=/usr/share/logstash/bin/logstash "--debug"  "--path.settings" "/etc/logstash"`

2. Reload daemon setting

`systemctl daemon-reload`

3. start logstash

`systemctl start logstash.service`

4. get debug log

`/var/log/logstash/logstash.log/logstash-plain.log`
