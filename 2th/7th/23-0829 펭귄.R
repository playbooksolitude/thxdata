#23-0829 퀴즈 2 화 20:52

#
library(tidyverse)
#install.packages("palmerpenguins")
library(palmerpenguins)
#library(bookdown)
#install.packages("plotly")
library(plotly)
library(ggrepel)

#이미지
#https://economic-analysis-with-r.uni-goettingen.de/statistical-models.html

#
penguins |> glimpse()


#
penguins |> names()
  # species : 펭귄 종
  # island : 서식지
  # bill_length_mm : 부리 길이
  # bill_depth_mm : 부리 위아래 두께
  # flipper_length_mm : 팔 길이
  # body_mass_g : 몸무게
  # sex : 성별


#
penguins |> dim() #344 * 8


# drop_na()
penguins |> 
  drop_na(bill_length_mm) |> dim() #342 * 8

#NA #344-342 = 2

#
penguins |> summary()
penguins |> 
  ggplot(aes(bill_length_mm, bill_depth_mm)) +
  geom_point(alpha = .1) -> temp_penguins
  ggplotly(temp_penguins)

  
#
penguins |> 
  ggplot(aes(bill_length_mm, bill_depth_mm)) +
  geom_point(alpha = .1) +
  geom_point(data = filter(penguins, 
                      bill_length_mm == 32.10),
             color = "red", size = 3) +
  geom_text_repel(data = filter(penguins, 
                           bill_length_mm == 32.10),
             color = "red", size = 5,
             aes(label = bill_length_mm)) +
  geom_point(data = filter(penguins, 
                           bill_length_mm == 54.2),
             color = "blue", size = 3) +
  geom_text_repel(data = filter(penguins, 
                           bill_length_mm == 54.2),
             color = "blue", size = 5, 
             aes(label = bill_length_mm))

#
penguins |> 
  drop_na(bill_length_mm) |> 
  ggplot(aes(x = bill_length_mm,
             y = bill_depth_mm)) +
  geom_point()

#
penguins |> 
  drop_na(bill_length_mm) |> 
  ggplot(aes(x = bill_length_mm,
             y = bill_depth_mm)) +
  geom_point() + 
  geom_smooth(method = "lm", se = F)

penguins |> colnames()

#species 색깔 입히기
penguins |> 
  drop_na(bill_length_mm) |> 
  ggplot(aes(x = bill_length_mm,
             y = bill_depth_mm,
             color = species)) +
  geom_point() +
  theme(legend.position = "top")

#
penguins |> 
  drop_na(bill_length_mm) |> 
  ggplot(aes(x = bill_length_mm,
             y = bill_depth_mm,
             color = species)) +
  geom_point()  +
  geom_smooth(method = "lm", se = F)+
  theme(legend.position = "top")

penguins |> colnames()

#서식지 
penguins |> 
  drop_na(bill_length_mm) |> 
  ggplot(aes(x = bill_length_mm,
             y = bill_depth_mm,
             color = species)) +
  geom_point()  +
  geom_smooth(method = "lm", se = F) +
  facet_wrap(.~island)+
  theme(legend.position = "top")


#sex #male #Adelie -cor
penguins |> 
  drop_na(bill_length_mm, sex) |> 
  ggplot(aes(x = bill_length_mm,
             y = bill_depth_mm,
             color = species)) +
  geom_point()  +
  geom_smooth(method = "lm", se = F) +
  facet_wrap(.~sex) +
  theme(legend.position = "top")


#서식지 * 성별 #Adelie #all sex #Torgersen
penguins |> 
  drop_na(bill_length_mm, sex) |> 
  ggplot(aes(x = bill_length_mm,
             y = bill_depth_mm,
             color = species)) +
  geom_point(alpha = .2)  +
  geom_smooth(method = "lm", se = F) +
  facet_grid(sex~island) +
  theme(legend.position = "top")

#
penguins |> 
  filter(is.na(sex))

penguins |> 
  drop_na(sex) |> dim()  #333

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
  facet_grid(sex~island) +
  theme(legend.position = "top")

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

