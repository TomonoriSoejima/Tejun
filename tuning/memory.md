ElasticSearch の fielddata cache は既定では上限が設定されておりません。
fielddata cache は heap 領域を使用するため、fielddata cache が肥大化すると、OOM の発生やパフォーマンスの劣化を誘発する場合があります。
heap 領域の不足による影響は以下となります。


検索時
パフォーマンスの劣化
OOM については、circuit breaker の仕組みにて、対処できる場合あり。
詳細 : https://www.elastic.co/guide/en/elasticsearch/reference/current/circuit-breaker.html

index 作成時
indexing のパフォーマンス劣化

