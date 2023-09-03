#23-0901 fri 15:07

#
library(palmerpenguins)

#
penguins

#https://allisonhorst.github.io/palmerpenguins/

#
penguins |> 
  ggplot(aes(x = bill_length_mm, 
    y = bill_depth_mm)) +
  geom_point()


#
penguins |> 
  ggplot(aes(x = bill_length_mm, 
    y = bill_depth_mm)) +
  geom_point() +
  geom_smooth(method = "lm", se = F)

#
penguins |> 
  ggplot(aes(x = bill_length_mm, 
    y = bill_depth_mm,
    color = species)) +
  geom_point() 

#
penguins |> 
  ggplot(aes(x = bill_length_mm, 
    y = bill_depth_mm,
    color = species)) +
  geom_point() +
  geom_smooth(method = "lm", se = F)


#
penguins |> 
  drop_na(sex) |> 
  ggplot(aes(x = bill_length_mm, 
    y = bill_depth_mm,
    color = species)) +
  geom_point() +
  geom_smooth(method = "lm", se = F) +
  facet_wrap(.~sex)
