#25-0722 

#
library(tidyverse)

clipr::read_clip_tbl() -> a

a |> 
  as_tibble() |> 
  #view()
  rename(date = 1, 
         value = 2) |> 
  mutate(value_edit = parse_number(value), 
         date_edit = parse_number(date)) |> 
  ggplot(aes(x = date_edit, y = value_edit)) +
  geom_point() +
  geom_smooth()
