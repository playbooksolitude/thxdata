#23-0221 tues 20:34

#1 라이브러리
library(tidyverse)
library(patchwork)


#2 앤스컴
datasets::anscombe
anscombe |> glimpse()

#3 데이터셋
(tibble(
  x1 = anscombe$x,
  y1 = anscombe$y
) -> anscombe_x1)

tibble(
  x2 = anscombe$x1,
  y2 = anscombe$y1
)

tibble(
  x3 = anscombe$x3,
  y3 = anscombe$y3
) -> anscombe_x3

tibble(
  x4 = anscombe$x4,
  y4 = anscombe$y4
) -> anscombe_x4


#1번째 그래프
anscombe |> 
  ggplot(aes(x = x, y = y)) +
  geom_point(size = 5) +
  geom_smooth(method = "lm", se = F) +
  coord_cartesian(ylim = c(0,13)) -> test_00

#2번째 그래프
anscombe |> 
  ggplot(aes(x = x.1, y = y.1)) +
  geom_point(size = 5) +
  geom_smooth(method = "lm", se = F) +
  coord_cartesian(ylim = c(0,13)) -> test_01

#3번째 그래프
anscombe |> 
  ggplot(aes(x = x.2, y = y.2)) +
  geom_point(size = 5) +
  geom_smooth(method = "lm", se = FALSE) +
  coord_cartesian(ylim = c(0,13)) -> test_02


#4번째 그래프
anscombe |> 
  ggplot(aes(x = x.3, y = y.3)) +
  geom_point(size = 5) +
  geom_smooth(method = "lm", se = FALSE) +
  coord_cartesian(ylim = c(0,13)) -> test_03


library(patchwork)
test_00 | test_01
test_02 | test_03

#4개의 그래프를 한번에
(test_00 | test_01) / (test_02 | test_03)



#| 좌우  #test_00 | test_01 | 버티컬바
#/ 상하  #test_00 / test_01 / 슬래시


# 표준편차가 같아요
sd(anscombe$x);sd(anscombe$y)
sd(anscombe$x.1);sd(anscombe$y.1)

#평균
mean(anscombe$x);mean(anscombe$y)
mean(anscombe$x.1);mean(anscombe$y.1)

mean(anscombe$x);mean(anscombe$y)
mean(anscombe$x.1);mean(anscombe$y.1)

anscombe


#4 #표준편차
sd(anscombe_x1$x1);sd(anscombe_x1$y1)
sd(anscombe_x2$x2);sd(anscombe_x2$y2)


#5 #상관계수
cor.test(anscombe_x1$x1,anscombe_x1$y1)
cor.test(anscombe_x2$x2,anscombe_x2$y2)


#5-1상관계수
cor(anscombe_x1$x1,anscombe_x1$y1)
cor(anscombe_x2$x2,anscombe_x2$y2)


#5-2 #R-square
sqrt(cor(anscombe_x1$x1,anscombe_x1$y1))
sqrt(cor(anscombe_x2$x2,anscombe_x2$y2))



#6 그래프 #geom_point
anscombe_x1

anscombe_x1 |> 
  ggplot(aes(x = x1, y = y1)) + geom_point()

anscombe_x2 |> 
  ggplot(aes(x = x2, y = y2)) + geom_point()

anscombe_x3 |> 
  ggplot(aes(x = x3, y = y3)) + geom_point()

anscombe_x4 |> 
  ggplot(aes(x = x4, y = y4)) + geom_point()



#7 #geom_point + geom_smooth
anscombe_x1 |> 
  ggplot(aes(x = x1, y = y1)) + geom_point() + 
  geom_smooth(method = "lm", se = F)

anscombe_x2 |> 
  ggplot(aes(x = x2, y = y2)) + geom_point() + 
  geom_smooth(method = "lm", se = F)

anscombe_x3 |> 
  ggplot(aes(x = x3, y = y3)) + geom_point() + 
  geom_smooth(method = "lm", se = F)

anscombe_x4 |> 
  ggplot(aes(x = x4, y = y4)) + geom_point() + 
  geom_smooth(method = "lm", se = F)



#8 #patchwork + coord_cartesian
anscombe_x1 |> 
  ggplot(aes(x = x1, y = y1)) + geom_point() + 
  geom_smooth(method = "lm", se = F) +
  coord_cartesian(ylim = c(0,12)) |

anscombe_x2 |> 
  ggplot(aes(x = x2, y = y2)) + geom_point() + 
  geom_smooth(method = "lm", se = F) +
  coord_cartesian(ylim = c(0,12))
