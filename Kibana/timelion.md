suppose you have a timestamp field as below and you want to color it to green.

`"created": "2017-09-14T08:32:33.000Z"`

Then your expression goes like this.
 
`.es(q="created:[2017-09-13 TO 2017-09-15]", offset=-1s,index=hotel, timefield='created', metric='avg:daily_rate').label('rate').color(green)`

If you want to hide it, you can make it white as below.

`.es(q="created:[2017-09-13 TO 2017-09-15]", offset=-1s,index=hotel, timefield='created', metric='avg:daily_rate').label('rate').color(white)`
