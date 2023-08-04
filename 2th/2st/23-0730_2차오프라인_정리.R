#23-0730 sun 14:00 2회차 오프라인

#1 라이브러리 로드

library(tidyverse)
# tidyverse() 로드 후 나오는 Conflicts message
# ── Conflicts ─────────────────────────────────────────────────── tidyverse_conflicts() ──
# ✖ scales::col_factor() masks readr::col_factor()
# ✖ scales::discard()    masks purrr::discard()
# ✖ dplyr::filter()      masks stats::filter()
# ✖ dplyr::lag()         masks stats::lag()
# ℹ Use the conflicted package to force all conflicts to become errors

#1-1 패키지는 unique, 패키지 내 필터는 unique 하지 않음
#서로 다른 패키지 내에 같은 이름의 필터가 있다고 알려줌
  #예시
  #scales::col_factor() vs readr::col_factor() 

  #scales::col_factor()를 사용하고 싶은 경우
scales::col_factor()

  #readr::col_factor()을 사용하고 싶은 경우
readr::col_factor()


#2 
# 가독성을 높이는 코딩 스타일
# 자기 스타일에 맞춰 작성
  #일반
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, 
                           y = hwy), 
             color = "blue")


  #줄바꿈 후 콤마를 찍는 스타일 (콤마 확인 쉬움)
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ
    , y = hwy)
    , color = "blue")


#3  stat = "identity", scale = "free"
mpg |> count(manufacturer,drv) |> 
  ggplot(aes(x = manufacturer,
    y = n)) +
  geom_bar(stat = "identity", aes(fill=drv)) +
  facet_wrap(.~drv, scale = "free") +
  coord_flip()

#3-1 eoqnqns enf wnddp gksk
  #stat = "identity" or stat = "count"


# 오버플롯팅 #값이 중복될 경우
  #중복되는 사례
ggplot(data=mpg)+
  geom_point(mapping=aes(x=class, y=drv))

  #1 방법 alpha 값 적용
ggplot(data=mpg)+
  geom_point(mapping=aes(x=class, y=drv), 
             alpha = .1)

  #2 방법 geom_jitter
ggplot(data=mpg)+
  geom_jitter(mapping=aes(x=class, y=drv), 
    width = .1)

  #3 방법 geom_count
ggplot(data=mpg)+
  geom_count((mapping=aes(x=class, y=drv)))


#4 선형회귀선
ggplot(data=mpg)+  
  geom_point(mapping=aes(x=displ, y=hwy))+  
  geom_smooth(mapping=aes(x=displ,y=hwy), 
    se = F, method = 'lm')

#4-1 비선형회귀선
ggplot(data=mpg)+  
  geom_point(mapping=aes(x=displ, y=hwy))+  
  geom_smooth(mapping=aes(x=displ,y=hwy))


#5 ggplot 에서는 데이터만 선언 (mpg)
ggplot(data=mpg)+  
  geom_point(mapping=aes(x=displ, y=hwy))+  
  geom_smooth(mapping=aes(x=displ,y=hwy))


  #5-1 ggplot에서 aes(x, y) 모두 선언
ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth()


#6 데이터 구조
mpg
str(mpg)
str(mpg)
glimpse(mpg)
summary(mpg) #기술통계


#7 안되는 오류 실행하면서 디버깅한 메모
# 면분할
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap(~ class, nrow = 2)


# 회귀
ggplot(data=mpg, 
  mapping=aes(x=displ, y=hwy, color=drv)) + 
  geom_point(show.legend = F) + 
  geom_smooth(se=F, show.legend = F)


# geom_text
mpg |>
  count(manufacturer, drv, name = "n") |>
  group_by(manufacturer) |>
  mutate(total_n = sum(n)) |>
  ggplot(aes(x = manufacturer, y = n, fill = drv)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label = n), 
    position = position_stack(vjust = 0.5), size = 3) +
  geom_text(aes(label = total_n, y = total_n + 2), 
    vjust = -0.5, size = 3) +
  ylim(0,40)


#8 함수의 인수를 보여주는 함수
args(geom_bar)


#9 정렬
mpg |> 
  count(manufacturer, sort = T) |> 
  ggplot() +
  geom_bar(aes(x = manufacturer |> 
      fct_reorder(n), 
    y = n), 
    stat = "identity")

#정렬 내림 차순
mpg |> 
  count(manufacturer, sort = T) |> 
  ggplot() +
  geom_bar(aes(x = manufacturer |> 
      fct_reorder(desc(n)), 
    y = n), 
    stat = "identity")

#10 정렬 + 축변환
mpg
mpg |> count(manufacturer) |> 
  ggplot() + 
  geom_bar(aes(x = manufacturer |> 
      fct_reorder(desc(n)), 
    y = n), stat = "identity") +
  labs(x = "manu", y = "nnnn") +
  coord_flip()

