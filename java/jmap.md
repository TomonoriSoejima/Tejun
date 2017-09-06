手順の概要

1. logstash の jvm.options に以下を追加します。
-XX:NativeMemoryTracking=summary

2. logstash を起動します。

以下のコマンドにて、logstash が起動した事を確認します。

`$ jps -m | grep logstash`


3. 下記にて、JVM の stats を確認します。
 
`$ jcmd $(jps -m | grep logstash | awk '{print $1}') VM.native_memory`

出力結果の "Native Memory Tracking"  の値をモニタリングして下さい。
こちらの数値が、右肩上がりになっていれば、メモリーリークが起きている可能性がございます。

native memory の leak 検知手順の詳細はこちらを参考にして下さい。
なお、https://visualvm.github.io/ もよく使用されるツールとなります。
