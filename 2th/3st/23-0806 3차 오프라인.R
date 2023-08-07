#23-0806 sun 13:53

#
#1 월요일 21:00~21:20 공부 study with me
#2 튜토리얼
#3 Q&A
#휴식
#4 마부뉴스
#5 레이더 그래프
#추가 버티컬바 or 조건 기호는 '버티컬바'라고 부름
  # 키보드에서 '}' 옆에 있는 버튼을 shift 누르고 클릭

# 다음주
#6 미국 집권당에 따른 실업률
#7 심슨의 역설 (통계)
#8 과제
  # 데이터 공부 목표 작성하기
#9 그래프
  #boxplot     #설명할 것
  #cheatsheet  #공유

#1
#install.packages("nycflights13") #데이터 패키지 설치
library(nycflights13)             #데이터 로드


#2 nycflights13 혹은 mpg 데이터셋이 어려운 분들을 위해
# 스타워즈 데이터셋으로 연습
starwars
starwars |> view() #엑셀처럼 보기
view(starwars)     #엑셀처럼 보기


#3 starwars 그래프 그리기
starwars                  #87행 * 14열
table(starwars$sex)       #16 + 1 + 60 +6 == 83 #항상 체크하기


#3-1 table()함수 사용했을 때 83개만 나오는 이유는 NA 때문임

  #NA도 출력하는 옵션
table(starwars$sex, useNA = "always")    #NA 4
table(starwars$gender, useNA = "always") #NA 4

#4 막대그래프 그리기
starwars |> ggplot(aes(x = gender)) +
  geom_bar()

#5
starwars |> 
  ggplot(aes(x = gender)) +
  geom_bar() +
  geom_label(aes(
    label = after_stat(count)), #라벨은 세어라
    stat = "count",             #y값을 세어라
    size = 5)                   #label size


#5-1 면분할
starwars |> 
  ggplot(aes(x = gender)) +
  geom_bar() +
  geom_label(aes(
    label = stat(count)), 
    stat = "count",
    size = 3) +
  facet_wrap(.~sex)


#6 Q&A 지혜님 질문
# 컬럼과 컬럼을 합쳐서 새로운 컬럼 만드는 방법은?
  #paste를 사용한다

mpg |> 
  mutate(new_model = paste(manufacturer, model), 
  .before = 1) #new_model이라는 컬럼이 새로 생김
               #new_model은 manufacturer, model을 병합함


#7 값을 변경하는 방법은? 
  # 엑셀은 ctrl+F 로 찾아서 바꿔주지만 R에서는 어떻게 하는지?
  # 예시 
  table(mpg$drv)
  #drv의 "4"라는 값을 "4wd"으로 바꾸려면?

#예시
  # 4 -> 4wd
  # f -> fwd
  # r -> rwd
  
  
#7-1
mpg |> 
  mutate(drv_new = 
      if_else(drv == "4", "4wd",
        if_else(drv == "f", "fwd", "rwd")), 
    .before = 1) |> 
  ggplot(aes(x = drv_new, y = stat(count))) +
  geom_bar()
  

#7-1 주영님
(df <- tibble(x= C(1, NA, 3))) #오류가 나는 이유?
(df <- tibble(x= c(1, NA, 3))) #c를 소문자로 해야함


#8 데이터 랭글링
library(nycflights13)
flights |> count(origin)   #3개 공항
flights |> count(dest)


# 인천공항
library(readxl)
library(showtext)
showtext_auto()
dep_22_12 <- read_excel("2th/3st/dep_22_12.xlsx")

#노선
dep_22_12 |> ggplot(aes(x = 구분)) +
  geom_bar() +
  geom_label(aes(label = stat(count)), 
             stat = "count", size = 7)


#노선별 현황 (#여객 #화물)
dep_22_12 |> ggplot(aes(x = 구분)) +
  geom_bar(aes(fill = 현황)) +
  geom_label(aes(label = stat(count)), 
    stat = "count") +
  facet_wrap(.~현황, scales = "free") +
  theme(legend.position = "top")




