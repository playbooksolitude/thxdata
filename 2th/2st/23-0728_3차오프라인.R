#23-0728 fri 09:59

#
library(tidyverse)


#1 package 종류
ls('package:tidyverse') 
ls('package:tidyverse') |> length()
ls('package:dplyr')
ls('package:dplyr') |> length()
ls('package:ggplot2')
ls('package:ggplot2') |> length()

#2 dplyr top_n()
df <- data.frame(x = c(6, 4, 1, 10, 3, 1, 1))
df |> top_n(2)
sample(1:10, 5) |> as.tibble() |> top_n(1)
sample(1:10, 5) |> as.tibble() |> top_n(-1)


#3 rownames_to-column
rownames_to_column(WorldPhones, var = "year") # error
WorldPhones |> as.tibble()                    # year 누락
WorldPhones |> as.data.frame() |> 
  rownames_to_column("year")                  # good

#4 matrix
matrix(
  sample(1:10),
  nrow = 2) 

#5 대소문자
1 == 1
"a" == "a"
"A" == "a"

#6 
Cars93 |> head()
Cars93 |> view()
Cars93 |> top_n(Length, 10)
top_n(Cars93$Width, 5)

Cars93  |> colnames()
glimpse(Cars93)

# table
  #count
  Cars93 |> count(Manufacturer)
  Cars93 |> count(Manufacturer, Origin)
  Cars93 |> count(Type, AirBags)

  #group_by()
  Cars93 |> group_by(Type, AirBags) |> 
  summarise(n = n())

  table(Cars93$Model)
MASS::quine  
ls('package:MASS')
data()

#
Animals
