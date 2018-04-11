# How to capture requests when "Dashboard" is created.


Steps
=====

1. Go to https://toolbox.googleapps.com/apps/har_analyzer/
   Then follow the steps
   
   
2. This is what it looks like

Notice that there is a request going to "_msearch" endpoint
![image1](https://github.com/TomonoriSoejima/Tejun/blob/master/page1.png?raw=true "page1")

3. Drill down to "_msesarch" request and check the request payload
![image2](https://github.com/TomonoriSoejima/Tejun/blob/master/page2.png?raw=true "page2")


4. Get the request body
   You will notice that there are 2 json objects.
   You will need the 2nd json object
   

5. (optional) Run it through [search profiler](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-profile.html#search-profile) to measure the performance of the request.


![profiler](https://github.com/TomonoriSoejima/Tejun/blob/master/profiler.png?raw=true "profiler")
