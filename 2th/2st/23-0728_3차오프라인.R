#23-0728 fri 09:59

#
library(tidyverse)
#install.packages("MASS")
library(MASS)
#install.packages("ggthemes")
library(ggthemes)

?ggthemes
example("ggthemes")

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

#7 table
  #count
  Cars93 |> count(Manufacturer)
  Cars93 |> count(Manufacturer, Origin)
  Cars93 |> count(Type, AirBags)

  #group_by()
  Cars93 |> group_by(Type, AirBags) |> 
  summarise(n = n())
  
  # table
  table(Cars93$Manufacturer,Cars93$AirBags)

#8 pivot
  Cars93 |> count(Type, AirBags) |> 
    pivot_wider(
      names_from = "Type",
      values_from = n
    )
  
  Cars93 |> count(Type, AirBags) |> 
    pivot_wider(
      names_from = AirBags,
      values_from = n
    )
  
#9 colsum, rowsum

  Cars93 |> count(Type, AirBags) |> 
    pivot_wider(
      names_from = AirBags,
      values_from = n
    ) -> temp1

  # error
rowSums(temp1[1,2:4], na.rm = T, dims = 2L)
colSums(temp1[,2:4], na.rm = T)


#
Animals |> transmute(
  bperb = brain / body
) |> arrange(desc(bperb))


# 10 
Cars93 |> head()
Cars93 |> count(Manufacturer, Type) |> 
  pivot_wider(names_from = Type, values_from = n)

Cars93 |> count(Manufacturer, Type) |> 
  ggplot(aes(x = Manufacturer, y = Type, fill = n)) + 
  geom_tile() +
  geom_text(aes(label = n), color = "white") +
  coord_flip()

#
Cars93 |> count(Manufacturer, Type) |> 
  pivot_wider(names_from = Type,
              values_from = n)


# heatmap
Cars93 |> count(Manufacturer, Type)
Cars93 |> count(Manufacturer, Type) |> 
  ggplot(aes(x = Manufacturer, y = Type, fill = n)) +
  geom_tile() +
  geom_text(aes(label = n), color = "white") +
  coord_flip()

# heatmap
diamonds |> count(cut, color) |> 
  ggplot(aes(x = cut, y = color, fill = n)) +
  geom_tile() +
  geom_label(aes(label = n))

# 합치기
mpg |> mutate(new_model = bind_cols(model, trans)) #error
mpg |> mutate(new_model = as_factor(paste(model, trans, sep = "")))
  

#
Cars93 |> ggplot(aes(x = Type, y = Price)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label = Price, group = Type), stat = "identity",
            position = position_stack()) +
  theme_hc(style = "darkunica") #+
  scale_fill_hc("darkunica")

# 합치기 복습
mpg |> mutate(new_model = paste(model, trans, sep = "_"))
mpg |> mutate(new_model = paste(model, trans))
mpg |> count(manufacturer, model) |> 
  ggplot(aes(x = manufacturer, y = model, fill = -n)) + 
  geom_tile() +
  geom_text(aes(label = n), color = "white")

mpg |> count(manufacturer, class) |> 
  ggplot(aes(x = manufacturer, y = class, fill = -n)) + 
  geom_tile() +
  geom_text(aes(label = n), color = "white")

mpg |> count(drv, class) |> 
  ggplot(aes(x = class, y = drv, fill = n)) + 
  geom_tile(show.legend = F) +
  geom_text(aes(label = n), color = "white", size = 10) +
  bbc_style()

library(bbplot)

# 현대자동차

