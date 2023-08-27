#23-0824 thu 14:43

#
library(tidyverse)

#1. 데이터셋 사이즈 starwars 구조를 확인하시오
starwars |> glimpse()
starwars |> str()


# starwars 데이터셋은 몇행 몇열인가?
starwars |> dim() #87 * 14

  # 참고
starwars |> drop_na() |> dim()  #29 * 14


#1-2 geom_point(산점도)를 그리시오
ggplot(starwars, aes(x = gender, y = birth_year)) +
  geom_point()


#1-3 geom_boxplot()을 그리시오
starwars |> 
  ggplot(aes(x = gender, y = birth_year)) +
  geom_boxplot()


#1-4 species(종족), gender (성별) 조합을 확인하시오
starwars |> 
  count(species, gender, sort = T) #|> dim() #42 * 3


#1-5 species(종족), gender (성별), sex(생물학적 성별)을 확인하시오
starwars |> 
  count(species, sex, gender, sort = T)# |> dim() #41 * 3


#1-6 (1-4의 결과를 활용해) 히트맵을 그리시오
starwars |> count(species, gender) |> 
  ggplot(aes(x = gender, y = species, fill = n)) +
  geom_tile() +
  scale_fill_gradient(low = "grey", high = "red") +
  geom_text(aes(label = n))


#1-7 starwars$gender 에서 NA는 몇개나 있는지 확인하시오
starwars$gender |> table(useNA = "always")

# 몇개의 인수가 있는지 확인하기
# useNA 중요
# "ifany" 와 "always" 용법 차이
starwars$gender |> table(useNA = "always")
mpg$manufacturer |> table(useNA = "always")
mpg$manufacturer |> table(useNA = "ifany")


#1-8 starwars 에서 NA는 얼마나 있는지 확인하시오 (번외)
colSums(is.na(starwars)) |> 
  as.data.frame()

  # 지원님 참고 (이렇게 보면 예뻐요)
colSums(is.na(starwars)) |> 
  as.data.frame() |> 
  rownames_to_column(var = "name") |> 
  rename("NA" = 2) |> 
  pivot_wider(names_from = "name", 
              values_from = "NA") |> view()

#1-9 starwars의 세로줄(컬럼)만 출력하시오
starwars |> colnames()


# --------------------------------------------------------
library(scales)
library(bbplot)
library(showtext)
showtext_auto()

#2-1 2019년 극장관객수 xlsx 파일을 불러오시오
library(readxl)
# 극장관객수
(read_excel("./2th/5st/excel/rawdata/KOBIS_2019.xlsx", 
  skip = 4) -> kobis2019_1excel)


#2-2 데이터 구조를 파악하시오
kobis2019_1excel |> glimpse()
kobis2019_1excel |> str()


#2-3 세로줄 "개봉일"을 "연도", "월", "일"로 나누시오
(kobis2019_1excel |> 
  mutate(
    연도 = year(개봉일),
    월 = month(개봉일),
    일 = day(개봉일), .before = 3) -> kobis2019_2date)


#2-4 세로줄 "월"에 값이 없는 것들을 제거하고 몇행으로 줄어드는지 확인하시오 (번외)
kobis2019_2date |> 
  drop_na(월)


#2-5 2019년 월별 극장 관객수를 구하시오
kobis2019_2date |> 
  drop_na(월) |> 
  group_by(월) |> 
  summarise(월별관객수 = sum(관객수))
  

#2-6 (2-5 결과를 활용해) 막대 그래프로 그리시오
kobis2019_2date |> 
  drop_na(월) |> 
  group_by(월) |> 
  summarise(월별관객수 = sum(관객수)) |> 
  ggplot(aes(x = factor(월), y = 월별관객수/10000)) +
  geom_bar(stat = "identity") +
  scale_y_continuous(labels = comma) +
  geom_label(aes(label = comma(월별관객수/10000)), size = 5) +
  labs(subtitle = "단위: 만 명", 
  title = "2019년 월별 극장관객수")


### 2-7 (2-6 결과를 바탕으로) 그래프 심미성을 높이시오 (번외)
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



### 2-8 bbc_style을 theme을 활용해 구현하시오 (번외)
kobis2019_2date |> 
  drop_na(월) |> 
  group_by(월) |> 
  summarise(월별관객수 = sum(관객수)) |> 
  ggplot(aes(x = factor(월), y = 월별관객수/10000)) +
  geom_bar(stat = "identity") +
  scale_y_continuous(labels = comma) +
  geom_label(aes(label = comma(월별관객수/10000)), size = 5) +
  labs(subtitle = "단위: 만 명", 
       title = "2019년 월별 극장관객수") +
theme(panel.background = element_blank(),
      plot.title = element_text(size = 28), 
      plot.subtitle = element_text(size = 22), 
      panel.grid.major.y = element_line(color = "grey"),
      axis.text = element_text(size = 18),
      axis.title = element_blank(),
      axis.ticks = element_blank())


# 2-9 2019년 관객수 총합은 얼마인지 구하시오
(kobis2019_2date |> 
    drop_na(월) |> 
    summarise(누적관객수 = sum(관객수))) #226,172,268



# --------------------------------------------------------
# 2020년도 극장관객수를 불러오시오
(read_excel("./2th/5st/excel/rawdata/KOBIS_2020.xlsx", 
  skip = 4) -> kobis2020_1excel)


#3-1 (2-3부터 2-6까지 코드를 활용해) 2020년도 데이터를 분석하시오
kobis2020_1excel |> 
  mutate(
    연도 = year(개봉일),
    월 = month(개봉일),
    일 = day(개봉일), .before = 3) -> kobis2020_2date


#
kobis2020_2date |> 
  drop_na(월) |> 
  summarise(누적관객수 = sum(관객수)) #59312643


# 3-2 그래프 심미성을 높이시오
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


#
#
(kobis2019_2date |> 
  drop_na(월) |> 
  summarise(누적관객수 = sum(관객수))) #226,172,268


#4 -----------------
### 4-1 kobis2019_2date 데이터셋에 개봉연도 2019년을 추가하시오
#
kobis2019_2date |> 
  mutate(개봉연도 = "2019", .before = 3) -> kobis2019_3year
  

### 4-2 kobis2020_2date 데이터셋에 개봉연도 2020년을 추가하시오
kobis2020_2date |> 
  mutate(개봉연도 = "2020", .before = 3) -> kobis2020_3year


### 4-3 kobis2020_3year 데이터셋과 kobis2019_3year을 하나로 합치시오
full_join(kobis2019_3year, 
  kobis2020_3year) -> kobis_3join


### 4-4 2019년과 2020년 극장관객수를 비교하시오
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
  labs(title = "Covid-19 전/후 극장관객수 비교", 
    subtitle = "단위: 만 명")



### 4-5 (4-4 그래프의) 심미성을 높이시오
kobis_3join |> 
  drop_na(월) |> 
  group_by(개봉연도, 월) |> 
  summarise(월별관객수 = sum(관객수)) |> 
  ggplot(aes(x = factor(월), 
             y = 월별관객수/10000, fill = 개봉연도)) +
  geom_bar(stat = "identity", position = "dodge") +
  scale_y_continuous(labels = comma) +
  labs(title = "Covid-19 전/후 극장관객수 비교", 
       subtitle = "단위: 만 명") +
  bbc_style()

nord::nord_palettes  

### 4-6 (4-5 그래프의) 심미성을 높이시오
kobis_3join |> 
  drop_na(월) |> 
  group_by(개봉연도, 월) |> 
  summarise(월별관객수 = sum(관객수)) |> 
  ggplot(aes(x = factor(월), 
             y = 월별관객수/10000, fill = 개봉연도)) +
  geom_bar(stat = "identity", position = "dodge") +
  scale_y_continuous(labels = comma) +
  labs(title = "Covid-19 전/후 극장관객수 비교", 
       subtitle = "단위: 만 명") +
  bbc_style() +
  scale_fill_nord("afternoon_prarie")

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


### ------------------------------- 나중에 할께요


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

