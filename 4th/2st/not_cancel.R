#25-0718 fri 09:11

#
library(tidyverse)
library(nycflights13)

#
flights |> 
  group_by(year, month) |> 
  mutate(r = min_rank(desc(dep_time))) 
  filter(r %in% range(r))

#not_cancel
flights |> 
  filter(!is.na(dep_time), !is.na(arr_time)) -> not_cancel

#flights |> 
not_cancel |> 
  group_by(year, month, day) |> 
  mutate(r = min_rank(dep_time), .before = 1) |> 
  filter(r %in% range(r)) |> 
  ungroup()

# 월별_1개씩_row_number() ----
not_cancel |> 
  group_by(year, month) |> 
  mutate(r = row_number(dep_time), .before = 1) |> 
  filter(r %in% range(r)) |> 
  ungroup()

# 월별_1개씩_origin
not_cancel |> 
  group_by(year, month, origin) |> 
  mutate(r = row_number(dep_time), .before = 1) |> 
  filter(r %in% range(r)) |> 
  ungroup() |> 
  select(year, month, day, origin, dest, dep_time) |> 
  arrange(month, dep_time)
