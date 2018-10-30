if [ $# -eq 0 ]
  then
    echo "No arguments supplied"
    echo "Please specify full path to slow log file"
    exit
fi
path=$1

cat $path | while read line
do
	index=$(echo $line | awk -F ' ' '{print $3}' | sed -e 's/^\[//' -e s/\]// | awk -F '[' '{print $1}')
	echo "GET $index/_search"
	echo $line | awk -F ' ' '{print $11}' | sed -e s,^source,,  -e 's/^\[//'  -e s/\],$// | jq -r  . 
	echo ""
done
