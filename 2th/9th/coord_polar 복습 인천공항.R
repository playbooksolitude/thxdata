#23-0911

#
library(tidyverse)
library(readxl)
library(nord)
library(showtext)
showtext_auto()

#
read_excel("./2th/9th/arr_22_12.xlsx") -> arr_1csv
read_excel("./2th/9th/dep_22_12.xlsx") -> dep_1csv



#
arr_1csv |> 
  count(항공사, sort = T) |> 
  filter(n > 100) |> 
  ggplot(aes(x = 항공사 |> fct_reorder(desc(n)), 
             y = n, fill = 항공사)) +
  geom_bar(stat = "identity", show.legend = F) +
  coord_polar() +
  ylim(-500, 3000) +
  scale_fill_nord("baie_mouton") +
  theme_void()

nord_palettes

#
mpg |> count(manufacturer, model, drv, sort = T) |> 
  mutate(num = row_number(), .before = 1) -> temp_d
temp_d -> temp_l

90-(360*(temp_l$num-.5)/nrow(temp_d)) -> angle2
temp_l$hjust <- ifelse(angle2 < -90, 1, 0)
temp_l$angle2 <- ifelse(angle2 < -90, angle2 + 180, angle2)

temp_l |> print(n = Inf)

ggplot(temp_d,
       aes(x = as.factor(num),
           y = n)) +
  geom_bar(stat = "identity", alpha = .7,
           aes(fill = drv)) +
  coord_polar(start = 0) +
  theme_void() +
  theme(legend.position = "top") +
  ylim(-3, 14) +
  geom_text(data = temp_l,
            aes(x = num, y = n+1,
                label = model,
                hjust = hjust),
            color = "black", size = 4,
            angle = temp_l$angle2, inherit.aes = F) +
  scale_fill_nord("baie_mouton")
  


# -----------------------------------------------------
arr_1csv |> glimpse()

#
arr_1csv |> 
  count(항공사, 출발공항명, 구분, sort = T) |> 
  filter(n > 90) |> 
  mutate(num = row_number(), .before = 1) -> temp_d
temp_d -> temp_l

angle2 <- 90-(360*(temp_l$num-.5)/nrow(temp_d))
temp_l$hjust <- ifelse(angle2 < -90, 1, 0)
temp_l$angle2 <- ifelse(angle2 < -90, angle2 + 180, angle2)

ggplot(temp_d,
       aes(x = as.factor(num),
           y = n)) +
  geom_bar(stat = "identity", alpha = .7,
           aes(fill = 항공사)) +
  coord_polar(start = 0) +
  theme_void() +
  theme(legend.position = "top") +
  ylim(-50, 200) +
  geom_text(data = temp_l,
            aes(x = num, y = n+1,
                label = paste(출발공항명," & ",항공사),
                hjust = hjust),
            color = "black", size = 4,
            angle = temp_l$angle2, inherit.aes = F) +
  labs(title = "인천공항 Arrived 2022.12") +
  #scale_fill_nord("afternoon_prarie") +
  scale_fill_discrete_qualitative("Harmonic")
  #scale_fill_discrete_qualitative("Dark2")

nord_palettes
library(colorspace)
colorspace::hcl_palettes(plot = T)

