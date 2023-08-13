#23-0811 thu 11

#
library(tidyverse)
library(bbplot)
library(showtext)
showtext_auto()
library(ggrepel)
library(patchwork)
install.packages("patchwork")

#
#23년 1월~6월 극장관객수 (기간별)

#
read_csv("./2th/4st/thxdata - KOBIS_23-01-06.csv", 
  skip = 4) -> kobis_1csv

#2
kobis_1csv$순위 |> as.numeric() -> kobis_1csv$순위
kobis_1csv |> glimpse()

kobis_1csv |> mutate(
  연도 = year(개봉일),
  월 = month(개봉일),
  일 = day(개봉일), .before = 3
) |> select(-c(`매출액\n점유율`, 개봉일)) -> kobis_2날짜
  

#
kobis_2날짜 |> drop_na(순위)
kobis_2날짜 |> filter(is.na(순위))
kobis_2날짜 |> tail()

# na check
colSums(is.na(kobis_2날짜)) |> as.data.frame()
kobis_2날짜 |> filter(is.na(연도))

#
kobis_2날짜 |> 
  drop_na(연도, 월, 일) |> 
  filter(순위 < 101) -> kobis_3top100


#
kobis_3top100 |> filter(순위 < 101) |> 
  ggplot(aes(x = 순위, y = 대표국적, fill = 관객수)) +
  geom_tile() +
  scale_fill_gradient(low = "grey", high = "red")

# 시청등급
table(kobis_2날짜$등급)
table(kobis_2날짜$등급) |> data.frame()

kobis_3top100 |> view()

#관객수
kobis_3top100 |> 
  mutate(
    스크린ROI = round(관객수 / 스크린수,0),
    상영횟수ROI = round(관객수 / 상영횟수,0),
  ) |> select(
    순위, 
    영화명, 대표국적,
    연도, 월, 일,
    매출액, 누적매출액, 관객수, 누적관객수,
    스크린수, 상영횟수, 스크린ROI, 상영횟수ROI
  ) -> kobis_4ROI

kobis_4ROI |> gt::gt()


#
kobis_4ROI |> ggplot(aes(x = 스크린ROI, 
                         y = 상영횟수ROI)) +
  geom_point()

#
kobis_4ROI |> filter(스크린ROI > 2000)

kobis_4ROI |> ggplot(aes(x = 스크린ROI, 
                         y = 상영횟수ROI)) +
  geom_point(color = 
               if_else(kobis_4ROI$대표국적 == "한국", "red", "grey")) +
  geom_text_repel(data = kobis_4ROI |> 
              filter(스크린ROI > 2000 | 상영횟수ROI > 30), 
            aes(label = 영화명, 
                y = 상영횟수ROI,
                x = 스크린ROI), 
            stat = "identity") +
  geom_rect(aes(xmin = 0, xmax = 2000,
                ymin = 20, ymax = 30), alpha = .005, fill = "yellow") +
  geom_rect(aes(xmin = 0, xmax = 1050,
                ymin = 30, ymax = 55), alpha = .005, fill = "blue") +
  geom_rect(aes(xmin = 0, xmax = 2000,
                ymin = 0, ymax = 20), alpha = .005, fill = "black") +
  geom_rect(aes(xmin = 2000, xmax = 5000,
                ymin = 20, ymax = 40), alpha = .005, fill = "red")

#
kobis_4ROI |> filter(상영횟수ROI > 30) |> 
  view()

#
library(scales)
kobis_4ROI |> 
  ggplot(aes(x = 관객수, y = 매출액)) +
  geom_point() +
  scale_y_continuous(labels = comma) +
  scale_x_continuous(labels = comma) +
  geom_smooth(method = "lm") +
  geom_text(data = kobis_4ROI |> filter(관객수 > 3000000, 
                                        관객수 < 4000000),
            aes(label = 영화명))

#
# 스크린수 vs 관객수
kobis_4ROI |> 
    ggplot(aes(x = 상영횟수, y = 관객수)) +
    geom_smooth() +
    geom_point() +
    geom_text_repel(data = kobis_4ROI |> filter(스크린수 > 1500 |
                                                  관객수 > 1700000), 
                    aes(label = paste(영화명, comma(상영횟수)))) +
    scale_y_continuous(labels = comma)


# 스크린수 vs 관객수
(kobis_4ROI |> 
  ggplot(aes(x = 스크린수, y = 관객수)) +
  geom_smooth() +
  geom_point() +
  geom_text_repel(data = kobis_4ROI |> filter(스크린수 > 1500 |
                                                관객수 > 1700000), 
            aes(label = paste(영화명, comma(상영횟수)))) +
  scale_y_continuous(labels = comma) -> kobis_5smooth)

# 스크린수 vs 관객수 선형회귀
(kobis_4ROI |> 
  ggplot(aes(x = 스크린수, y = 관객수)) +
  geom_smooth(method = "lm") +
  geom_point() +
  geom_text_repel(data = kobis_4ROI |> filter(스크린수 > 1500 |
                                                관객수 > 1700000), 
                  aes(label = paste(영화명, comma(상영횟수)))) +
  scale_y_continuous(labels = comma) -> kobis_5lm)

kobis_5lm / kobis_5smooth


# 스크린수 vs 상영횟수
kobis_4ROI |> 
  ggplot(aes(x = 스크린수, y = 상영횟수)) +
  geom_smooth() +
  geom_point() +
  geom_text_repel(data = kobis_4ROI |> filter(스크린수 > 1500 |
                                                관객수 > 1700000), 
                  aes(label = paste(영화명, "(관객수)", comma(관객수)))) +
  scale_y_continuous(labels = comma)

?paste0
(nth <- paste0(1:12, c("st", "nd", "rd", rep("th", 9))))
paste(month.abb, "is the", nth, "month of the year.")


#
kobis_2날짜 |> 
  filter(순위 < 31, 연도 == "2023") |> 
  ggplot(aes(x = 순위, y = as.factor(월), fill = 누적관객수)) +
  geom_tile() +
  geom_text(aes(label = round(누적관객수/10000,0)), color = "white")

#




#
kobis_2날짜 |> filter(순위 < 21) |> 
  ggplot(aes(x = 영화명 |> fct_reorder(desc(순위)), 
    y = 매출액)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  labs(y = "순위", x = "영화명")















