#23-0301 wedn 20:15

#
library(tidyverse)
install.packages("datasauRus")
library(datasauRus)

datasauRus::datasaurus_dozen_wide
datasauRus::datasaurus_dozen



# 구조 파악
datasaurus_dozen |> glimpse()
datasaurus_dozen #|> view()           #엑셀처럼 보기
datasaurus_dozen$dataset |> table()



#
datasaurus_dozen |> 
  filter(dataset == "dino") |> 
  ggplot(aes(x = x, y = y)) +
  geom_point()


datasaurus_dozen |> 
  filter(dataset == "circle") |> 
  ggplot(aes(x = x, y = y)) +
  geom_point()

#
datasaurus_dozen |> 
  ggplot(aes(x = x, y = y)) +
  geom_point() +
  facet_wrap(.~dataset, ncol = 4)

dino == circle


#
datasaurus_dozen |> 
  filter(dataset %in% c("dino")) -> temp_dino

datasaurus_dozen |> 
  filter(dataset %in% c("circle")) -> temp_circle

mean(temp_dino$x);mean(temp_dino$y)
mean(temp_circle$x);mean(temp_circle$y)

#


(table(datasaurus_dozen$dataset) |> 
    as.data.frame() |> 
    as_tibble() |> 
    select(1) -> cairo)

#cor
datasaurus_dozen |> 
  group_by(dataset) |> 
  summarise(mean = mean(x), 
            sd = sd(x),
            cor = cor(x,y))

#all ----------------------------------------------------------------
datasaurus_dozen |> 
  ggplot(aes(x = x, y = y)) + geom_point() +
  facet_wrap(.~dataset, ncol = 5) +
  theme(strip.text = element_text(size = 13))


#선형회귀  #v_lines 제외
datasaurus_dozen |> 
  filter(dataset != "v_lines") |> 
  ggplot(aes(x = x, y = y)) + geom_point() +
  facet_grid(.~dataset) +
  geom_smooth(se = F) + 
  geom_smooth(se = F, method = "lm")


#개별 단위 
  #dino
datasaurus_dozen |> filter(dataset == "dino") |> 
  ggplot(aes(x = x, y = y)) + geom_point() +
  facet_wrap(.~dataset, nrow = 4) +
  geom_smooth(se = F) + geom_smooth(se = F, method = "lm")


  #circle
datasaurus_dozen |> 
  filter(dataset == "circle") |> 
  ggplot(aes(x = x, y = y)) + geom_point() +
  facet_wrap(.~dataset, nrow = 4) +
  geom_smooth(se = F) + geom_smooth(se = F, method = "lm")


  #dots
datasaurus_dozen |> 
  filter(dataset == "dots") |> 
  ggplot(aes(x = x, y = y)) + geom_point() +
  facet_wrap(.~dataset, nrow = 4) +
  geom_smooth(se = F) + geom_smooth(se = F, method = "lm")
