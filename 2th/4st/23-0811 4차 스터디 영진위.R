#23-0811 thu 11시

#
library(tidyverse)   #기본 실행
#install.packages("gt") #다운로드 받아야할 경우 #제거 후 실행
library(gt)
library(showtext)    #한글
showtext_auto()      #한글 실행
#install.packages("ggrepel")
library(ggrepel)     #글자가 겹치지 않도록 하는 함수 
#install.packages("patchwork")   
library(patchwork)   #그래프를 나란히 2개 보여주는 함수
library(treemapify)


#
#23년 1월~6월 극장관객수 (기간별)

#1 불러오기 ------------------------------------------------
#1-1 Import Dataset
#https://www.kobis.or.kr/kobis/business/stat/boxs/findPeriodBoxOfficeList.do

#1-2
read_csv("./2th/4st/thxdata - KOBIS_23-01-06.csv",
         skip = 4) -> kobis_1csv

getwd() #파일의 기본 위치
read_csv("../")  #상위폴더
read_csv("./")   #현재폴더 

#1-3 데이터 셋 사이즈 구하는 방법
kobis_1csv |> dim()    #dim()
kobis_1csv |> glimpse()
kobis_1csv |> str()
kobis_1csv

#1-4  문자형 -> 연속형 어떻게 바꾸나? --------------- 중요
kobis_1csv$순위       #컬럼만 보는 법
kobis_1csv$순위 |> as.numeric() -> kobis_1csv$순위
kobis_1csv |> glimpse()

#변수를 계속 만들어갑니다
kobis_1csv


#2 #연도, 월, 일 나누기 #컬럼 제거 -------------------------
(kobis_1csv |> 
  mutate(
    연도 = year(개봉일), 
    월 = month(개봉일),
    일 = day(개봉일), .before = 3) |> 
  select(-c(`매출액\n점유율`, 개봉일)) -> kobis_2날짜)

kobis_1csv |> dim()


#drop_na()
kobis_2날짜 |> tail()
kobis_2날짜 |> head()

kobis_2날짜    #2073 * 19
kobis_2날짜 |> drop_na(순위) #2072 * 19
#
kobis_2날짜 |> filter(is.na(순위))
kobis_2날짜 |> tail()

# 전체적으로 NA 체크
colSums(is.na(kobis_2날짜)) |> data.frame()

# na check
colSums(is.na(kobis_2날짜)) |> as.data.frame()
kobis_2날짜 |> filter(is.na(연도))


#
kobis_2날짜 |> 
  drop_na(연도, 월, 일) |> 
  filter(순위 < 101)


#3 top 100 -------------------------------------------------
kobis_2날짜 |> 
  drop_na(연도, 월, 일) |> 
  filter(순위 < 101) -> kobis_3top100


#4 ROI 계산
#관객수
(kobis_3top100 |> 
  mutate(
    스크린ROI = round(관객수 / 스크린수,0),
    상영횟수ROI = round(관객수 / 상영횟수,0),
  ) |> select(
    순위, 
    영화명, 대표국적,
    연도, 월, 일,
    매출액, 누적매출액, 관객수, 누적관객수,
    스크린수, 상영횟수, 스크린ROI, 상영횟수ROI
  ) -> kobis_4ROI)


#4 표그리기 ------------------------------------------------
#install.packages("gt")
kobis_4ROI |> gt::gt()
kobis_4ROI |> gt()


#5 그래프 --------------------------------------------------
kobis_4ROI |> 
  ggplot(aes(x = 스크린ROI, 
             y = 상영횟수ROI)) +
  geom_point()

#check
kobis_4ROI |> filter(스크린ROI > 2000)


#6 그래프 segment
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
kobis_4ROI |> filter(상영횟수ROI > 30) |> view()


# 7 아바타
library(scales)
kobis_4ROI |> 
  ggplot(aes(x = 관객수, y = 매출액)) +
  geom_point() +
  geom_smooth(method = "lm") +
  geom_text_repel(data = kobis_4ROI |> filter(관객수 > 3000000,
                                        관객수 < 4000000),
            aes(label = 영화명)) +
  scale_y_continuous(labels = comma) +
  scale_x_continuous(labels = comma)
  

# 스크린수 vs 관객수 paste
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
(read_csv("./2th/4st/thxdata - KOBIS_SLAMDUNK.csv",
         skip = 3) -> slam_1csv)

#
slam_1csv |> 
  ggplot(aes(x = 날짜, y = 관객수)) +
  geom_point()

#
slam_1csv |> 
  ggplot(aes(x = 날짜, y = 관객수)) +
  geom_point() +
  geom_line(group = 1)


#
slam_1csv |> 
  ggplot(aes(x = 관객수)) +
  geom_density(adjust = 1)

slam_1csv |> 
  transmute(sum(관객수))

#
kobis_2날짜
kobis_4ROI |> count(대표국적)

kobis_2날짜 |> count(대표국적) |> count(wt = n)
kobis_2날짜 |> count(대표국적, sort = T) |> 
  ggplot(aes(x= 대표국적, y = n)) +
  geom_bar(stat = "identity")

#
