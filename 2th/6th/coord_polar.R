#23-0822 tues 18:30

#
library(tidyverse)

#
(mpg |> count(manufacturer, model) -> temp1)

#colorspace
temp1 |> 
  ggplot(aes(x = model, y = n, fill = manufacturer)) +
  geom_bar(stat = "identity") +
  scale_fill_discrete_qualitative("cold", n = 15) +
  ylim(-5,12) +
  theme_void() +
  coord_polar() #+

#nord()
temp1 |> 
  ggplot(aes(x = model, y = n, fill = manufacturer)) +
  geom_bar(stat = "identity") +
  nord::scale_fill_nord("afternoon_prarie") +
  ylim(-5,12) +
  theme_void() +
  coord_polar() 

#coord_polar
(df <- read_csv(file='https://github.com/regenesis90/datasets/raw/master/sample04_circular_barplot_df.csv'))

glimpse(df)
df
lb <- df
lb
(angle <- 90-(360*(lb$rno-.5)/nrow(df)))
(lb$hjust <- ifelse(angle < -90, 1, 0))
(lb$angle <- ifelse(angle < -90, angle + 180, angle))
lb

#
ggplot(df, 
       aes(x = as.factor(rno), 
           y = test_result)) +
  geom_bar(stat = "identity", alpha = .7, fill = 'pink')+
  coord_polar(start = 0) +
  ylim(-100, 120) +
  theme_void() +
  geom_text(data = lb, 
            aes(x = rno,test_result+10,
                    label = rname,
                    hjust = hjust),
            color = "black", size = 4,
            angle = lb$angle, inherit.aes = F)

#
mpg |> count(manufacturer, model, drv, sort = T) |> 
  mutate(num = row_number(), .before = 1) -> temp_d
temp_d -> temp_l

(angle2 <- 90-(360*(temp_l$num-.5)/nrow(temp_d)))
(temp_l$hjust <- ifelse(angle2 < -90, 1,0))
(temp_l$angle2 <- ifelse(angle2 < -90, angle2 + 180, angle2))
temp_l

ggplot(temp_d,
       aes(x = as.factor(num),
           y = n)) +
  geom_bar(stat = "identity", alpha = .7,
           aes(fill = drv)) +
  coord_polar() +
  ylim(-3, 14) +
  theme_void() +
  geom_text(data = temp_l,
            aes(x = num, y = n+1,
                label = model, 
                hjust = hjust),
            color = "black", size = 4,
            angle = temp_l$angle2, inherit.aes = F) +
  scale_fill_nord("afternoon_prarie")

nord_palettes

#
par(mfrow = c(2,2))
ggplot(mpg, aes(x = drv)) +
  geom_bar(stat = "count")

#
ggplot(mpg, aes(x = trans)) +
  geom_bar(stat = "count")

#
op <- par(mfrow=c(2, 2))
op

#
