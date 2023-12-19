#23-0227 mon office 11:50

#
library(tidyverse)
library(bbplot)
library(patchwork)
library(gt)

data()


# 1 데이터 조회 ----
anscombe |> gt()

# 2 데이터 나눠 담기 ----
(tibble(
  x1 = anscombe$x1,
  y1 = anscombe$y1) -> anscombe_1)

(tibble(
  x1 = anscombe$x2,
  y1 = anscombe$y2) -> anscombe_2)

anscombe

(tibble(
  x1 = anscombe$x3,
  y1 = anscombe$y3) -> anscombe_3)

(tibble(
  x1 = anscombe$x4,
  y1 = anscombe$y4) -> anscombe_4)

anscombe_1;anscombe_1;anscombe_3;anscombe_4

# ggplot ----
(anscombe_1plot <- anscombe_1 |> 
  ggplot(aes(x = x1, y = y1)) + 
  geom_point(size = 5) + 
  geom_smooth(method = "lm", se = F) + 
  coord_cartesian(xlim = c(0,20), ylim = c(0,15)))

(anscombe_2plot <- anscombe_2 |> 
  ggplot(aes(x = x1, y = y1)) + geom_point(size = 5) + 
  geom_smooth(method = "lm", se = F) +
  coord_cartesian(xlim = c(0,20), ylim = c(0,15)))

(anscombe_3plot <- anscombe_3 |> 
  ggplot(aes(x = x1, y = y1)) + geom_point(size = 5) + 
  geom_smooth(method = "lm", se = F) +
  coord_cartesian(xlim = c(0,20), ylim = c(0,15)))

(anscombe_4plot <- anscombe_4 |> 
  ggplot(aes(x = x1, y = y1)) + geom_point(size = 5) + 
  geom_smooth(method = "lm", se = F) +
  coord_cartesian(xlim = c(0,20), ylim = c(0,15)))

(anscombe_1plot | anscombe_2plot) / (anscombe_3plot | anscombe_4plot)

#
ggsave("anscombe_patchwork.png")


