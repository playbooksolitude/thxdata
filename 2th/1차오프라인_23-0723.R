#23-0721 fri 14:17

#1장
library(tidyverse)
#install.packages("devtools")
#devtools::install_github('bbc/bbplot')
library(bbplot)


mpg
mpg |> count(manufacturer)
mpg |> count(manufacturer, drv)
mpg |> count(manufacturer, drv) |> 
  pivot_wider(names_from = drv,
    values_from = n)
mpg |> count(manufacturer, model, class) |> 
  pivot_wider(names_from = class,
    values_from = n)

#
ggplot(data = mpg, 
  aes(x = class,
      y = after_stat(count),
    fill = drv)) +
  geom_bar(stat = "count")

ggplot(data = mpg, 
  aes(x = class,
    y = after_stat(count),
    fill = drv)) +
  geom_bar(stat = "count",
    position = "dodge")

ggplot(data = mpg, 
  aes(x = class,
    y = after_stat(count),
    fill = drv)) +
  geom_bar(stat = "count",
    position = "fill")

ggplot(data = mpg, 
  aes(x = class,
    y = after_stat(count),
    fill = drv)) +
  geom_bar(stat = "count",
    position = "dodge",
    show.legend = F) +
  bbc_style() 

#
mpg |> ggplot(aes(x = displ, y = hwy)) +
  geom_point(stat = "identity")

mpg |> ggplot(aes(x = displ, y = hwy, color = drv)) +
  geom_point(stat = "identity")

mpg |> ggplot(aes(x = displ, y = hwy, color = drv)) +
  geom_point(stat = "identity") +
  facet_wrap(.~drv)

mpg |> ggplot() +
  geom_point(data = select(mpg, -drv), 
    aes(x = displ, y = hwy), 
    color = "grey",
    stat = "identity") +
  geom_point(aes(x = displ, y = hwy, color = drv),
    stat = "identity") +
  facet_wrap(.~drv)

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


