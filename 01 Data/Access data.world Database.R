require("jsonlite")
require("RCurl")

# Leaving username and key in to avoid error during R Markdown knitting, especially if replicated. Normally would be left as uredacted and predacted and changed through the console.
uredacted = 'mustafan'
predacted = 'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJwcm9kLXVzZXItY2xpZW50Om11c3RhZmFuIiwiaXNzIjoiYWdlbnQ6bXVzdGFmYW46OjliMmVlZWZlLTRiYjUtNGMxZi04MGQyLTU3NGJlOTNlOTU1OSIsImlhdCI6MTQ4NDY5NzMyOSwicm9sZSI6WyJ1c2VyX2FwaV93cml0ZSIsInVzZXJfYXBpX3JlYWQiXSwiZ2VuZXJhbC1wdXJwb3NlIjp0cnVlfQ.2QJRexWICcpv-uwNx3eJuhEkUV2BPV6_lFjfJ5yiMuhLNNgX52ecEbcusVNWfHMrFKow_8QtjC692YIX4sFXHA'

df <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ",'oraclerest.cs.utexas.edu:5000/rest/native/?query="select * from unemp"')),httpheader=c(DB='jdbc:data:world:sql:mustafan:s-17-edv-project-2', USER=uredacted, PASS=predacted, MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE) ))
print(summary(df))
print(head(df))