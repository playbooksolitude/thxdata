#23-0806 sun 13:53

#
#1 월요일 21:00~21:20 공부
#2 튜토리얼
#3 Q&A
#휴식
#4 마부뉴스
#5 레이더 그래프

#
#6 대통령
#7 심슨의 역설
#8 과제
  # 목표
#9 그래프
  #boxplot
  #cheatsheet

#
install.packages("nycflights13")
library(nycflights13)


#
starwars
starwars |> view()
view(starwars)


#starwars 그래프 그리기
#1 view() 데이터 조망
#2 sex 
table(starwars$sex)
table(starwars$sex)
16+1+60+6

starwars
table(starwars$sex, useNA = "always")
table(starwars$gender, useNA = "always")

starwars |> ggplot(aes(x = gender)) +
  geom_bar()

starwars |> 
  ggplot(aes(x = gender)) +
  geom_bar() +
  geom_label(aes(
    label = stat(count)), 
    stat = "count",
    size = 5)

starwars |> 
  ggplot(aes(x = gender)) +
  geom_bar() +
  geom_label(aes(
    label = stat(count)), 
    stat = "count",
    size = 3) +
  facet_wrap(.~sex)

starwars


#
mpg

# 컬럼 합치기
mpg |> 
  mutate(new_model = paste(manufacturer, model), 
  .before = 1)

#
table(mpg$drv)
"4" = "4륜구동"
"f" = "전륜구동"
"r" = "후륜구동"

#
mpg |> 
  mutate(drv_new = 
      if_else(drv == "4", "4륜구동",
        if_else(drv == "f", "전륜구동", "r")), 
    .before = 1) |> 
  ggplot(aes(x = drv_new, y = stat(count))) +
  geom_bar()


#주영님
df <- tibble(x= C(1, NA, 3)) #대문자
df <- tibble(x= c(1, NA, 3)) #소문자


#
library(nycflights13)
flights |> count(origin)
flights |> count(dest)


# 인천공항
dep_22_12
dep_22_12 |> view()
dep_22_12 |> count(도착공항명, sort = T)

dep_22_12 |> ggplot(aes(x = 구분)) +
  geom_bar(aes(fill = 현황)) +
  geom_label(aes(label = stat(count)), 
    stat = "count") +
  facet_wrap(.~현황, scales = "free")

