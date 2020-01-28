# Objective

Remove a field from document.
In a given document like this, we want to remove fields whose name starts with "Begin".
They are nested within `ad`


```
PUT my_index/_doc/1
{
  "name": "mike",
  "ad": {
    "group": "c",
    "point": "8",
    "Begin:a": "begin",
    "Begin:b": "begin",
    "Begin:_,2019-11-29_,21:52": "kore"
  }
}
```

It can be done like this.

```
POST my_index/_update_by_query
{
   "script" : "ctx._source.ad.remove(\"Begin:b\")"
}
```

But there are multiple matches and I have not found a way to use wildcard.
So I decided to list all matching fields.

To do that I made a small script to list up the matching fields and create 
****

```

for i in $(grep Begin mapping.txt | awk '{print $1}'); do

	index_name=$(echo $i | tr -d '\"')
	echo "ctx._source.ad.remove(\\\"$index_name\\\");"

done
```


# A collapsible section containing markdown
<details>
  <summary>Click to expand!</summary>
  
  ## Heading
  1. A numbered
  2. list
     * With some
     * Sub bullets
</details>

