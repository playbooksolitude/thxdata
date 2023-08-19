#23-0819 토 04:50

#
library(tidyverse)
library(readxl)

#1 #2022년 =================================================
(read_excel("./2th/5st/excel/KOBIS_2022.xlsx",
            skip = 4) -> kobis2022_1excel)


#2 연도변경
(kobis2022_1excel |> 
    mutate(
      연도 = year(개봉일),
      월 = month(개봉일), 
      일 = day(개봉일), .before = 3) |> 
    select(-c(개봉일, 
              `매출액\n점유율`,국적)) -> kobis2022_2select)


#3 1000명 이상
(kobis2022_2select |> 
  filter(관객수 > 1000) |> 
  drop_na(영화명) -> kobis2022_3up1000)


#write
kobis2022_3up1000 |> 
  write_csv("./2th/5st/excel/up_1000/KOBIS_2022_c1000.xlsx")



#1 #2021년 =================================================
(read_excel("./2th/5st/excel/KOBIS_2021.xlsx",
            skip = 4) -> kobis2021_1excel)


#2 연도변경
(kobis2021_1excel |> 
    mutate(
      연도 = year(개봉일),
      월 = month(개봉일), 
      일 = day(개봉일), .before = 3) |> 
    select(-c(개봉일, 
              `매출액\n점유율`,국적)) -> kobis2021_2select)


#3 1000명 이상
(kobis2021_2select |> 
    filter(관객수 > 1000) |> 
    drop_na(영화명) -> kobis2021_3up1000)


#write
kobis2021_3up1000 |> 
  write_csv("./2th/5st/excel/up_1000/KOBIS_2021_c1000.xlsx")


#1 #2020년 =================================================
(read_excel("./2th/5st/excel/KOBIS_2020.xlsx",
            skip = 4) -> kobis2020_1excel)


#2 연도변경
(kobis2022_1excel |> 
    mutate(
      연도 = year(개봉일),
      월 = month(개봉일), 
      일 = day(개봉일), .before = 3) |> 
    select(-c(개봉일, 
              `매출액\n점유율`,국적)) -> kobis2020_2select)


#3 1000명 이상
(kobis2020_2select |> 
    filter(관객수 > 1000) |> 
    drop_na(영화명) -> kobis2020_3up1000)


#write
kobis2020_3up1000 |> 
  write_csv("./2th/5st/excel/up_1000/KOBIS_2020_c1000.xlsx")



#1 #2019년 =================================================
(read_excel("./2th/5st/excel/KOBIS_2019.xlsx",
            skip = 4) -> kobis2019_1excel)


#2 연도변경
(kobis2019_1excel |> 
    mutate(
      연도 = year(개봉일),
      월 = month(개봉일), 
      일 = day(개봉일), .before = 3) |> 
    select(-c(개봉일, 
              `매출액\n점유율`,국적)) -> kobis2019_2select)


#3 1000명 이상
(kobis2019_2select |> 
    filter(관객수 > 1000) |> 
    drop_na(영화명) -> kobis2019_3up1000)


#write
kobis2019_3up1000 |> 
  write_csv("./2th/5st/excel/up_1000/KOBIS_2019_c1000.xlsx")



#1 #2018년 =================================================
(read_excel("./2th/5st/excel/KOBIS_2018.xlsx",
            skip = 4) -> kobis2018_1excel)


#2 연도변경
(kobis2018_1excel |> 
    mutate(
      연도 = year(개봉일),
      월 = month(개봉일), 
      일 = day(개봉일), .before = 3) |> 
    select(-c(개봉일, 
              `매출액\n점유율`,국적)) -> kobis2018_2select)


#3 1000명 이상
(kobis2018_2select |> 
    filter(관객수 > 1000) |> 
    drop_na(영화명) -> kobis2018_3up1000)


#write
kobis2018_3up1000 |> 
  write_csv("./2th/5st/excel/up_1000/KOBIS_2018_c1000.xlsx")




