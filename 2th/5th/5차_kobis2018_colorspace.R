#23-0815 화 22:31

#
library(tidyverse)
library(readxl)


# colorspace -------------------------------------
#install.packages("colorspace")
library(colorspace)

colorspace::hcl_palettes()
colorspace::hcl_palettes(plot = T)
colorspace::hcl_palettes(plot = T, type = "Qualitative")
colorspace::hcl_palettes(plot = T, 
                         type = "Qualitative",
                         palette = "Cold", 
                         n = 6)

colorspace::hcl_palettes(plot = T, 
                         type = "Qualitative",
                         palette = "Cold", 
                         n = 6)

#컬러코드를 알고 싶을 때
colorspace::qualitative_hcl(6, palette = "Dark 3")
colorspace::qualitative_hcl(n = 6, 
                            palette = "Cold")



library(palmerpenguins)
penguins |> 
  drop_na() |> 
  ggplot(aes(x = species, 
             y = body_mass_g, 
             color = body_mass_g)) +
  geom_jitter(width = .2)



#
penguins |> 
  drop_na() |> 
  ggplot(aes(x = species, 
             y = body_mass_g, 
             color = body_mass_g)) +
  geom_jitter(width = .2) +
  colorspace::scale_color_continuous_sequential(
    palette = "Teal", begin = .1, end = .9)

hcl_palettes(plot = T, type = "Sequential")

penguins |> 
  drop_na() |> 
  ggplot(aes(x = species, 
             y = body_mass_g, 
             color = body_mass_g)) +
  geom_jitter(width = .2) +
  colorspace::scale_color_continuous_sequential(
    palette = "Teal", begin = .9, end = .1)


# 이산형
penguins |> 
  ggplot(aes(x = body_mass_g, fill = species)) +
  geom_histogram(bins = 10, color = "white") +
  scale_fill_discrete_qualitative(palette = "cold",
                                  alpha = .8, 
                                  order = c(2,3,1)) +
  labs(title = "colorspace")

hcl_palettes(plot = T)



#geom_text vs histogram ------------------------------------
penguins |> 
  ggplot(aes(x = body_mass_g, fill = species)) +
  geom_histogram(bins = 20, 
                 color = "white") +
  scale_fill_discrete_qualitative(palette = "cold",
                                  alpha = .8, 
                                  order = c(2,3,1)) +
  labs(title = "colorspace")  +
  # stat_bin(aes(label = after_stat(count)), 
  #          stat = "count", 
  #          bins = 20, geom = "text")
  stat_bin(aes(label = 
                 after_stat(ifelse(count == 0, "", count))), 
           stat = "count", 
           bins = 20, geom = "text")


# 참고
# https://stackoverflow.com/questions/66841848/whats-the-right-way-to-add-text-to-geom-histogram-in-ggplot

#
diamonds |> count(color, cut) |> 
  ggplot(aes(x = color, y = cut, fill = n)) +
  geom_tile() +
  geom_text(aes(label = n), color = "white") +
  scale_fill_continuous_sequential(palette = "dark mint", 
                                   begin = .3, 
                                   end = .9)


#density() 그릴 것
penguins |> 
  ggplot(aes(x = body_mass_g, fill = species)) +
   geom_histogram(bins = 20, 
                  color = "white") +
  scale_fill_discrete_qualitative(palette = "cold",
                                  alpha = .8,
                                  order = c(2,3,1)) +
  labs(title = "colorspace") #+
#  geom_density(fill = "red")

args(geom_density)
?geom_density


# na 값이 있을 경우 na.value = "grey50"
penguins |> 
  ggplot(aes(x = species, y = after_stat(count), 
             fill = sex)) + 
  geom_bar() +
  geom_text(aes(label = after_stat(count)), 
            stat = "count",
            position = position_stack(vjust = .5)) +
  scale_fill_discrete_qualitative(palette = "set 2", 
                                  n = 2,
                                  na.value = "grey50")

hcl_palettes(plot = T)














