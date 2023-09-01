#23-0827 sun 15:31

#
library(tidyverse)

#1-1 data set size
starwars |> glimpse() #87 * 14

#1-2
starwars |> 
  ggplot(aes(x = gender, y = birth_year)) +
  geom_point()

#1-3
starwars |> 
  ggplot(aes(x = mass, y = height)) +
  geom_point()
  geom_boxplot()

#1-4

#
gss_cat #|> colnames()
x = race
y = relig
gss_cat |> count(race, relig) |> 
  ggplot(aes(x = race, y = relig, fill = n)) +
  geom_tile() +
  geom_text(aes(label = n), color = "white")


