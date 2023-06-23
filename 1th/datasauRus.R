#23-0301 wedn 20:15

#
library(tidyverse)
install.packages("datasauRus")
library(datasauRus)

#dataset
datasauRus::datasaurus_dozen_wide
datasauRus::datasaurus_dozen
table(datasaurus_dozen$dataset) |> as.data.frame() |> as.tibble() |> 
  select(1) -> cairo

#cor
datasaurus_dozen |> group_by(dataset) |> 
  summarise(mean = mean(x), 
            sd = sd(x),
            cor = cor(x,y))

#all ----------------------------------------------------------------
datasaurus_dozen |> 
  ggplot(aes(x = x, y = y)) + geom_point() +
  facet_wrap(.~dataset, ncol = 5) #+
  geom_smooth(se = F) + 
  geom_smooth(se = F, method = "lm")

datasaurus_dozen |> 
  ggplot(aes(x = x, y = y)) + geom_point() +
  facet_grid(.~dataset) +
  geom_smooth(se = F) + 
  geom_smooth(se = F, method = "lm")

#개별 단위
datasaurus_dozen |> filter(dataset == "dino") |> 
  ggplot(aes(x = x, y = y)) + geom_point() +
  facet_wrap(.~dataset, nrow = 4) +
  geom_smooth(se = F) + geom_smooth(se = F, method = "lm")

datasaurus_dozen |> filter(dataset == "circle") |> 
  ggplot(aes(x = x, y = y)) + geom_point() +
  facet_wrap(.~dataset, nrow = 4) +
  geom_smooth(se = F) + geom_smooth(se = F, method = "lm")

datasaurus_dozen |> filter(dataset == "dots") |> 
  ggplot(aes(x = x, y = y)) + geom_point() +
  facet_wrap(.~dataset, nrow = 4) +
  geom_smooth(se = F) + geom_smooth(se = F, method = "lm")