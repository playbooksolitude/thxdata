#23-0911 mon 08:12

#
library(tidyverse)


#
ggplot(data = mpg,
       mapping = aes(x = displ, y = cty)) +
  geom_point(data = mpg |> select(-drv), 
             color = "grey", alpha = .3) +
  geom_point(aes(color = drv), show.legend = F) +
  facet_wrap(.~drv, nrow = 2)

#
library(palmerpenguins)


#
penguins |> names()
# species : 펭귄 종
# island : 서식지
# bill_length_mm : 부리 길이
# bill_depth_mm : 부리 위아래 두께
# flipper_length_mm : 팔 길이
# body_mass_g : 몸무게
# sex : 성별


penguins |> 
  drop_na(bill_length_mm, bill_depth_mm, sex) |> 
  ggplot(aes(x = bill_length_mm, y = bill_depth_mm)) +
  geom_point(data = penguins |> 
               drop_na(bill_depth_mm, bill_depth_mm) |> 
               select(-sex, island), 
             color = "grey", alpha = .3) +
  geom_point(data = penguins |> 
               drop_na(bill_length_mm, bill_depth_mm, sex),
             aes(color = sex), show.legend = F) +
  facet_grid(sex~island) +
  geom_smooth(se = F, method = "lm") -> pen_sex_island

#
is.na(penguins) |> colSums()

penguins |> 
  drop_na(bill_length_mm, bill_depth_mm, sex) |> 
  ggplot(aes(x = bill_length_mm, y = bill_depth_mm)) +
  geom_point(data = penguins |> 
               drop_na(bill_depth_mm, bill_depth_mm) |> 
               select(-sex, island), 
             color = "grey", alpha = .3) +
  geom_point(data = penguins |> 
               drop_na(bill_length_mm, bill_depth_mm, sex),
             aes(color = sex), show.legend = F) +
  facet_grid(sex~.) +
  geom_smooth(se = F, method = "lm") -> pen_sex

#
penguins |> 
  drop_na(bill_length_mm, bill_depth_mm, sex) |> 
  ggplot(aes(x = bill_length_mm, y = bill_depth_mm)) +
  geom_point(data = penguins |> 
               drop_na(bill_depth_mm, bill_depth_mm) |> 
               select(-sex, island), 
             color = "grey", alpha = .3) +
  geom_point(data = penguins |> 
               drop_na(bill_length_mm, bill_depth_mm, sex),
             aes(color = sex), show.legend = F) +
  facet_grid(.~island) +
  geom_smooth(se = F, method = "lm") -> pen_island

library(patchwork)

pen_sex | pen_island

(pen_sex | pen_island) / pen_sex_island
