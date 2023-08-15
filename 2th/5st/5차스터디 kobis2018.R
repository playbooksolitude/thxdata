#23-0815 화 22:31

#
library(tidyverse)
library(readxl)

#
read_excel("./2th/5st/excel/KOBIS_2018.xlsx",
           skip = 4) -> kobis2018_1excel

#2
kobis2018_1excel |> glimpse()

kobis2018_1excel |> 
  mutate(
    연도 = year(개봉일),
    월 = month(개봉일), 
    일 = day(개봉일), .before = 3) |> 
  select(-c(개봉일, 
            `매출액\n점유율`,국적)) -> kobis2018_2select

#3 adult
kobis2018_2select |> head()
kobis2018_2select |> 
  slice(3990:4000) |>
  select(1:9)
