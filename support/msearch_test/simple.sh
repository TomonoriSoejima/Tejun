
COUNTER=0
for i in JANUARY FEBRUARY MARCH APRIL MAY JUNE JULY AUGUST SEPTEMBER OCTOBER NOVEMBER DECEMBER; do


  saved_to="simple.json"
  let COUNTER=COUNTER+1
  echo $COUNTER requests
  word=$i
  cat << EOF >> $saved_to
  {"index":"hotel"}
  {"profile":true,"query":{"term":{"busy_month.keyword":{"value":"$word"}}}}
  EOF


  curl -s -H 'Content-Type: application/x-ndjson' -XGET 'localhost:9200/hotel/_msearch?pretty=true'  --data-binary @$saved_to | jq -c '.took, .responses[].took' | paste -sd,  -

done

rm $saved_to


