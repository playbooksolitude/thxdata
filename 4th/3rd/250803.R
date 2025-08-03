#25-0803 sun 15:05

#
library(tidyverse)

data()
starwars |> view()

starwars |> 
  glimpse()

starwars |> 
  str()

#
starwars |> 
  colnames()

starwars |> 
  count(sex, gender)

starwars |> 
  count(gender)

starwars |> 
  count(hair_color)

# mean() 평균 height,mass
starwars |> 
  mean(mass, na.rm = T)

starwars
mean(starwars$mass)  

#
starwars |> 
  count(mass, sort = T)

# 평균 ----
mean(starwars$mass, na.rm = T)

starwars |> 
  drop_na(mass) |> 
  reframe(mean(mass), 
          n = n())

#
colSums(is.na(starwars))
colnames(starwars)
names(starwars)

names()
colnames()

# geom_bar----
starwars |> 
  count(gender)



starwars |> 
  ggplot(aes(x = gender, 
             y = after_stat(count))) +
  geom_bar(stat = 'count') +
  geom_label(aes(label = after_stat(count)), 
             stat = 'count', size = 6)

ggplot(data = starwars, mapping = aes(x = gender))


starwars |> 
  count(gender) |> 
  ggplot(aes(x = gender, y = n)) +
  geom_bar(stat = 'identity')
ggtitle() #starwars gender

starwars

# starwars  
# x = height, y = birth_year 
# geom_point

starwars |> 
  ggplot(aes(x = height, y= birth_year)) +
  geom_point() +
  #geom_text(aes(label = name)) 
  geom_text_repel(aes(label = name), 
                  box.padding = 1, )

starwars |> 
  filter(birth_year > 750)

install.packages('ggrepel')
library('ggrepel')



#
starwars |> 
  mutate(
    across(
      where(is.character), as.factor)
  )

#
diamonds
diamonds |> 
  filter(x == 0)

# x, y, z 중에 이상한 것
# carat, cut 
colSums(is.na(diamonds))

#
diamonds |> 
  summary()

library(tidyverse)
library(GGally)

diamonds |> 
  ggpairs()

diamonds
diamonds

pairs()

#
diamonds |> 
  ggplot(aes(x = x, y = y)) +
  geom_point()

diamonds |> 
  mutate(
    number = row_number(), .before = 1
  ) -> diamonds_1num

diamonds |> 
  mutate(
    number = row_number(), .before = 1
  ) |> 
  arrange(desc(price)) -> diamonds_2price


diamonds |> 
  arrange(-price) |> 
  mutate(number = row_number(carat), .before = 1)

diamonds |> 
  mutate(
    number = row_number(), .before = 1
  )

diamonds 


diamonds |> 
  count(cut, color)

diamonds |> 
  count(cut, color) |> 
  ggplot(aes(x = cut, y = n, color = color)) +
  geom_point(size = 4)




diamonds |> 
  mutate(
    number = min_rank(desc(price)), .before = 1
  ) |> 
  arrange(number)



diamonds_2price 


diamonds_1num
diamonds_1num
geom_text_repel()

#filter ----
#24068
#49190
#11183

sleep


library(ggpubr)
ggplot(diamonds_1num, aes(x = x, y = y)) +
  geom_point() +
  stat_chull()

diamonds_1num |> 
  filter(x < 1)

diamonds |> 
  group_by_all() |> 
  reframe(n = n()) |> 
  filter(n > 1)

diamonds_1num |> 
  count(cut, color) |> 
  ggplot(aes(x = cut, y = n, color = color)) +
  geom_point(size = 4)


diamonds_1num |> 
  count(cut, color) |> 
  ggplot(aes(x = cut, y = n, fill = color)) +
  geom_bar(stat = 'identity', position = 'dodge')
#geom_bar(stat = 'identity', position = 'stack')
#geom_bar(stat = 'identity', position = 'identity')

diamonds |> 
  count(cut, color) |> 
  filter(cut %in% c('Ideal'))

library(scales)
diamonds |> 
  count(cut, color) |> 
  ggplot(aes(x = cut, y = color, fill = n)) +
  geom_tile(color ='grey30') +
  geom_text(aes(label = comma(n)), 
            color = 'black') +
  scale_fill_gradient2(low = 'snow', high = 'red') 

#geom_bar()
# aes(x = cut)
# Premium = 13791 
# Good = 4906

library(nycflights13)

flights |>
  group_by(month, day) |> 
  filter(
    dep_time %in% range(dep_time))













# diamonds |> 
#   get_dupes() |> 
#   print(n = Inf)












