#23-0824 thu 14:43

#
library(tidyverse)
library(readxl)
library(bbplot)
library(scales)
library(showtext)
showtext_auto()
library(ggrepel)
library(colorspace)
library(nord)


#
starwars |> dim() #87 * 14

#
starwars |> drop_na() |> dim()  #29 * 14

#
starwars

# dataset size check
colSums(is.na(starwars)) |> 
  as.data.frame() |> 
  rownames_to_column(var = "name") |> 
  rename("NA" = 2) |> 
  pivot_wider(names_from = "name", 
    values_from = "NA") |> 
  view()

#
starwars
starwars$mass |> table()

#
starwars |> 
  ggplot(aes(x =species, y = birth_year)) +
  geom_boxplot()

#
ggplot(starwars, aes(x = species, y = birth_year)) +
  geom_point()

#
starwars |> 
  count(species, gender, sort = T) |> dim() #42 * 3

#
starwars |> 
  count(species, sex, sort = T) |> dim() #41 * 3

#
starwars |> count(species, gender) |> 
  ggplot(aes(x = gender, y = species, fill = n)) +
  geom_tile() +
  scale_fill_gradient(low = "grey", high = "red") +
  geom_text(aes(label = n))

#
starwars |> names()

#
data()


# 극장관객수
read_excel("./2th/5st/excel/rawdata/KOBIS_2019.xlsx", 
  skip = 4) -> kobis2019_1excel

#
kobis2019_1excel |> 
  mutate(
    연도 = year(개봉일),
    월 = month(개봉일),
    일 = day(개봉일), .before = 3) -> kobis2019_2date

#
kobis2019_2date |> 
  drop_na(월) |> 
  summarise(누적관객수 = sum(관객수)) #226172268


#
kobis2019_2date |> 
  drop_na(월) |> 
  group_by(월) |> 
  summarise(월별관객수 = sum(관객수)) |> 
  ggplot(aes(x = factor(월), y = 월별관객수)) +
  geom_bar(stat = "identity") +
  scale_y_continuous(labels = comma) +
  bbc_style() +
  geom_label_repel(aes(label = comma(월별관객수)))


#
# 극장관객수 2020
(read_excel("./2th/5st/excel/rawdata/KOBIS_2020.xlsx", 
  skip = 4) -> kobis2020_1excel)

#
kobis2020_1excel |> 
  mutate(
    연도 = year(개봉일),
    월 = month(개봉일),
    일 = day(개봉일), .before = 3) -> kobis2020_2date

#
kobis2020_2date |> 
  drop_na(월) |> 
  summarise(누적관객수 = sum(관객수)) #59312643

#
kobis2020_2date |> 
  drop_na(월) |> 
  group_by(월) |> 
  summarise(월별관객수 = sum(관객수)) |> 
  ggplot(aes(x = factor(월), y = 월별관객수)) +
  geom_bar(stat = "identity") +
  scale_y_continuous(labels = comma) +
  bbc_style() +
  geom_label_repel(aes(label = comma(월별관객수)))


#
full_join(kobis2019_2date, 
  kobis2020_2date)

#
kobis2019_2date |> 
  mutate(개봉연도 = "2019", .before = 3) -> kobis2019_3year
  
kobis2020_2date |> 
  mutate(개봉연도 = "2020", .before = 3) -> kobis2020_3year

#
full_join(kobis2019_3year, 
  kobis2020_3year) -> kobis_3join


# Covid-19 극장관객수 비교 2019 vs 2020
kobis_3join |> 
  drop_na(월) |> 
  group_by(개봉연도, 월) |> 
  summarise(월별관객수 = sum(관객수)) |> 
  ggplot(aes(x = factor(월), 
    y = 월별관객수, fill = 개봉연도)) +
  geom_bar(stat = "identity", position = "dodge") +
  scale_y_continuous(labels = comma) +
  bbc_style() +
  #geom_label_repel(aes(label = 월별관객수)) +
  #scale_fill_discrete_qualitative("set 2") 
  scale_fill_nord("afternoon_prarie") +
  labs(subtitle = "Covid-19 극장관객수 비교")
  
colorspace::hcl_palettes(plot = T)  
nord::nord_palettes  

#
kobis2019_3year |> 
  filter(관객수 > 50000) |> 
  drop_na(등급) |> 
  count(대표국적, 등급) |> 
  #distinct(등급)
  ggplot(aes(등급, 대표국적, fill = n)) +
  geom_tile() +
  scale_fill_gradient(low = "grey",high = "red")


# 일별 관객수
kobis2019_3year |> 
  drop_na(일) |> 
  count(일, sort = T) |> 
  ggplot(aes(x = factor(일), y = n, fill = n)) +
  geom_bar(stat = "identity") +
  scale_fill_gradient(low = "grey", high = "red")


# 감독
kobis2019_3year |> 
  drop_na(연도) |> 
  filter(관객수 > 1000000) |> 
  group_by(감독) |> 
  summarise(관객수, n = n()) |> 
  arrange(desc(n)) 


#
kobis2019_3year |> 
  drop_na(연도) |> 
  filter(관객수 > 1000000) |> 
  separate(col = 배우, 
    into = c("배우1", "배우2", "배우3", "배우4", "배우5"),
    sep = ",") |> 
  select(영화명, 관객수, 배우1, 배우2, 
    배우3, 배우4, 배우5) |> 
  pivot_longer(cols = c(3:7), 
    names_to = "배우리스트", 
    values_to = "배우이름") |> 
  drop_na(배우이름) |> 
  count(배우이름, sort = T)


#
str_match(kobis2019_3year$배우, "마동석") 


#
kobis2019_3year |> 
  drop_na(월) |> 
  filter(관객수 > 100000) |> 
  ggplot(aes(x = 영화명, y = 대표국적, fill = 관객수)) +
  geom_bar(stat = "identity") +
  facet_wrap(.~등급, scales = "free") +
  coord_flip()

#
kobis2019_3year |> 
  drop_na(월) |> 
  filter(관객수 > 100000) |> 
  group_by(등급, 대표국적) |> 
  summarise(관객수합계 = sum(누적관객수), n = n()) |> 
  ggplot(aes(x = 등급, y = 대표국적, fill = n)) +
  geom_tile() +
  scale_fill_gradient(low = "grey", high = "red") +
  geom_text(aes(label = n))


#
kobis2019_3year |> 
  drop_na(월) |> 
  filter(관객수 > 100000) |> 
  group_by(대표국적, 등급) |> 
  summarise(관객수합계 = sum(누적관객수)) |> 
  ggplot(aes(x = 등급, y = 대표국적, fill = 관객수합계)) +
  geom_tile() +
  geom_text(aes(label = comma(관객수합계)), 
    color = "white") +
  theme(legend.position = "none") +
  scale_fill_gradient(low = "grey", high = "red")


#
kobis2019_3year |> 
  drop_na(월) |> 
  filter(관객수 > 100000) |> 
  group_by(대표국적, 등급) |> 
  summarise(관객수합계 = sum(누적관객수)) -> kobis2019_4levels

#
fct_relevel(kobis2019_4levels$등급, 
  c("전체관람가","12세이상관람가",
    "15세이상관람가", "청소년관람불가")) -> kobis2019_4levels$등급

#
kobis2019_4levels$등급 |> fct_relevel()

#
kobis2019_4levels |> 
  ggplot(aes(x = 등급, y = 대표국적, fill = 관객수합계)) +
  geom_tile() +
  geom_text(aes(label = comma(관객수합계)), 
    color = "white") +
  theme(legend.position = "none") +
  scale_fill_gradient(low = "grey", high = "red")

#
kobis2019_3year |> 
  filter(대표국적 == "한국") |> 
  select(1:2, 관객수, 등급)

#
kobis2019_3year |> 
  filter(대표국적 == "미국") |> 
  select(1:2, 관객수, 등급)

#
kobis2019_3year |> 
  filter(대표국적 %in% 
      c("프랑스", "벨기에", "러시아", "대만")) |> 
  select(1:2, 등급, 대표국적, 관객수)

#