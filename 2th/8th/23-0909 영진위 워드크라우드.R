#23-0909


#
library(tidyverse)
library(wordcloud)

#1 불러오기 ------------------------------------------------
#1-1 Import Dataset
#https://www.kobis.or.kr/kobis/business/stat/boxs/findPeriodBoxOfficeList.do

#1-2
read_csv("./2th/4th/thxdata - KOBIS_23-01-06.csv",
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



#워드크라우드 ---------------------------------------------
#
kobis_2날짜  |> 
  group_by(영화명) |> 
  summarise(sum = sum(관객수)) -> kobis_word


kobis_word |> 
  separate(영화명,  into = c("영화명", "부제"), 
           sep = ":") -> kobis_word2


kobis_word2 |> 
  with(wordcloud(words = 영화명, #제목
            freq = sum,          #글자크기
            min.freq = 100000,   #최소 노출
            max.words = 15,      #노출할 글자수 제한
            scale = c(4,1),    #스케일
            random.order = F,    #한가운데 1등
            random.color = T,    #컬러 랜덤 (중요)
            colors = brewer.pal(8, "Dark2"))) 

#
library(nord)
wordcloud(words = kobis_word2$영화명,
          freq = kobis_word2$sum,
          min.freq = 100000,
          scale = c(4,1),
          max.words = Inf,
          random.order = F,
          random.color = T,
          rot.per = .1,
          colors = nord(palette = "afternoon_prarie"))


#
wordcloud::wordcloud(words = kobis_word2$영화명,
                     freq = kobis_word2$sum, 
                     scale = c(20,1),
                     min.freq = 10000,
                     max.words = 31,
                     colors = brewer.pal(5, "Dark2"),
                     random.order = F,
                     random.color = T,
                     rot.per = .2)

#
brewer.pal.info
wordcloud()
brewer.pal.info
