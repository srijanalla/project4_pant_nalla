require(ggplot2)
require(dplyr)
require(jsonlite)
require(RCurl)

# Leaving username and key in to avoid error during R Markdown knitting, especially if replicated. Normally would be left as uredacted and predacted and changed through the console.
uredacted = 'srijanalla'
predacted = 'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJwcm9kLXVzZXItY2xpZW50OnNyaWphbmFsbGEiLCJpc3MiOiJhZ2VudDpzcmlqYW5hbGxhOjozMWY0MDM3Mi0xZmZlLTQ3ZDgtYTg1NS1hMjU2NmM2MmUxZGIiLCJpYXQiOjE0ODQ2OTcyNzMsInJvbGUiOlsidXNlcl9hcGlfd3JpdGUiLCJ1c2VyX2FwaV9yZWFkIl0sImdlbmVyYWwtcHVycG9zZSI6dHJ1ZX0.5q00lu9-0EIhCMalKDcH41Hsdy9vIlFZSr0_nbwvtNNSg4CqwCXQuib1q0Ub2LGd24rAjHZzsJaANO7mIUXvJw'

df <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ",'oraclerest.cs.utexas.edu:5012/rest/native/?query="select * from unemp"')),httpheader=c(DB='jdbc:data:world:sql:srijanalla:s-17-dv-project-4', USER=uredacted, PASS=predacted, MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE) ))

df=df %>% dplyr::rename(x=v_9, y=v_6, z=v_1)

server <- function(input, output) {
  output$plot1 <- renderPlot({
    ggplot(df) + geom_point(aes(x=x, y=y, colour=z, size=4)) + guides(size=FALSE) + xlab("Adult Unemployment Rates") + ylab("Youth Unemployment Rates") +
      ggtitle("Comparing Adult and Youth Unemployment Rates by Continent") + theme(plot.title = element_text(hjust = 0.5))
  })
  
  output$plot2 <- renderPlot({
    brush = brushOpts(id="plot_brush", delayType = "throttle", delay = 30)
    bdf=brushedPoints(df, input$plot_brush)
    if( !is.null(input$plot_brush) ) {
      df %>% dplyr::filter(x %in% bdf[, "x"]) %>% ggplot() + geom_point(aes(x=x, y=y, colour=z, size=4)) + guides(size=FALSE) + xlab("Adult Unemployment Rates") + ylab("Youth Unemployment Rates") +
        ggtitle("Comparing Adult and Youth Unemployment Rates by Continent (Brushed)") + theme(plot.title = element_text(hjust = 0.5))
    } 
  })
}

