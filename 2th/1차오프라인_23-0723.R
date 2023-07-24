#23-0721 fri 14:17

#1장
library(tidyverse)
#install.packages("devtools")
#devtools::install_github('bbc/bbplot')
library(bbplot)

install.packages("showtext")
library(showtext)
install.packages("gt")
#


#


library(RColorBrewer)
display.brewer.pal()
display.brewer.all()

mpg |> ggplot() +
  geom_point(data = select(mpg, -drv), 
    aes(x = displ, y = hwy), 
    color = "grey",
    stat = "identity") +
  geom_point(aes(x = displ, y = hwy, color = drv),
    stat = "identity") +
  facet_wrap(.~drv)


#



#


