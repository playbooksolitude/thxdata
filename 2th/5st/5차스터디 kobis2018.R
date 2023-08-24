#23-0815 화 22:31

#
#scales()
#geom_tile() vs geom_point()
#``
#select(-c())
#getwd()
#set as working() 상대경로



#
library(tidyverse)
#install.packages("readxl")
library(readxl)    
library(showtext)
showtext_auto()


#1 불러오기
(read_excel("./2th/5st/excel/rawdata/KOBIS_2022.xlsx",
           skip = 4, ) -> kobis2022_1excel)

#2 구조파악
kobis2022_1excel |> glimpse()
kobis2022_1excel |> str()

(kobis2022_1excel |> 
  mutate(
    연도 = year(개봉일),
    월 = month(개봉일), 
    일 = day(개봉일), .before = 3) |> 
  select(-c(개봉일, 
            `매출액\n점유율`,국적)) -> kobis2022_2select)

#3 adult 유의미한 콘텐츠 구분
kobis2022_2select |> head(20)
kobis2022_2select |> tail(15)

  # 성인 제외 필요
kobis2022_2select |> 
  slice(3990:4000) |>
  select(1:9)

kobis2022_2select |> dim()   #4618편

  #관객수 1000명 이상인 것만! 
(kobis2022_2select |> 
  filter(관객수 > 1000) -> kobis2022_3under) #564


# ----------------------------------------------------------

kobis2022_3under |> 
  drop_na(월) |> 
  count(대표국적, 월, sort = T) |> 
  ggplot(aes(x= 대표국적, y = n)) +
  geom_bar(stat = "identity") +
  facet_wrap(.~월, scales = "free") +
  coord_flip()

#
colSums(is.na(kobis2022_2select)) |> knitr::kable()
colSums(is.na(kobis2022_2select)) |> data.frame()
is.na(kobis2022_2select) |> colSums() |> knitr::kable()


# 월별, 개봉작, 대표국적, geom_tile()
kobis2022_3under |> 
  filter(연도 == "2022") |> 
  drop_na(월) |> 
  count(대표국적, 월, sort = T) |> 
  ggplot(aes(x= 대표국적, y = 월, fill = n)) +
  geom_tile() +
  geom_text(aes(label = n)) +
  scale_fill_gradient(low = "grey", high = "red") +
  scale_y_continuous(breaks = c(1:12)) +
  theme(axis.title = element_blank(),
        panel.background = element_blank()) +
  coord_flip()


#
kobis2022_3under |> 
  drop_na(월) |> 
  group_by(월, 대표국적) |> 
  summarise(관객수합계 = sum(관객수)) |> 
  ggplot(aes(x = factor(월), y = 대표국적, 
    fill = 관객수합계)) +
  geom_tile() +
  geom_text(aes(label = round(관객수합계/10000,1)), color = "white") +
  labs(x = "월") +
  scale_fill_gradient(low = "grey", high = "red") +
  labs(subtitle = "단위: 만 명",
    title = "2022년 극장관객수") +
  theme(legend.position = "none")


#
kobis2022_3under |> 
  drop_na(월) |>
  filter(월 == "1")

# drop_na()
kobis2022_3under |> 
  drop_na(월) 

kobis2022_3under |> filter(
  is.na(월)) |> select(1:5, 관객수)


kobis2022_3under |> 
  drop_na(월) |> print(n = 30)

#월별 극장관객수
library(scales)
(kobis2022_3under |> 
  drop_na(월) |> 
  filter(연도 == "2022") |> 
  group_by(월) |> 
  summarise(관객수합계 = 
              sum(관객수)) -> kobis2022_4월별관객수)

#월별 관객수
library(bbplot)
kobis2022_4월별관객수 |> 
  ggplot(aes(x = as.factor(월) |> fct_reorder((월)), 
             y = 관객수합계/1000000)) + 
  geom_bar(stat = "identity") +
  labs(x = "월", y = "월별 누적 관객수") +
  geom_label(aes(label = round(관객수합계/1000000,1)), size = 7) +
  scale_y_continuous(breaks = c(5,10,15,20)) +
  labs(title = "2022년 월별 극장관객수", 
       subtitle = "단위: 백만 명
       ") +
  #bbc_style()
  theme(panel.background = element_blank(),
        plot.title = element_text(size = 28), 
        plot.subtitle = element_text(size = 22), 
        panel.grid.major.y = element_line(color = "grey"),
        axis.text = element_text(size = 18),
        axis.title = element_blank(),
        axis.ticks = element_blank())
bbc_style
geom_point

#check
library(gt)
kobis2022_3under |> 
  drop_na(월) |> 
  filter(연도 == "2022")

kobis2022_3under |> filter(월 == "2")  |> 
  select(1:5, 관객수, 장르) |> print(n = 30) |> gt()

kobis2022_3under |> filter(월 == "4")  |> 
  select(1:5, 관객수) |> print(n = 30) |> gt()

kobis2022_3under |> filter(월 == "5")  |> 
  select(1:5, 관객수) |> print(n = 30) |> gt()

kobis2022_3under |> filter(월 == "6")  |> 
  select(1:5, 관객수) |> print(n = 30) |> gt()



#------------------------------

library(gt)
kobis2022_3under |> 
  filter(연도 == "2022") |> 
  drop_na(월) |> 
  count(대표국적, 월) |> 
  arrange(월) |> 
  pivot_wider(
    names_from = 월,
    values_from = n
  ) |> gt()


#  매출액 Top 20
library(treemapify)
kobis2022_3under |> filter(순위 < 21) |> 
  ggplot(aes(area = 매출액, 
             fill = 대표국적, 
             label = 영화명,
             subgroup = 대표국적,
             subgroup2 = 
               paste(round(관객수/10000,0),"만명"))) +
  geom_treemap() +
  geom_treemap_text(color = "black", alpha = .7) +
  geom_treemap_subgroup_text(place = "centre",
                             grow = T,
                             min.size = 0,
                             alpha = .2,
                             fontface = "italic") +
  theme(legend.position = "none") +
  geom_treemap_subgroup2_text(color = "white", size = 12,
                              place = "center")


#매출액 표
kobis2022_3under |> filter(순위 < 21) |> 
  group_by(대표국적) |> 
  summarise(sum = sum(매출액)) |> 
  mutate(
    매출액합계 = sum(sum),
    비율 = round(sum / 매출액합계,3) * 100)


#  관객수 히트맵
kobis2022_3under |> filter(순위 < 51) |> 
  ggplot(aes(area = 관객수, 
             fill = 대표국적, 
             label = 영화명,
             subgroup = 대표국적,
             subgroup2 = 
               paste(round(관객수/10000,0), "만명"))) +
  geom_treemap(alpha = .5) +
  geom_treemap_text(color = "black", alpha = .7) +
  geom_treemap_subgroup_text(place = "centre",
                             grow = T,
                             min.size = 0,
                             alpha = .2,
                             fontface = "italic") +
  theme(legend.position = "none") +
  geom_treemap_subgroup2_text(color = "white",size = 12,
                              place = "center") +
  scale_fill_manual(values =  
                       c("한국" = "blue", 
                         "미국" = "red"))

# 관객수 표
kobis2022_3under |> filter(순위 < 51) |> 
  group_by(대표국적) |> 
  summarise(sum = sum(관객수)) |> mutate(
    관객수합계 = sum(sum),
    비율 = round(sum / 관객수합계,3) * 100)


# #coord_polar
# kobis2022_3under |> filter(순위 < 21) |> 
#   group_by(대표국적) |> 
#   summarise(sum = sum(관객수)) |> mutate(
#     관객수합계 = sum(sum),
#     비율 = round(sum / 관객수합계,3) * 100) |> 
#   ggplot(aes(y = 대표국적, fill = factor(비율))) + 
#   geom_bar(stat = "count", width = 1) +
#   coord_polar(theta = "y") 
  

 