#23-0726 wedn 10:23

#
library(tidyverse)


#

sample(1:6, 6, replace = T)
round(mean(sample(1:6, 6, replace = T)),1)
replicate(20,round(mean(sample(1:6, 6, replace = T)),1))

replicate(20,round(mean(sample(1:6, 6, replace = T)),1)) |> 
  barplot()

replicate(1000,round(mean(sample(1:6, 6, replace = T)),1)) |> 
  hist()

replicate(10000,round(mean(sample(1:6, 6, replace = T)),1)) |> 
  hist()

replicate(10000,round(mean(sample(1:6, 6, replace = T)),1)) |> 
  as.data.frame() -> temp_a

temp_a |> as.tibble() |> mutate(
  num = row_number(), .before = 1
) |> rename(mean = 2) -> temp_2

ggplot(temp_2, aes(x =mean)) +
  stat_density(adjust = 2)

?geom_density
geom_bar
ggplot(temp_2, aes(x =mean)) +
  geom_histogram(bins = 10)

#응용
sample(1:1000, 6, replace = T)
round(mean(sample(1:1000, 6, replace = T)), 1)
replicate(20, round(mean(sample(1:1000, 6, replace = T)), 1))
replicate(20, round(mean(sample(1:1000, 6, replace = T)), 1)) |> 
  barplot()

round(mean(sample(1:100, 6, replace = T)), 1)
replicate(10000, round(mean(sample(1:100, 6, replace = T)), 1)) |> 
  hist()


replicate(10000, round(mean(sample(1:100, 10, replace = T)), 1)) |> 
  hist()

replicate(10000, round(mean(sample(1:100, 20, replace = T)), 1)) |> 
  hist()
