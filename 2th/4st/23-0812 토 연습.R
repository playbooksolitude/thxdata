#23-0812 sat 19:13

#
library(tidyverse)
library(nycflights13)
library(palmerpenguins)

#
by_day <- group_by(flights, year, month, day)
summarize(by_day, delay = mean(dep_delay, na.rm=TRUE)) |> 
  print(n=100)  # 100행까지 보여주기

summarize(by_day, delay = mean(dep_delay, na.rm=TRUE)) |> 
  slice(31:40) |> print()                # 31~40행까지 보여주기

# 마지막 행까지 보여주기는 print(n=Inf)
# 마지막 열까지 보여주기는 print(n=10, width=Inf)

(by_dest <- group_by(flights, dest))

delay <- summarize(by_dest,
                   count=n(),
                   dist=mean(distance, na.rm=TRUE),
                   delay = mean(arr_delay, na.rm = TRUE))
(delay <- filter(delay, count>20, dest !="HNL"))

#
flights
flights |> drop_na(dep_delay)

flights |> filter(
  is.na(dep_delay))  

flights |> group_by(month, day) |> 
  summarise(mean = mean(dep_delay, na.rm = T))

#
flights |> group_by(year, month, day) |> 
  summarise()

flights |> slice_head(n = 5)
flights |> slice_sample(n = 10)
flights |> sample_n(10)

#
penguins |> 
  drop_na(sex, body_mass_g) |> 
  group_by(species, sex) |> 
  summarise(mean_bw = mean(body_mass_g))

penguins |> 
  drop_na(sex, body_mass_g) |> 
  group_by(species, sex) |> 
  summarise(mean_bw = mean(body_mass_g), .groups = "drop")

#
penguins |> 
  drop_na(sex, body_mass_g) |> 
  group_by(species, sex) |> 
  summarise(mean_bw = mean(body_mass_g), .groups = "keep")

#
penguins |> filter(is.na(sex))
penguins |> filter(is.na(body_mass_g))
penguins |> filter(is.na(body_mass_g) | is.na(sex))

#
penguins |> 
  drop_na_(sex)

penguins |> colSums(is.na())
colSums(is.na(penguins)) |> data.frame()

