#23-0824 thu 14:43

#
library(tidyverse)

#1 starwars
# 데이터셋 사이즈
starwars |> dim() #87 * 14

#
starwars |> drop_na() |> dim()  #29 * 14

#
starwars

# pivot #예습
# dataset size check
colSums(is.na(starwars)) |> 
  as.data.frame() |> 
  rownames_to_column(var = "name") |> 
  rename("NA" = 2) |> 
  pivot_wider(names_from = "name", 
    values_from = "NA") #|> 
  view()


# 몇개의 인수가 있는지 확인하기
  # useNA 중요
  # "ifany" 와 "always" 용법 차이
starwars$gender |> table(useNA = "always")
mpg$manufacturer |> table(useNA = "always")
mpg$manufacturer |> table(useNA = "ifany")


#
ggplot(starwars, aes(x = gender, y = birth_year)) +
  geom_point()


starwars |> 
  ggplot(aes(x = gender, y = birth_year)) +
  geom_boxplot()

#
starwars |> 
  count(species, gender, sort = T) #|> dim() #42 * 3

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


#
library(readxl)
# 극장관객수
(read_excel("./2th/5st/excel/rawdata/KOBIS_2019.xlsx", 
  skip = 4) -> kobis2019_1excel)

#
(kobis2019_1excel |> 
  mutate(
    연도 = year(개봉일),
    월 = month(개봉일),
    일 = day(개봉일), .before = 3) -> kobis2019_2date)

#
(kobis2019_2date |> 
  drop_na(월) |> 
  summarise(누적관객수 = sum(관객수))) #226172268


# --------------------------------------------------------
library(scales)
library(bbplot)
library(showtext)
showtext_auto()
library(ggrepel)
#
kobis2019_2date |> 
  drop_na(월) |> 
  group_by(월) |> 
  summarise(월별관객수 = sum(관객수)) |> 
  ggplot(aes(x = factor(월), y = 월별관객수/10000)) +
  geom_bar(stat = "identity") +
  scale_y_continuous(labels = comma) +
  bbc_style() +
  geom_label(aes(label = comma(월별관객수/10000)), size = 5) +
  labs(subtitle = "단위: 만 명", 
    title = "2019년 월별 극장관객수")



# --------------------------------------------------------
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
  ggplot(aes(x = factor(월), y = 월별관객수/10000)) +
  geom_bar(stat = "identity") +
  scale_y_continuous(labels = comma) +
  bbc_style() +
  geom_label(aes(label = comma(월별관객수/10000)), size = 5) +
  labs(subtitle = "단위: 만 명", 
    title = "2020년 월별 극장관객수")


# 2019년 2020년 합치기
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


library(nord)
# Covid-19 극장관객수 비교 2019 vs 2020
kobis_3join |> 
  drop_na(월) |> 
  group_by(개봉연도, 월) |> 
  summarise(월별관객수 = sum(관객수)) |> 
  ggplot(aes(x = factor(월), 
    y = 월별관객수/10000, fill = 개봉연도)) +
  geom_bar(stat = "identity", position = "dodge") +
  scale_y_continuous(labels = comma) +
  bbc_style() +
  scale_fill_nord("afternoon_prarie") +
  labs(title = "Covid-19 전/후 극장관객수 비교", 
    subtitle = "단위: 만 명")
  
nord::nord_palettes  

# 국가 * 시청등급
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


# 배우
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



# 시청 등급 * 국적 * 10만명 이상 영화편수
kobis2019_3year |> 
  drop_na(월) |> 
  filter(관객수 > 100000) |> 
  group_by(등급, 대표국적) |> 
  summarise(관객수합계 = sum(누적관객수), n = n()) |> 
  ggplot(aes(x = 등급, y = 대표국적, fill = n)) +
  geom_tile() +
  scale_fill_gradient(low = "grey", high = "red") +
  geom_text(aes(label = n))



# 시청 등급 * 국적 * 10만명 이상 * 누적관객수 
# 순서 변경 필요 sample A
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
(fct_relevel(kobis2019_4levels$등급, 
  c("전체관람가",
    "12세이상관람가",
    "15세이상관람가", 
    "청소년관람불가")) -> kobis2019_4levels$등급)

#
kobis2019_4levels$등급 |> fct_relevel()
kobis2019_3year$등급 |> fct_relevel()


# 순서 변경 완료 sample B
kobis2019_4levels |> 
  ggplot(aes(x = 등급, y = 대표국적, fill = 관객수합계)) +
  geom_tile() +
  geom_text(aes(label = comma(관객수합계)), 
    color = "white") +
  theme(legend.position = "none") +
  scale_fill_gradient(low = "grey", high = "red")


#한국영화 top
kobis2019_3year |> 
  filter(대표국적 == "한국") |> 
  select(1:2, 관객수, 등급)

# 미국 영화 top
kobis2019_3year |> 
  filter(대표국적 == "미국") |> 
  select(1:2, 관객수, 등급)

# 기타 영화
kobis2019_3year |> 
  filter(대표국적 %in% 
      c("프랑스", "벨기에", "러시아", "대만")) |> 
  select(1:2, 등급, 대표국적, 관객수)

