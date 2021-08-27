# Hamama - Website

The repository contains, the greenhouse website which written in html, css and javascript. the data on the website is from the database,
which contains the updated measures from the physical greenhousde.
the project, is written with Google App Engine (in order to get it running on google cloud.)

In the website, there is a server, which the website is using in order to trasfer information from the database. 
it is also possible to upload data to the database through the server, with the following api:
	
```
Add a new measure to a specific sensor: 
http://<ip address>:8080/board?cmd=measure&sid=<sid>&time=<time>&value=<12.4>

Add a new measure to the log: 
http://<ip address>:8080/board?cmd=log&sid=<sid>&time=<time>&priority=<1-3>&message=<message>
```

# Screenshot's from the website:
