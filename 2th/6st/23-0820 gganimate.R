#23-

#
library(tidyverse)
#install.packages("gganimate")
library(gganimate)

#


  
#
ggplot(mtcars) + 
  geom_boxplot(aes(factor(cyl), mpg)) + 
  transition_manual(gear)

#
ggplot(diamonds, aes(carat, price)) +
  geom_point() -> a

ggplot(txhousing, aes(month, sales)) +
  geom_bar(stat = "identity") -> b

ggplot(economics, aes(date, psavert)) +
  geom_line() -> c

#
a + 
  transition_states(color, 
                    transition_length = 3,
                    state_length = 1)

#directory 권한 변경
#https://www.youtube.com/watch?v=VfLRhPEuYDc


#b1 gifski 렌더 사용 == png 파일이 생겨서 github 연동 나쁨
# b + transition_time(year, 
#                     range = c(2000L, 2006L)) -> b1
# animate(b1, renderer = gifski_renderer())


#
# c + transition_filter(transition_length = 3,
#                       filter_length = 1,
#                       cut == "Ideal",
#                       Deep = depth >= 60) -> c1

#render error
# install.packages("gifski")
# library(gifski)


#
a + 
  transition_states(color, 
                    transition_length = 3, 
                    state_length = 1) -> anim_a

anim_a + 
  view_follow(fixed_x = T,
              fixed_y = c(2500, NA))


#view
anim_a +
  view_follow(fixed_x = TRUE, fixed_y = c(2500, NA))


#view_step()
anim_a +
  view_step(pause_length = 2, step_length = 1, nstep = 7)


#
anim_a + enter_fade()


anim_a + exit_shrink()


anim_a + enter_fly(x_loc = 0,
                   y_loc = 0)


anim_a + exit_drift(x_mod = 3, y_mod = -2)


anim_a + enter_recolour(color = "red")


anim_a + shadow_wake(wake_length = 0.05)


#
#install.packages("gapminder")
library(gapminder)

gapminder

ggplot(gapminder, 
       aes(gdpPercap, lifeExp, size = pop, colour = country)) +
  geom_point(alpha = 0.7, show.legend = FALSE) +
  scale_colour_manual(values = country_colors) +
  scale_size(range = c(2, 12)) +
  scale_x_log10() +
  facet_wrap(~continent) +
  # Here comes the gganimate specific bits
  labs(title = 'Year: {frame_time}', 
       x = 'GDP per capita', 
       y = 'life expectancy') +
  transition_time(year) +
  ease_aes('linear')

#
gapminder |> 
  ggplot(aes(x = pop, y = lifeExp, size = gdpPercap)) +
  geom_point() +
  facet_wrap(.~continent) + 
  transition_time(year) +
  labs(title = "year: {frame_time}",
       x = "인구수", 
       y = "기대수명")

country_colors
gapminder::

