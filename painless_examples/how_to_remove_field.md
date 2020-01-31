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

To do that I made a small script to list up the matching fields. 


```

for i in $(grep Begin mapping.txt | awk '{print $1}'); do

	index_name=$(echo $i | tr -d '\"')
	echo "ctx._source.ad.remove(\\\"$index_name\\\");"

done
```


### Output from the shell
<details>
  <summary>$ sh do.this.sh</summary>
  

ctx._source.ad.remove(\"Begin:_,2019-11-29_,21:52\");
ctx._source.ad.remove(\"Begin:_,2019-11-29_,21:54\");
ctx._source.ad.remove(\"Begin:_,2019-11-29_,22:13\");
ctx._source.ad.remove(\"Begin:_,2019-11-29_,22:34\");
ctx._source.ad.remove(\"Begin:_,2019-11-29_,22:54\");
ctx._source.ad.remove(\"Begin:_,2019-11-29_,23:12\");
ctx._source.ad.remove(\"Begin:_,2019-11-30_,09:44\");
ctx._source.ad.remove(\"Begin:_,2019-11-30_,16:18\");
ctx._source.ad.remove(\"Begin:_,2019-11-30_,16:20\");
ctx._source.ad.remove(\"Begin:_,2019-11-30_,20:19\");
ctx._source.ad.remove(\"Begin:_,2019-12-01_,10:49\");
ctx._source.ad.remove(\"Begin:_,2019-12-01_,15:20\");
ctx._source.ad.remove(\"Begin:_,2019-12-01_,17:36\");
ctx._source.ad.remove(\"Begin:_,2019-12-01_,20:26\");
ctx._source.ad.remove(\"Begin:_,2019-12-02_,09:54\");
ctx._source.ad.remove(\"Begin:_,2019-12-02_,10:12\");
ctx._source.ad.remove(\"Begin:_,2019-12-02_,10:14\");
ctx._source.ad.remove(\"Begin:_,2019-12-02_,10:15\");
ctx._source.ad.remove(\"Begin:_,2019-12-02_,10:32\");
ctx._source.ad.remove(\"Begin:_,2019-12-02_,10:34\");
ctx._source.ad.remove(\"Begin:_,2019-12-02_,10:52\");
ctx._source.ad.remove(\"Begin:_,2019-12-02_,11:32\");
ctx._source.ad.remove(\"Begin:_,2019-12-02_,11:34\");
ctx._source.ad.remove(\"Begin:_,2019-12-02_,11:41\");
ctx._source.ad.remove(\"Begin:_,2019-12-02_,11:52\");
ctx._source.ad.remove(\"Begin:_,2019-12-02_,12:14\");
ctx._source.ad.remove(\"Begin:_,2019-12-02_,12:15\");
ctx._source.ad.remove(\"Begin:_,2019-12-02_,12:34\");
ctx._source.ad.remove(\"Begin:_,2019-12-02_,13:24\");
ctx._source.ad.remove(\"Begin:_,2019-12-02_,15:13\");
ctx._source.ad.remove(\"Begin:_,2019-12-02_,15:14\");
ctx._source.ad.remove(\"Begin:_,2019-12-02_,15:45\");
ctx._source.ad.remove(\"Begin:_,2019-12-02_,15:54\");
ctx._source.ad.remove(\"Begin:_,2019-12-02_,16:12\");
ctx._source.ad.remove(\"Begin:_,2019-12-02_,16:13\");
ctx._source.ad.remove(\"Begin:_,2019-12-02_,16:15\");
ctx._source.ad.remove(\"Begin:_,2019-12-02_,16:32\");
ctx._source.ad.remove(\"Begin:_,2019-12-02_,16:35\");
ctx._source.ad.remove(\"Begin:_,2019-12-02_,16:52\");
ctx._source.ad.remove(\"Begin:_,2019-12-02_,16:54\");
ctx._source.ad.remove(\"Begin:_,2019-12-02_,17:24\");
ctx._source.ad.remove(\"Begin:_,2019-12-02_,18:12\");
ctx._source.ad.remove(\"Begin:_,2019-12-02_,18:24\");
ctx._source.ad.remove(\"Begin:_,2019-12-02_,19:12\");
ctx._source.ad.remove(\"Begin:_,2019-12-02_,20:13\");
ctx._source.ad.remove(\"Begin:_,2019-12-02_,21:46\");
ctx._source.ad.remove(\"Begin:_,2019-12-02_,23:12\");
ctx._source.ad.remove(\"Begin:_,2019-12-02_,23:14\");
ctx._source.ad.remove(\"Begin:_,2019-12-02_,23:15\");
ctx._source.ad.remove(\"Begin:_,2019-12-02_,23:35\");
ctx._source.ad.remove(\"Begin:_,2019-12-02_,23:54\");
ctx._source.ad.remove(\"Begin:_,2019-12-03_,00:15\");
ctx._source.ad.remove(\"Begin:_,2019-12-03_,03:47\");
ctx._source.ad.remove(\"Begin:_,2019-12-03_,06:00\");
ctx._source.ad.remove(\"Begin:_,2019-12-03_,12:00\");
</details>

**Save the output to a file**

Then open with `vim` and type `55` and Shift + J.
It will remove all the newline and concatenate them into a single line.
So the final output looks like this.


```
[nami:00483159]$ cat done.txt 
ctx._source.ad.remove(\"Begin:_,2019-11-29_,21:52\"); ctx._source.ad.remove(\"Begin:_,2019-11-29_,21:54\"); ctx._source.ad.remove(\"Begin:_,2019-11-29_,22:13\"); ctx._source.ad.remove(\"Begin:_,2019-11-29_,22:34\"); ctx._source.ad.remove(\"Begin:_,2019-11-29_,22:54\"); ctx._source.ad.remove(\"Begin:_,2019-11-29_,23:12\"); ctx._source.ad.remove(\"Begin:_,2019-11-30_,09:44\"); ctx._source.ad.remove(\"Begin:_,2019-11-30_,16:18\"); ctx._source.ad.remove(\"Begin:_,2019-11-30_,16:20\"); ctx._source.ad.remove(\"Begin:_,2019-11-30_,20:19\"); ctx._source.ad.remove(\"Begin:_,2019-12-01_,10:49\"); ctx._source.ad.remove(\"Begin:_,2019-12-01_,15:20\"); ctx._source.ad.remove(\"Begin:_,2019-12-01_,17:36\"); ctx._source.ad.remove(\"Begin:_,2019-12-01_,20:26\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,09:54\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,10:12\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,10:14\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,10:15\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,10:32\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,10:34\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,10:52\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,11:32\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,11:34\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,11:41\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,11:52\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,12:14\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,12:15\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,12:34\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,13:24\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,15:13\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,15:14\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,15:45\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,15:54\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,16:12\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,16:13\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,16:15\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,16:32\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,16:35\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,16:52\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,16:54\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,17:24\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,18:12\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,18:24\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,19:12\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,20:13\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,21:46\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,23:12\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,23:14\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,23:15\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,23:35\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,23:54\"); ctx._source.ad.remove(\"Begin:_,2019-12-03_,00:15\"); ctx._source.ad.remove(\"Begin:_,2019-12-03_,03:47\"); ctx._source.ad.remove(\"Begin:_,2019-12-03_,06:00\"); ctx._source.ad.remove(\"Begin:_,2019-12-03_,12:00\")
```

**Finally**
Copy the entire thing and construct the request.

```
POST my_index/_update_by_query
{
   "script" : "ctx._source.ad.remove(\"Begin:_,2019-11-29_,21:52\"); ctx._source.ad.remove(\"Begin:_,2019-11-29_,21:54\"); ctx._source.ad.remove(\"Begin:_,2019-11-29_,22:13\"); ctx._source.ad.remove(\"Begin:_,2019-11-29_,22:34\"); ctx._source.ad.remove(\"Begin:_,2019-11-29_,22:54\"); ctx._source.ad.remove(\"Begin:_,2019-11-29_,23:12\"); ctx._source.ad.remove(\"Begin:_,2019-11-30_,09:44\"); ctx._source.ad.remove(\"Begin:_,2019-11-30_,16:18\"); ctx._source.ad.remove(\"Begin:_,2019-11-30_,16:20\"); ctx._source.ad.remove(\"Begin:_,2019-11-30_,20:19\"); ctx._source.ad.remove(\"Begin:_,2019-12-01_,10:49\"); ctx._source.ad.remove(\"Begin:_,2019-12-01_,15:20\"); ctx._source.ad.remove(\"Begin:_,2019-12-01_,17:36\"); ctx._source.ad.remove(\"Begin:_,2019-12-01_,20:26\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,09:54\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,10:12\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,10:14\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,10:15\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,10:32\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,10:34\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,10:52\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,11:32\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,11:34\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,11:41\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,11:52\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,12:14\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,12:15\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,12:34\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,13:24\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,15:13\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,15:14\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,15:45\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,15:54\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,16:12\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,16:13\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,16:15\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,16:32\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,16:35\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,16:52\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,16:54\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,17:24\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,18:12\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,18:24\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,19:12\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,20:13\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,21:46\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,23:12\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,23:14\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,23:15\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,23:35\"); ctx._source.ad.remove(\"Begin:_,2019-12-02_,23:54\"); ctx._source.ad.remove(\"Begin:_,2019-12-03_,00:15\"); ctx._source.ad.remove(\"Begin:_,2019-12-03_,03:47\"); ctx._source.ad.remove(\"Begin:_,2019-12-03_,06:00\"); ctx._source.ad.remove(\"Begin:_,2019-12-03_,12:00\")"
}
```

## After all, this one liner did it.

```
POST /my_index/_update_by_query
{
  "script": {
    "source": """
          ctx._source.ad.keySet().stream().filter(s -> s.startsWith('Begin')).collect(Collectors.toList()).forEach(k -> ctx._source.ad.remove(k));
          """
  }
}

  ```

