ElasticSearch の [fielddata cache](https://www.elastic.co/guide/en/elasticsearch/reference/current/fielddata.html) は既定では上限が設定されておりません。
fielddata cache は heap 領域を使用するため、fielddata cache が肥大化すると、OOM の発生やパフォーマンスの劣化を誘発する場合があります。
heap 領域の不足による影響は以下となります。


**検索時**

パフォーマンスの劣化

OOM については、circuit breaker の仕組みにて、対処できる場合あり。


詳細 : https://www.elastic.co/guide/en/elasticsearch/reference/current/circuit-breaker.html

**index 作成時**

indexing のパフォーマンス劣化

なお、fielddata の上限値を設ける事で、上記を回避する事が可能です。

詳細 : https://www.elastic.co/guide/en/elasticsearch/reference/current/modules-fielddata.html#modules-fielddata


fielddata の使用量チェック

http://localhost:9200/_nodes/stats?pretty

`indices.fielddata.memory_size_in_bytes`
