require(ggplot2)
require(dplyr)

source("Access data.world Database.R")

x = df[, "v_9"]
y = df[, "v_6"]
z = df[, "v_1"]
df=data.frame(x,y,z)

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

