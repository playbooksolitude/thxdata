#23-0815 화 22:31

#
library(tidyverse)
library(readxl)

#
(read_excel("./2th/5st/excel/KOBIS_2018.xlsx",
           skip = 4) -> kobis2018_1excel)

#2
kobis2018_1excel |> glimpse()

kobis2018_1excel |> 
  mutate(
    연도 = year(개봉일),
    월 = month(개봉일), 
    일 = day(개봉일), .before = 3) |> 
  select(-c(개봉일, 
            `매출액\n점유율`,국적)) -> kobis2018_2select

#3 adult
kobis2018_2select |> head()
kobis2018_2select |> 
  slice(3990:4000) |>
  select(1:9)

kobis2018_2select |> dim()
kobis2018_2select |> 
  filter(관객수 > 1000)


# ----------------------------------------------------------
library(nycflights13)
flights |> count(origin)
flights |> count(dest)
table(flights$month)

# 
flights |> 
  group_by(origin, dest) |> 
  summarise(n = n())

#
flights |> 
  group_by(origin, dest, distance) |> 
  summarise()

flights |> 
  select(origin, dest, distance)

# origin -> dest, distance 개수
flights |> 
  group_by(origin, dest, distance) |> 
  summarise(n = n())

# dest, distance 개수
flights |> 
  group_by(dest, distance) |> 
  summarise(n = n())


# ggplot #tile #운항횟수
flights |> 
  group_by(origin, dest) |> 
  summarise(n = n()) |> 
  filter(n > 1000) |> 
  ggplot(aes(x = origin, 
             y = dest,
             fill = n)) +
  geom_tile() +
  geom_text(aes(label = n), color = "white") +
  scale_fill_gradient(low = "grey", high = "red")


# 거리
flights |> 
  group_by(origin, dest, distance) |> 
  summarise() |> 
  filter(distance > 1000) |> 
  ggplot(aes(x = origin, 
             y = dest,
             fill = distance)) +
  geom_tile() +
  geom_text(aes(label = distance), color = "white") +
  scale_fill_gradient(low = "grey", high = "red") +
  #facet_wrap(.~origin, scales = "free") +
  labs(title = "origin ~ dest, distance") +
  theme(legend.position = "top",
        panel.background = element_blank())


# ggplot #tile
flights |> 
  filter(month %in% c("1","7")) |> 
  group_by(month, origin, dest) |> 
  summarise(n = n()) |> 
  #filter(n > 1000) |> 
  ggplot(aes(x = origin, 
             y = dest,
             fill = n)) +
  geom_tile() +
  geom_text(aes(label = n), color = "white") +
  scale_fill_gradient(low = "grey", high = "red") +
  facet_wrap(.~month)



# 2019년
(read_excel("./2th/5st/excel/KOBIS_2019.xlsx",
           skip = 4) -> kobis2019_1excel)

# 2020년
(read_excel("./2th/5st/excel/KOBIS_2020.xlsx",
            skip = 4) -> kobis2020_1excel)

# 2021년
(read_excel("./2th/5st/excel/KOBIS_2021.xlsx",
            skip = 4) -> kobis2021_1excel)

# 2022년
(read_excel("./2th/5st/excel/KOBIS_2022.xlsx",
            skip = 4) -> kobis2022_1excel)

# 





