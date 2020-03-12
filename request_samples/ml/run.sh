
last_2month=$(python -c '
from datetime import datetime
from datetime import timedelta
today = datetime.today()
month2_ago = today - timedelta(days=64)
month1_ago = today - timedelta(days=32)
print month2_ago.strftime("%Y-%m"), month1_ago.strftime("%Y-%m")
')


echo updating the timestamp in the  original document based on the current month.
echo making the change below.

month2_ago="2017-04"
month1_ago="2017-05"

new_2month_ago=$(echo $last_2month | cut -f1 -d " ")
echo "$month2_ago => $new_2month_ago"

new_1month_ago=$(echo $last_2month | cut -f2 	-d " ")
echo "$month1_ago => $new_1month_ago"

sed -e s,$month2_ago,$new_2month_ago, -e s,$month1_ago,$new_1month_ago, original.json \
 | curl -s -H 'Content-Type: application/x-ndjson' -XPOST 'localhost:9200/_bulk?pretty' --data-binary @- > /dev/null

newman run ML.postman_collection.json 
