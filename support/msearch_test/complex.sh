

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
