#23-0907 #thu #10:52

#
library(tidyverse)
library(palmerpenguins)
library(googlesheets4)
library(bbplot)
library(showtext)
showtext_auto()

#https://bbc.github.io/rcookbook/
#install.packages('devtools')
#devtools::install_github('bbc/bbplot')

# 일반
penguins |> 
  count(species, island)

#피벗
#pivot_wider
penguins |> 
  count(species, island) |> 
  pivot_wider(names_from = island,
    values_from = n) 


#pivot_wider 2개 변수 묶어서 표현
penguins |> 
  count(species, island, sex) |> 
  pivot_wider(names_from = c(species, sex),
    values_from = n) 


# 
library(googlesheets4)
read_sheet("https://docs.google.com/spreadsheets/d/1-fj7ZMOVpdtH2whVO8HnOFlUr-zL4wxTnkBUCbkj-KM/edit#gid=0") -> thx_1pivot


#
(thx_1pivot |> 
     pivot_longer(
       cols = c("10시30분":"15시30분"),   #143 * 9
       names_to = "시간대",
       values_to = "방문자수")  -> thx_2pivot)

#
thx_2pivot |> 
  mutate(
    연도 = year(날짜),
    월 = month(날짜),
    일 = day(날짜), .before = 1) |> select(-날짜) -> thx_3tidy

#
thx_3tidy |> 
  filter(월 == "1", 장소 == "제주") |> 
  ggplot(aes(x = 시간대, y = 방문자수)) +
  geom_line(stat = "identity", group = 1) +
  scale_x_discrete(breaks = c("11시", "12시", "13시", 
                            "14시", "15시")) +
  bbc_style() +
  geom_point(size = 3) +
  geom_label(aes(label = 방문자수), size = 7) +
  labs(subtitle = "제주 방문자수")


#15시 30분 제거
thx_3tidy |> 
  filter(시간대 != "15시30분") |> 
  filter(월 == "1", 장소 == "제주") |> 
  ggplot(aes(x = 시간대, y = 방문자수)) +
  geom_line(stat = "identity", group = 1) +
  scale_x_discrete(breaks = c("11시", "12시", "13시", 
    "14시", "15시")) +
  bbc_style() +
  geom_point(size = 3) +
  geom_label(aes(label = 방문자수), size = 7) +
  labs(subtitle = "제주 방문자수
    ")


#15시 30분 제거
thx_3tidy |> 
  filter(시간대 != "15시30분") |> 
  filter(월 == "3", 장소 == "경기") |> 
  ggplot(aes(x = 시간대, y = 방문자수)) +
  geom_line(stat = "identity", group = 1) +
  scale_x_discrete(breaks = c("11시", "12시", "13시", 
    "14시", "15시")) +
  bbc_style() +
  geom_point(size = 3) +
  geom_label(aes(label = 방문자수), size = 7) +
  labs(subtitle = "경기 방문자수")
