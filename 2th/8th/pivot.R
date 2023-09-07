#23-0907 #thu #10:52

#
library(tidyverse)


#pivot_wider
penguins |> 
  count(species, island) |> 
  pivot_wider(names_from = island,
    values_from = n) 


#pivot_wider c()
penguins |> 
  count(species, island, sex) |> 
  pivot_wider(names_from = c(species, sex),
    values_from = n) |> view()


#
penguins |> 
  count(species, island) |> 
  pivot_longer(cols = island, 
    names_to = "name",
    values_to = "value")
