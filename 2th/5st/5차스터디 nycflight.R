#23-0817 목 14:02

#


#

# ----------------------------------------------------------
library(nycflights13)
flights |> count(origin)
flights |> count(dest)
table(flights$month)

# 
flights |> 
  group_by(origin, dest) |> 
  summarise(n = n())

#
flights |> 
  group_by(origin, dest, distance) |> 
  summarise()

flights |> 
  select(origin, dest, distance)

# origin -> dest, distance 개수
flights |> 
  group_by(origin, dest, distance) |> 
  summarise(n = n())

# dest, distance 개수
flights |> 
  group_by(dest, distance) |> 
  summarise(n = n())


# ggplot #tile #운항횟수
flights |> 
  group_by(origin, dest) |> 
  summarise(n = n()) |> 
  filter(n > 1000) |> 
  ggplot(aes(x = origin, 
             y = dest,
             fill = n)) +
  geom_tile() +
  geom_text(aes(label = n), color = "white") +
  scale_fill_gradient(low = "grey", high = "red")


# 거리
flights |> 
  group_by(origin, dest, distance) |> 
  summarise() |> 
  filter(distance > 1000) |> 
  ggplot(aes(x = origin, 
             y = dest,
             fill = distance)) +
  geom_tile() +
  geom_text(aes(label = distance), color = "white") +
  scale_fill_gradient(low = "grey", high = "red") +
  #facet_wrap(.~origin, scales = "free") +
  labs(title = "origin ~ dest, distance") +
  theme(legend.position = "right",
        panel.background = element_blank())


# ggplot #tile
flights |> 
  filter(month %in% c("1","7")) |> 
  group_by(month, origin, dest) |> 
  summarise(n = n()) |> 
  #filter(n > 1000) |> 
  ggplot(aes(x = origin, 
             y = dest,
             fill = n)) +
  geom_tile() +
  geom_text(aes(label = n), color = "white") +
  scale_fill_gradient(low = "grey", high = "red") +
  facet_wrap(.~month)
