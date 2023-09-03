#23-0829 퀴즈 2 화 20:52

#
library(tidyverse)
library(palmerpenguins)
library(bookdown)
library()

#https://economic-analysis-with-r.uni-goettingen.de/statistical-models.html

#https://blog.naver.com/PostView.naver?blogId=bestinall&logNo=222579966945

#
penguins |> 
  drop_na(bill_depth_mm) |> 
  ggplot(aes(bill_depth_mm, 
             bill_length_mm)) +
  geom_point() +
  geom_smooth(method = "lm", se = F)

#
penguins |> 
  drop_na(bill_depth_mm, sex) |> 
  ggplot(aes(body_mass_g, 
             flipper_length_mm, 
             color = species)) +
  geom_point() +
  geom_smooth(method = "lm", se = F) +
  facet_grid(sex~island)

#
anscombe |> 
  ggplot(aes(x = x, y = y)) +
  geom_point(stat = "identity") +
#  geom_text_repel(aes(label = y)) +
  geom_smooth(method = "lm", se = F)

anscombe |> 
  ggplot(aes(x = x.1, y = y.1)) +
  geom_point() +
  geom_smooth(method = "lm", se = F)

par(mar=c(1, 2, 2, 1), mfrow=c(2, 2))

