
$ cat shards.counter.checker.sh

file=$1
for i in kb mb gb; do
    echo snumber of shards whose size is in $i : $(grep -c $i $file)
done


example


[mbp:scripts]$ sh shards.counter.checker.sh !$
sh shards.counter.checker.sh /Users/surfer/Downloads/nokia/diagnostics-20171129-143143/cat_shards.txt
snumber of shards whose size is in kb : 3375
snumber of shards whose size is in mb : 5421
snumber of shards whose size is in gb : 1532

