#23-0211 sat 20:31
#update 23-0301

#
library(tidyverse)

read.table(
  pipe("pbpaste"), header = T, sep = "\t"  
) -> anscombe2
anscombe2
anscombe

library(datasets)
datasets::anscombe

anscombe |> select(x,y)           -> anscombe_00
anscombe |> select(contains("1")) -> anscombe_01
anscombe |> select(contains("2")) -> anscombe_02
anscombe |> select(contains("3")) -> anscombe_03

#요약
summary(anscombe_03)
cor.test(anscombe_03$x, anscombe_03$y)

#그래프
ggplot(data = anscombe_03, aes(x = x.3, y = y.3)) +
  geom_point(stat = "identity")

anscombe_03 |> mutate(mean_x = mean(x.3),
                      mean_y = mean(y.3),
                      sd_x = sd(x.3),
                      sd_y = sd(y.3))

#표준편차 구하기
anscombe_03$x.3 |> sum() #99
anscombe_03$x.3 |> length() #11
mean(anscombe_03$x.3) #9
sd(anscombe_03$x.3) #3.31

(8-9)^2 + (8-9)^2 + (8-9)^2 + (8-9)^2 + (8-9)^2 +
  (8-9)^2 + (8-9)^2 + (19-9)^2 + (8-9)^2 +
  (8-9)^2 + (8-9)^2 #110

110/(11-1) #11
sqrt(11) sd

#
그래프
ggplot(data = anscombe_00, aes(x = x, y = y)) +
  geom_point(stat = "identity")

ggplot(data = anscombe_01, aes(x = x.1, y = y.1)) +
  geom_point(stat = "identity")

ggplot(data = anscombe_02, aes(x = x.2, y = y.2)) +
  geom_point(stat = "identity")

ggplot(data = anscombe_03, aes(x = x.3, y = y.3)) +
  geom_point(stat = "identity")




#data saurus
read_tsv("DatasaurusDozen-wide.tsv")
read_tsv("DatasaurusDozen.tsv") -> cairo
table(cairo$dataset)
colnames(cairo)

ggplot(data = cairo, aes(x = x, y = y)) + geom_point() +
  facet_wrap(.~dataset, nrow = 4) +
  geom_smooth(se = F, method = "lm")

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

#dots star x_shape v_lines high_lines

ggplot(aes(x = x, y = y)) + geom_point() +
  facet_wrap(.~dataset, nrow = 4) +
  geom_smooth(se = F) + geom_smooth(se = F, method = "lm")

#-

install.packages("datasauRus")
library(datasauRus)
datasaurus_dozen

datasaurus_dozen |> group_by(dataset) |> 
  summarise(mean = mean(x), 
            sd = sd(x),
            cor = cor(x,y))

datasaurus_dozen_wide |> cor.test(away_x,away_y)
(datasaurus_dozen_wide -> cairo)
cor.test(datasaurus_dozen_wide$away_x, datasaurus_dozen_wide$away_y)

cor.test(cairo$bullseye_x, cairo$bullseye_y)
cor.test(cairo[,c("dino_x", "dino_y")])
cor(cairo[,c("dino_x", "dino_y")])^2*100




