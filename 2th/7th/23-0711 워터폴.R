#23-0711 13:45 tue

#
library(tidyverse)
library(bbplot)
#install.packages("waterfalls")
library(waterfalls)

#히트맵 컬러 그라디언트
diamonds |> count(cut, clarity) |> 
  ggplot(aes(clarity, cut, fill = n)) +
  geom_tile() +
  scale_fill_gradient(low = "white", high = "red") +
  geom_text(aes(label = n))

# count 계산하기
diamonds |> count(cut, clarity) |> 
  count(cut == "Fair", wt = n)

# dataset 으로 만들기
(table(diamonds$cut) |> as.data.frame() -> tmp1)

#그라디언트 응용
diamonds |> count(cut, color) |> 
  ggplot(aes(x = cut, y = color, fill = n)) + 
  geom_tile() +
  scale_fill_gradient(low = "white", high = "red") +
  geom_text(aes(label = n))

#
tmp1 |> 
  waterfall()

ggplot(
data = table(diamonds$cut) |> as.data.frame()) +
  geom_tile(aes(x = Var1, y = Freq)) +
  geom_text(aes(x = Var1, y = Freq, label = Freq), color = "white")

# dataset 없이
ggplot(
  data = table(diamonds$cut) |> as.data.frame(),
  aes(x = Var1, y = Freq)) +
  waterfall()
  
table(diamonds$cut) |> as.data.frame()

# tmp1 |> ggplot(aes(Var1, Freq)) +
#   geom_tile() + 
#   geom_text(aes(label = Freq), color = "white")
    

diamonds |> count(cut)
waterfall(df)

#워터폴 예시
temp1 <- LETTERS[1:8]
temp2 <- c(2000, 4000, 1000, 500,
           -1500, 1000, -2500, 500)
df <- data.frame(x = temp1, y = temp2) 
waterfall(df)

#
waterfall(values = round(rnorm(5), 1), 
          labels = letters[1:5], 
          calc_total = TRUE)

waterfall(.data = data.frame(category = letters[1:5],
                             value = c(100, -20, 10, 20, 110)), 
          fill_colours = 
            colorRampPalette(c("#1b7cd6", "#d5e6f2"))(5),
          fill_by_sign = F)

#
example("waterfall")
args(waterfall)

