#23-0807 mon 12:43

#
library(tidyverse)


#
billboard
billboard |> view()


#1 pivot
billboard |> pivot_longer(
  cols = contains("wk"), 
  names_to = "week",
  values_to = "value"
) -> billboard_2pivot


#1-1 check
billboard_2pivot |> count(artist)
billboard_2pivot |> count(artist, track)
billboard_2pivot |> filter(value == "1") |> 
  count(artist, track, sort = T)


#2 전체
billboard_2pivot |> 
  ggplot(aes(x = date.entered, y = value)) +
  geom_point()


billboard_2pivot |> 
  ggplot(aes(x = week, y = value)) +
  geom_point()


#2-1 "2 pack"
billboard_2pivot |> filter(artist %in% c("2 Pac")) |> 
  ggplot(aes(x = week, y = value)) +
  geom_point()

#2-2 "504 Boyz"
billboard_2pivot |> filter(artist %in% c("Destiny's Child")) |> 
  ggplot(aes(x = week, y = -value)) +
  geom_point()


#2-2 data
billboard |> pivot_longer(
  cols = contains("wk"), 
  names_to = "week",
  values_to = "rank"
) 


#3 billboard week1
billboard_2pivot |> filter(week == "wk1") |> 
  ggplot(aes(x = date.entered, y = value)) +
  geom_point(alpha = .1) +
  geom_text(data = billboard_2pivot |> filter(week == "wk1", value < 11), 
            aes(label = artist, x = date.entered, y = value), stat = "identity")

billboard_2pivot |> filter(week == "wk1") |> view()
