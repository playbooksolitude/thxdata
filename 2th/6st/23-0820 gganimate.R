#23-

#
library(tidyverse)
#install.packages("gganimate")
library(gganimate)
<<<<<<< HEAD
#install.packages("gifski")
library(gifski)
library(gapminder)

#
getwd()

  
=======
install.packages("av")
library(av)
#

>>>>>>> e22ff0373f368fb8029412093f6f3c0b68bc99a1
#
ggplot(mtcars) + 
  geom_boxplot(aes(factor(cyl), mpg)) + 
  transition_manual(gear)


#directory 권한 변경
#https://www.youtube.com/watch?v=VfLRhPEuYDc


#b1 gifski 렌더 사용 == png 파일이 생겨서 github 연동 나쁨
# b + transition_time(year, 
#                     range = c(2000L, 2006L)) -> b1
# animate(b1, renderer = gifski_renderer())



# c + transition_filter(transition_length = 3,
#                       filter_length = 1,
#                       cut == "Ideal",
#                       Deep = depth >= 60) -> c1

<<<<<<< HEAD
#render error


#
a + 
  transition_states(color, 
                    transition_length = 3, 
                    state_length = 1) -> anim_a

anim_a + 
  view_follow(fixed_x = T,
              fixed_y = c(2500, NA))
=======
>>>>>>> e22ff0373f368fb8029412093f6f3c0b68bc99a1

#render error
#install.packages("gifski")
#library(gifski)

#install.packages("gapminder")
library(gapminder)

#gganimate
ggplot(gapminder, 
       aes(gdpPercap, lifeExp, 
           size = pop, colour = country)) +
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
  ease_aes('linear') -> temp_1

#동영상 출력 -----------------------------------------------
animate(temp_1, renderer = av_renderer())


#
anim <- ggplot(mtcars, aes(mpg, disp)) +
  geom_point(aes(color = gear)) +
  transition_states(gear, transition_length = 2, 
                    state_length = 1) +
  enter_fade() +
  exit_fade()

#
animate(anim)

# Change duration and framerate
animate(anim, fps = 20, duration = 15)

# Make the animation pause at the end and then rewind
animate(anim, nframes = 100, end_pause = 10, rewind = TRUE)

# Use a different renderer
animate(anim, renderer = file_renderer('~/animation/'))[1:6]

# Specify device dimensions and/or resolution
animate(anim, height = 2, width = 3, units = "in", res = 150)


#
(billboard |> 
  count(artist, sort = T) |> 
  slice(1:10) |> select(1) -> billboard_top10)

#
billboard |> 
  pivot_longer(cols = contains("wk"),
               names_to = "week",
               values_to = "value") -> billboard_pivot

filter(billboard_pivot$artist == billboard_top10$artist)


<<<<<<< HEAD
getwd()
#
#install.packages("gapminder")

=======
billboard |> 
  pivot_longer(cols = contains("wk"),
               names_to = "week",
               values_to = "value") |> 
  filter(artist %in% c("Jay-Z", 
                       "DMX", "Dixie Chicks, The")) |> 
  ggplot(aes(week, value, color = track)) +
  geom_point(alpha = .7, show.legend = F) +
  transition_time(date.entered) +
  labs(title = "date: {frame_time}")

#
billboard |> 
  ggplot(aes(date.entered, value, color = track)) +
  geom_point(alpha = .7, show.legend = F) +
  transition_time(date.entered) +
  labs(title = "week: {frame_time}")


#잔상 남기기
txhousing |> filter(city %in% c("Abilene", 
                                "Amarillo", 
                                "Austin", "Bay Area")) |> 
  ggplot(aes(x = year, y = sales, color = city)) +
           geom_point() +
  labs(title = "date: {frame_time}") + #frame 반올림
  transition_time(round(date,1)) +
  # transition_states(date, 
  #                   transition_length = .2, 
  #                   state_length = 1) +
  shadow_trail(distance = .1, alpha = .5)
 

# 선그리기
txhousing |> filter(city %in% c("Abilene", 
                                "Amarillo", 
                                "Austin", "Bay Area")) |> 
  ggplot(aes(x = year, y = sales, color = city)) +
  geom_point() +
  labs(title = "date: {frame_time}") + #frame 반올림
  transition_time(round(date,1)) +
  # transition_states(date, 
  #                   transition_length = .2, 
  #                   state_length = 1) +
  shadow_trail(distance = .01, alpha = .5)

#<<<<<<< HEAD
gapminder
>>>>>>> e22ff0373f368fb8029412093f6f3c0b68bc99a1

ggplot(gapminder, 
       aes(x = gdpPercap, y = lifeExp, 
         size = pop, colour = country)) +
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

#=======
#
txhousing |> filter(city %in% c("Abilene", 
                                "Amarillo", 
                                "Austin", "Bay Area")) |> 
  ggplot(aes(x = year, y = sales, color = city)) +
  geom_point() +
  labs(title = "date: {frame_time}") + #frame 반올림
  transition_time(round(date,1)) +
  # transition_states(date, 
  #                   transition_length = .2, 
  #                   state_length = 1) +
  shadow_wake(wake_length = .9, alpha = F)
#>>>>>>> f0d955cc9cb9efbd431a9bd6b27113d75d6c6db7
