#23-0814 mon 12:34

#
library(ggplot2)
install.packages("plotly")
library(plotly)

#
set.seed(100)
d <- diamonds[sample(nrow(diamonds), 1000), ]
p <- ggplot(data = d, aes(x = carat, y = price)) +
  geom_point(aes(text = paste("Clarity:", clarity)), size = .5) +
  geom_smooth(aes(colour = cut, fill = cut)) + 
  facet_wrap(~ cut)
ggplotly(p)

#
(mpg |> 
  ggplot(aes(x = drv, y = hwy)) +
  geom_point(aes(text = paste(manufacturer, model))) +
  facet_wrap(.~class) -> p2)
  ggplotly(p2)

  
#
# install.packages("devtools")
devtools::install_github("rstudio/ggvis")
library(ggvis)

mtcars %>% ggvis(~mpg, ~wt) %>% layer_points()
?plotly

  



    