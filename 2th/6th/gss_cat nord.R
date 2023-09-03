#23-0827 sun 09:13

#
library(tidyverse)
library(gt)
library(nord)
library(colorspace)

gss_cat$race |> table()
gss_cat |> names()
gss_cat |> glimpse()
gss_cat |> str()
gss_cat |> view()

#
table(gss_cat$race, gss_cat$relig) 
table(gss_cat$relig, useNA = "always")
gss_cat |> 
  count(race, relig) |> 
  ggplot(aes(x = race, y = relig, fill = n)) + 
  geom_tile() +
  scale_fill_gradient(low = "grey", high = "red") +
  theme(panel.background = element_blank()) +
  geom_text(aes(label = n))
  

#
gss_cat |> 
  count(rincome, race) |> 
  ggplot(aes(y = rincome, x = race, fill = n)) + 
  geom_tile() +
  theme(panel.background = element_blank()) +
  geom_text(aes(label = n)) +
#  scale_fill_nord("snowstorm", discrete = F, reverse = T)
  scale_fill_continuous_sequential("Heat2")
  
nord_palettes
colorspace::hcl_palettes(plot = T)
scale_fill_discrete_qualitative()
colorspace::hcl_palettes(n = 5)

