## msearch runner script

It will execute `_msearch` request 12 times with gradul increase of embeded requests within from 1 to 12.
You can see that `max_concurrent_searche` parameter is used.
```
# cat complex.sh

COUNTER=0
saved_to="complex.json"
for i in JANUARY FEBRUARY MARCH APRIL MAY JUNE JULY AUGUST SEPTEMBER OCTOBER NOVEMBER DECEMBER; do

  let COUNTER=COUNTER+1
  echo $COUNTER requests
  word=$i

  cat << EOF >> $saved_to

  {"query":{"bool":{"must":[{"multi_match":{"query":"$word","fields":["city.keyword","country.keyword","hotel_name^1.0","busy_month.keyword"],"type":"best_fields"}}],"must_not":[{"match":{"travelerOrphanFlag":{"query":true,"operator":"OR","prefix_length":0,"max_expansions":50,"fuzzy_transpositions":true,"lenient":false,"zero_terms_query":"NONE","auto_generate_synonyms_phrase_query":true,"boost":1}}}],"adjust_pure_negative":true,"boost":1}},"aggs":{"test":{"terms":{"field":"hotel_name.keyword","size":1000}}}}
  EOF

  curl -s -H 'Content-Type: application/x-ndjson' -XGET "localhost:9200/hotel/_msearch?pretty=true&max_concurrent_searches=$1"  --data-binary @$saved_to | jq -c '.took, .responses[].took' | paste -sd,  -

done

rm $saved_to

```

## result

- you can see that each requests within the msearch perform best when max_concurrent_searches is lower.
The larger the value it is, the less performant they get.

- But the total `taken` will suffer as expectedly.

- with max_concurrent_searches 12, total `taken` will improve.

```
[nami:msearch_test]$ for i in  $(seq 1 12); do echo "" ;  echo max_concurrent_searches=$i; sh complex.sh $i ;  done

max_concurrent_searches=1
1 requests
7,7
2 requests
13,6,6
3 requests
22,7,7,7
4 requests
27,6,6,7,7
5 requests
33,6,6,6,6,7
6 requests
41,7,7,6,6,6,6
7 requests
53,7,6,6,6,10,8,7
8 requests
56,7,7,7,7,7,6,6,5
9 requests
60,7,6,6,8,7,7,6,5,5
10 requests
68,6,6,6,6,6,6,8,6,6,7
11 requests
66,6,7,5,5,6,5,5,5,6,5,5
12 requests
74,7,5,5,5,7,6,5,5,5,5,5,6

max_concurrent_searches=2
1 requests
7,7
2 requests
10,10,9
3 requests
18,12,12,6
4 requests
24,13,13,11,11
5 requests
29,10,11,10,11,7
6 requests
32,10,10,10,10,10,10
7 requests
38,11,11,10,10,10,10,6
8 requests
37,10,10,8,9,8,9,8,8
9 requests
46,10,10,10,10,9,10,9,9,5
10 requests
45,10,10,9,9,8,9,8,7,7,7
11 requests
55,10,10,10,10,10,10,9,10,8,9,6
12 requests
50,9,9,8,8,8,8,7,7,6,9,7,6

max_concurrent_searches=3
1 requests
6,6
2 requests
10,10,9
3 requests
14,14,14,14
4 requests
20,14,14,13,6
5 requests
21,12,13,13,7,7
6 requests
25,12,13,13,11,12,11
7 requests
30,12,14,13,10,12,12,7
8 requests
32,14,12,14,7,12,11,8,6
9 requests
34,11,13,12,8,11,11,6,9,9
10 requests
46,16,17,17,12,14,14,6,12,13,10
11 requests
43,11,13,13,7,12,13,9,11,12,11,5
12 requests
52,13,12,13,10,12,12,10,15,15,9,10,11

max_concurrent_searches=4
1 requests
6,6
2 requests
10,10,9
3 requests
15,15,13,14
4 requests
21,21,20,21,19
5 requests
21,17,14,17,18,6
6 requests
29,19,18,19,16,10,10
7 requests
29,18,18,16,18,7,11,10
8 requests
37,19,19,19,16,10,16,17,17
9 requests
34,18,13,18,18,7,12,15,15,13
10 requests
35,14,15,17,17,10,11,14,14,8,7
11 requests
43,16,16,13,16,7,17,17,16,13,9,9
12 requests
45,16,17,17,13,7,11,17,18,15,10,9,9

max_concurrent_searches=5
1 requests
6,6
2 requests
10,10,9
3 requests
15,14,15,14
4 requests
18,18,18,15,18
5 requests
23,23,23,23,22,23
6 requests
25,22,19,21,20,21,6
7 requests
31,23,23,19,23,22,8,8
8 requests
31,18,23,21,23,23,8,9,8
9 requests
36,22,21,22,20,21,15,13,14,14
10 requests
39,21,22,21,21,19,10,17,17,17,17
11 requests
41,19,21,22,22,22,9,12,17,18,18,11
12 requests
43,21,20,17,21,21,8,16,18,18,19,15,6

max_concurrent_searches=6
1 requests
6,6
2 requests
11,11,11
3 requests
15,15,15,15
4 requests
19,18,14,18,18
5 requests
22,20,21,21,17,21
6 requests
26,26,19,24,25,26,26
7 requests
30,27,27,27,25,20,26,10
8 requests
33,27,27,28,26,19,28,10,6
9 requests
34,28,21,27,25,27,28,8,7,6
10 requests
38,27,26,27,21,25,26,7,9,11,11
11 requests
42,25,22,24,25,23,25,9,13,14,17,16
12 requests
43,27,24,16,27,28,27,12,6,15,15,13,14

max_concurrent_searches=7
1 requests
6,6
2 requests
10,10,9
3 requests
18,17,18,17
4 requests
20,20,17,19,20
5 requests
24,24,23,18,22,23
6 requests
28,28,26,26,18,28,27
7 requests
30,26,29,29,29,30,30,26
8 requests
33,29,30,29,27,30,30,27,5
9 requests
38,30,27,28,31,31,31,30,10,10
10 requests
41,30,26,31,29,30,31,31,8,10,10
11 requests
48,30,31,30,31,30,31,19,13,17,14,17
12 requests
44,30,23,30,29,30,27,27,8,16,13,15,14

max_concurrent_searches=8
1 requests
6,6
2 requests
12,12,12
3 requests
14,14,13,14
4 requests
18,18,16,15,17
5 requests
22,18,22,22,21,22
6 requests
26,24,24,26,25,26,22
7 requests
31,31,31,31,21,31,29,29
8 requests
33,27,32,31,31,33,33,30,32
9 requests
34,32,27,32,31,31,31,32,27,7
10 requests
40,34,29,34,34,32,34,34,34,9,8
11 requests
41,33,22,30,31,33,33,33,32,12,11,9
12 requests
48,33,34,33,34,34,33,33,32,16,15,15,13

max_concurrent_searches=9
1 requests
6,6
2 requests
11,11,11
3 requests
15,14,15,15
4 requests
18,17,15,18,18
5 requests
21,20,19,15,20,20
6 requests
27,27,27,25,24,26,27
7 requests
31,23,30,30,30,27,30,30
8 requests
32,32,28,31,31,32,32,24,31
9 requests
34,34,34,33,32,34,28,34,30,32
10 requests
35,33,30,33,28,33,31,33,33,31,7
11 requests
37,33,30,31,33,33,33,27,22,32,13,9
12 requests
42,34,19,34,32,34,33,33,32,32,15,9,9

max_concurrent_searches=10
1 requests
6,6
2 requests
10,10,9
3 requests
15,15,15,15
4 requests
20,20,17,20,20
5 requests
24,24,19,24,21,24
6 requests
27,23,26,24,26,26,25
7 requests
31,31,31,30,30,29,23,30
8 requests
34,34,33,34,31,34,34,34,32
9 requests
35,35,32,28,34,34,34,33,34,34
10 requests
36,36,36,34,35,35,36,34,35,35,31
11 requests
39,37,37,36,37,35,36,32,34,31,36,7
12 requests
41,36,19,36,34,36,35,34,35,36,34,17,6

max_concurrent_searches=11
1 requests
6,6
2 requests
10,10,10
3 requests
14,14,13,13
4 requests
19,17,18,19,19
5 requests
22,22,20,22,17,22
6 requests
26,26,26,26,26,23,22
7 requests
29,29,29,29,29,28,26,26
8 requests
34,30,33,32,34,34,34,32,34
9 requests
34,34,29,34,33,33,34,33,33,28
10 requests
37,35,36,37,33,32,37,36,35,36,36
11 requests
37,31,36,36,37,37,37,34,32,36,36,25
12 requests
39,36,34,37,34,37,37,36,33,32,36,36,6

max_concurrent_searches=12
1 requests
6,6
2 requests
10,10,9
3 requests
17,16,17,17
4 requests
19,18,19,19,19
5 requests
21,20,21,20,19,21
6 requests
26,25,25,26,20,24,26
7 requests
31,30,31,30,31,31,26,26
8 requests
33,30,33,33,28,33,33,32,32
9 requests
34,33,33,33,24,34,33,33,33,30
10 requests
36,35,30,35,33,36,35,34,33,34,22
11 requests
40,40,31,40,40,36,39,39,26,35,39,25
12 requests
38,38,37,37,37,37,35,32,21,34,36,35,37
[nami:msearch_test]$ 
```


