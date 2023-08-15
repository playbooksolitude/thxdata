#23-0815 tue 09:32

#
library(tidyverse)

#
diamonds |> count(color, cut)

#
diamonds |> count(color, cut) |> 
  ggplot(aes(x = color, y = cut, fill = n)) +
  geom_tile() +
  geom_text(aes(label = n), 
            color = "white", 
            angle = 30)

#
diamonds
starwars |> drop_na()
starwars |> filter(is.na(hair_color))
starwars |> dplyr::na_if()

colSums((is.na(starwars))) |> 
  data.frame() |> 
  rownames_to_column(var = "컬럼") |> 
  rename(값 = 2) |> 
  pivot_wider(
    names_from = 컬럼,
    values_from = 값
  )

                    