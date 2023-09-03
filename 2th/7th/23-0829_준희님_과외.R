#23-0829 tue 20:15

#
library(tidyverse)
# 
# ── Conflicts ────────────────────────────────────────────── tidyverse_conflicts() ──
# ✖ dplyr::filter() masks stats::filter()
# ✖ dplyr::lag()    masks stats::lag()
# ℹ Use the conflicted package to force all conflicts to become errors

#패키지 는 유니크
#함수는 동명


# 
#숫자 = 산술연산 
1,2,3 
4395 * 2485 -> d
d

#2 문자 != 산술연산
영어, 한글
c("1", "2", "3") -> b
"1" * "2"
일곱하기이

c(1,2,10)

#3 변수 (한글, 영어)
a <- c(1,2,3)

어떤 값을 넣어놓는 그릇
숫자는 변수가 될수 없다


#4 특수문자
<-, =, ==, ""

#
onetwothree <- 변수
일이삼 <- c(1,2,3)

#
일이삼

#
ggplot(data = mpg, 
       mapping = aes(x = manufacturer, 
                     y = cty)) +
  geom_point()


# 그래프를 그리겠다 ggplot()
# 사용할 데이터는          data = 
# 가로축과 세로축에는 무엇을 놓겠다 aes(x =변수, y =변수)
# 어떤 그래프로 그려라 + geom_point(), geom_bar()

# geom_point 그래프 색깔 color, stat = "count" or "identity"
ggplot(data = mpg, 
       mapping = aes(x = displ, 
                     y = hwy, 
                     color = drv)) + #color
  geom_point()                       #stat 생략


# geom_bar 그래프 색깔 fill
ggplot(data = mpg, 
       mapping = aes(x = displ, 
                     y = hwy, 
                     fill = drv)) + #fill
  geom_bar(stat = "identity")     #stat = "identity"


