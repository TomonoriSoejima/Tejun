```
GET hotel/_search?size=1
{
  "_source": [
    "created"
  ],
  "script_fields": {
    "changed_time": {
      "script": {
        "source": """
      
          def datetime = doc['created'].value;
          String localStr1 = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(datetime);
          ZonedDateTime zdt = ZonedDateTime.parse(localStr1);
          ZonedDateTime updatedZdt = zdt.plusMinutes(330);
          return updatedZdt.getHour();

        """
      }
    },
    "changed_time2": {
      "script": {
        "source": """
      
       def  datetime = doc['created'].value;
          String localStr1 = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(datetime);
          ZonedDateTime zdt = ZonedDateTime.parse(localStr1);
          ZonedDateTime updatedZdt = zdt.plusMinutes(330);
          //return updatedZdt;
          
def  bon = updatedZdt.dayOfWeek;
return bon.getValue() + "(" + ["", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"][bon.getValue()] + ")"


        """
      }
    }
  }
}
```
