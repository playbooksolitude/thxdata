여기다가 코드 작성 

library(tidyverse)

#1 Conflicts
base::Filter()
dplyr::filter()

#2 내장된 데이타셋 보는 법 data()
data()

#3 스타워즈 데이터셋 #tidyverse에 포함
starwars

#4 mpg
mpg

#5-0 파이프 단축키 
cmd + shift + m

#5 view() 데이터 훓어보기
mpg |> view()
mpg |> view()
view(mpg)

#6 count 질문 mpg 에 manufacturer 총 몇개인지?
mpg |> count(manufacturer)

#7 count 많은 순서대로 정렬
mpg |> count(manufacturer, sort = T)
mpg

#8 피벗테이블 제조사, class
mpg |> count(class)
mpg |> count(manufacturer, class)
mpg |> count(drv)

#9 ggplot (그래프, 시각화)
#제조사별로 몇개의 데이타가 있는지?
mpg |> 
  count(manufacturer) |> 
  ggplot(aes(x = manufacturer,y = n)) +
  geom_bar(stat = "identity")

#10 
mpg
mpg |> 
  #count(manufacturer) |> 
  ggplot(aes(x = manufacturer)) +
  geom_bar(stat = "count")

# #
# diamonds |> 
#   ggplot(aes(x = cut)) +
#   geom_bar(stat = "count")
# 
# diamonds |> count(cut) |> 
#   ggplot(aes(x = cut, y = n)) +
#   geom_bar(stat = "identity")

#11 facet class
mpg |> 
  ggplot(aes(x = manufacturer)) +
  geom_bar(stat = "count") +
  facet_wrap(.~drv, nrow = 1) +
  coord_flip()

#12 class
mpg |> 
  ggplot(aes(x = manufacturer)) +
  geom_bar(stat = "count", aes(fill = trans)) +
  facet_wrap(.~class, nrow = 2, scales = "free") +
  coord_flip()

#13 옵션
args(geom_bar)

#14 히트맵
mpg |> count(manufacturer, class) |> 
  ggplot(aes(x = manufacturer, y = class)) +
  geom_tile(aes(fill = n)) +
  geom_text(aes(label = n), color = "white")

#14-1 다이아몬드 히트맵
diamonds |> count(color, cut) |> 
  ggplot(aes(x = color, y = cut)) +
  geom_tile(aes(fill = n))  +
  geom_text(aes(label = n), color = "white")
