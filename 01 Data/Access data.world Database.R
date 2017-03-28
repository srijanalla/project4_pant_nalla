require("jsonlite")
require("RCurl")

# Leaving username and key in to avoid error during R Markdown knitting, especially if replicated. Normally would be left as uredacted and predacted and changed through the console.
uredacted = 'srijanalla'
predacted = 'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJwcm9kLXVzZXItY2xpZW50OnNyaWphbmFsbGEiLCJpc3MiOiJhZ2VudDpzcmlqYW5hbGxhOjozMWY0MDM3Mi0xZmZlLTQ3ZDgtYTg1NS1hMjU2NmM2MmUxZGIiLCJpYXQiOjE0ODQ2OTcyNzMsInJvbGUiOlsidXNlcl9hcGlfd3JpdGUiLCJ1c2VyX2FwaV9yZWFkIl0sImdlbmVyYWwtcHVycG9zZSI6dHJ1ZX0.5q00lu9-0EIhCMalKDcH41Hsdy9vIlFZSr0_nbwvtNNSg4CqwCXQuib1q0Ub2LGd24rAjHZzsJaANO7mIUXvJw'

df <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ",'oraclerest.cs.utexas.edu:5012/rest/native/?query="select * from unemp"')),httpheader=c(DB='jdbc:data:world:sql:srijanalla:s-17-dv-project-4', USER=uredacted, PASS=predacted, MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE) ))
print(summary(df))
print(head(df))