#23-0221 tues 20:34

#1 라이브러리
library(tidyverse)
library(patchwork)


#2 앤스컴
datasets::anscombe

#3 데이터셋
tibble(
  x1 = anscombe$x1,
  y1 = anscombe$y1
) -> anscombe_x1

tibble(
  x2 = anscombe$x2,
  y2 = anscombe$y2
) -> anscombe_x2

tibble(
  x3 = anscombe$x3,
  y3 = anscombe$y3
) -> anscombe_x3

tibble(
  x4 = anscombe$x4,
  y4 = anscombe$y4
) -> anscombe_x4


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
