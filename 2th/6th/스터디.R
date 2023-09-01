#23-0827 sun 15:0

#
library(tidyverse)


# 주영님
kobis2020_2date |> 
  drop_na(월) |> 
  count(대표국적, 월,sort=T) |> 
  arrange(desc(월))

# 진세은
diamonds
x = y

diamonds |> 
  ggplot(aes(x = y)) + 
  #geom_histogram() 
  geom_point(stat = "count")

diamonds |> 
  filter(y > 20, y < 40)

diamonds |> glimpse()
