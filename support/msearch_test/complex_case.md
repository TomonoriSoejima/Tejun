```

COUNTER=0
saved_to="complex.json"
for i in JANUARY FEBRUARY MARCH APRIL MAY JUNE JULY AUGUST SEPTEMBER OCTOBER NOVEMBER DECEMBER; do

  let COUNTER=COUNTER+1
  echo $COUNTER requests
  word=$i

  cat << EOF >> $saved_to

  {"query":{"bool":{"must":[{"multi_match":{"query":"$word","fields":["city.keyword","country.keyword","hotel_name^1.0","busy_month.keyword"],"type":"best_fields"}}],"must_not":[{"match":{"travelerOrphanFlag":{"query":true,"operator":"OR","prefix_length":0,"max_expansions":50,"fuzzy_transpositions":true,"lenient":false,"zero_terms_query":"NONE","auto_generate_synonyms_phrase_query":true,"boost":1}}}],"adjust_pure_negative":true,"boost":1}},"aggs":{"test":{"terms":{"field":"hotel_name.keyword","size":1000}}}}
  EOF

  curl -s -H 'Content-Type: application/x-ndjson' -XGET 'localhost:9200/hotel/_msearch?pretty=true&max_concurrent_searches=1'  --data-binary @$saved_to | jq -c '.took, .responses[].took' | paste -sd,  -

done

rm $saved_to

```
```

[nami:msearch_test]$ sh complex.sh
1 requests
21,7,6,6
2 requests
29,7,7,7,7
3 requests
39,8,6,7,8,8
4 requests
43,6,6,7,7,8,6
5 requests
46,7,7,6,6,6,6,6
6 requests
54,6,6,6,6,6,6,8,6
7 requests
58,7,6,6,6,6,5,6,6,7
8 requests
62,6,6,6,6,6,5,6,5,5,5
9 requests
74,7,6,7,6,6,6,6,6,6,6,8
10 requests
81,6,6,5,5,6,6,7,6,7,7,8,7
11 requests
92,6,7,6,9,8,7,7,7,6,6,8,6,5
12 requests
92,7,5,7,7,7,6,6,5,6,5,6,6,6,5
[nami:msearch_test]$ 

```
