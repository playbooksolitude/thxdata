#23-0907 #thu #

#
library(plotly)

#
x= list("Sales", "Consulting", "Net revenue", "Purchases", "Other expenses", "Profit before tax")

measure= c("relative", "relative", "total", "relative", "relative", "total")

text= c("+60", "+80", "", "-40", "-20", "Total")

y= c(60, 80, 0, -40, -20, 0)

data = data.frame(x=factor(x,levels=x),measure,text,y)

data

fig

fig <- plot_ly(
  data, 
  name = "20", 
  type = "waterfall", 
  measure = ~measure,
  x = ~x, 
  textposition = "outside", 
  y= ~y, 
  text =~text,
  connector = list(line = list(color= "rgb(63, 63, 63)")))

fig <- fig %>%
  layout(title = "Profit and loss statement 2018",
    xaxis = list(title = ""),
    yaxis = list(title = ""),
    autosize = TRUE,
    showlegend = TRUE)

fig
#
