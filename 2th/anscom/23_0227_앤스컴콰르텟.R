#23-0227 mon office 11:50

#
library(tidyverse)
library(bbplot)
library(patchwork)

#anscombe
anscombe

# --------------------------- dataset
tibble(
  x1 = anscombe$x,
  y1 = anscombe$y
) -> anscombe_1

tibble(
  x1 = anscombe$x.1,
  y1 = anscombe$y.1
) -> anscombe_2

tibble(
  x1 = anscombe$x.2,
  y1 = anscombe$y.2
) -> anscombe_3

tibble(
  x1 = anscombe$x.3,
  y1 = anscombe$y.3
) -> anscombe_4

anscombe_1;anscombe_1;anscombe_3;anscombe_4

# --------------------------- ggplot
(anscombe_1 |> 
  ggplot(aes(x = x1, y = y1)) + 
  geom_point(size = 5) + 
  geom_smooth(method = "lm", se = F) + 
  coord_cartesian(xlim = c(0,20), ylim = c(0,15)) -> a1)

anscombe_2 |> 
  ggplot(aes(x = x1, y = y1)) + geom_point(size = 5) + 
  geom_smooth(method = "lm", se = F) +
  coord_cartesian(xlim = c(0,20), ylim = c(0,15)) -> a2

anscombe_3 |> 
  ggplot(aes(x = x1, y = y1)) + geom_point(size = 5) + 
  geom_smooth(method = "lm", se = F) +
  coord_cartesian(xlim = c(0,20), ylim = c(0,15)) -> a3

anscombe_4 |> 
  ggplot(aes(x = x1, y = y1)) + geom_point(size = 5) + 
  geom_smooth(method = "lm", se = F) +
  coord_cartesian(xlim = c(0,20), ylim = c(0,15)) -> a4

(a1 | a2) / (a3 | a4)
ggsave("anscombe_patchwork.png")


