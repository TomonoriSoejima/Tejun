# リクエストの抽出方法


1. HAR ファイルを editor で開きます。
2. 後述のテキストをコピーし、別ファイルに保存します。
3. そのファイルに対して、vi にて余分な文字を削除します。

使用したコマンド

`%s,\\n,,g`

`%s,\\,,g`

4. jq コマンドにて整形します。

`$ cat data.txt | jq -M`
結果をファイルに保存する場合は、こちら
`$ cat data.txt | jq . > data.json`



## 今回抽出したリクエスト
{\"index\":[\"log-*\"],\"ignore_unavailable\":true,\"preference\":1501491358816}\n{\"version\":true,\"size\":10000,\"sort\":[{\"@timestamp\":{\"order\":\"desc\",\"unmapped_type\":\"boolean\"}}],\"_source\":{\"excludes\":[]},\"aggs\":{\"2\":{\"date_histogram\":{\"field\":\"@timestamp\",\"interval\":\"30s\",\"time_zone\":\"Asia/Tokyo\",\"min_doc_count\":1}}},\"query\":{\"bool\":{\"must\":[{\"match_all\":{}},{\"range\":{\"@timestamp\":{\"gte\":1501490462721,\"lte\":1501491362721,\"format\":\"epoch_millis\"}}}],\"must_not\":[]}},\"stored_fields\":[\"*\"],\"script_fields\":{},\"docvalue_fields\":[\"@timestamp\"],\"highlight\":{\"pre_tags\":[\"@kibana-highlighted-field@\"],\"post_tags\":[\"@/kibana-highlighted-field@\"],\"fields\":{\"*\":{\"highlight_query\":{\"bool\":{\"must\":[{\"match_all\":{}},{\"range\":{\"@timestamp\":{\"gte\":1501490462721,\"lte\":1501491362721,\"format\":\"epoch_millis\"}}}],\"must_not\":[]}}}},\"fragment_size\":2147483647}}\n
