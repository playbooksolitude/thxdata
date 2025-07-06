#23-0805 sat 10:47

#
library(tidyverse)
#install.packages("palmerpenguins")
library(palmerpenguins)
library(gt)
library(MASS)

#
palmerpenguins::penguins

#
ggplot(data = penguins, 
      mapping = aes(x = bill_length_mm,
                    y = bill_depth_mm,
                    color = species,
                    shape = species)) +
  theme(legend.position = "top") +
  geom_point() +
  facet_grid(island~year)
  

#gt
penguins |> 
  select(species, island, bill_length_mm, bill_depth_mm) |> 
  gt()


#
mpg
ggplot(mpg, aes(x = manufacturer, fill = drv)) + 
  geom_bar(position = "dodge") +
  geom_text(aes(label = stat(count), 
                group = drv), 
            stat = "count", 
            position = position_dodge(width = 1))


#
starwars |> ggplot(aes(x = sex, fill = gender)) +
  geom_bar(position = "dodge") +
  geom_label(aes(label = stat(count)), stat = "count",
             position = position_dodge(width = .9))


#
starwars |> with(homeworld) |> table() |> as.data.frame() |> 
  count(wt = Freq) # 77개 #strange

table(starwars$homeworld, useNA = "always")

starwars |> with(homeworld) |> table(useNA = "ifany") |> 
  as.data.frame() |> count(wt = Freq)  #good

#
starwars |> with(species) |> table(useNA = "ifany") |> 
  as.data.frame()


#
starwars |> 
  ggplot(aes(x = species, y = homeworld)) +
  geom_tile()

#
starwars |> count(sex, gender) |> 
  ggplot(aes(x = sex, y = gender, fill = n)) +
  geom_tile() +
  geom_text(aes(label = n), color = "white")
  

#
table(starwars$eye_color)

#
starwars |> count(eye_color, sex) |> 
  ggplot(aes(x = eye_color, y = sex, fill = n)) +
  geom_tile() +
  geom_text(aes(label = n), stat = "identity", color = "white")


#
starwars |> filter(sex == "male") |> 
  count(eye_color, hair_color, sex) |> 
  ggplot(aes(x = eye_color, y = hair_color, fill = n)) +
  geom_tile() +
  geom_text(aes(label = n), stat = "identity", color = "white") +
  facet_wrap(.~sex, scales = "free")


#
MASS::Aids2
MASS::Traffic
data()
household


#
ggplot(household, aes(x = dob_child1)) +
  geom_line(aes(y = family))
?geom_segment


#
ggplot(household, aes(y = family, yend = family)) +
  geom_segment(aes(x = dob_child1, xend = dob_child1+100),
               arrow = arrow(length = unit(.03, "npc"))) +
  geom_segment(aes(x = dob_child2, xend = dob_child2+100),
               arrow = arrow(length = unit(.03, "npc"))) +
  geom_text(aes(label = name_child1, y = family + .17, x = dob_child1)) +
  geom_text(aes(label = name_child2, y = family + .17, x = dob_child2)) +
  geom_point(aes(x = dob_child1)) +
  geom_point(aes(x = dob_child2)) +
  labs(x = "dob child")

library(bbplot)
