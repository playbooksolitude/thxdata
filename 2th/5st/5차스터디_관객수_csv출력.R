#23-0819 토 04:50

#
library(tidyverse)

#2022
(read_excel("./2th/5st/excel/KOBIS_2022.xlsx",
            skip = 4) -> kobis2022_1excel)

#
(kobis2022_1excel |> 
    mutate(
      연도 = year(개봉일),
      월 = month(개봉일), 
      일 = day(개봉일), .before = 3) |> 
    select(-c(개봉일, 
              `매출액\n점유율`,국적)) -> kobis2022_2select)


#
(kobis2022_2select |> 
  filter(관객수 > 1000) |> 
  drop_na(영화명) -> kobis2022_3under1000)



# (kobis2022_3under |> 
#   select(순위:매출액, 
#          관객수, 
#          스크린수:대표국적,
#          제작사:배우) -> kobis2022_4tidy)


#write
kobis2022_3under1000 |> 
  write_csv("./2th/5st/excel/top1000/KOBIS_2022_c1000.xlsx")



#2021 ------------------------------------------------------
(read_excel("./2th/5st/excel/KOBIS_2021.xlsx",
            skip = 4) -> kobis2021_1excel)

#
(kobis2021_1excel |> 
    mutate(
      연도 = year(개봉일),
      월 = month(개봉일), 
      일 = day(개봉일), .before = 3) |> 
    select(-c(개봉일, 
              `매출액\n점유율`,국적)) -> kobis2021_2select)


#
(kobis2021_2select |> 
    filter(관객수 > 1000) |> 
    drop_na(영화명) -> kobis2021_3under1000)


#write
kobis2021_3under1000 |> 
  write_csv("./2th/5st/excel/top1000/KOBIS_2021_c1000.xlsx")



#2020 ------------------------------------------------------
(read_excel("./2th/5st/excel/KOBIS_2020.xlsx",
            skip = 4) -> kobis2020_1excel)

#
(kobis2020_1excel |> 
    mutate(
      연도 = year(개봉일),
      월 = month(개봉일), 
      일 = day(개봉일), .before = 3) |> 
    select(-c(개봉일, 
              `매출액\n점유율`,국적)) -> kobis2020_2select)


#
(kobis2020_2select |> 
    filter(관객수 > 1000) |> 
    drop_na(영화명) -> kobis2020_3under1000)


#write
kobis2020_3under1000 |> 
  write_csv("./2th/5st/excel/top1000/KOBIS_2020_c1000.xlsx")


#2019 ------------------------------------------------------
(read_excel("./2th/5st/excel/KOBIS_2019.xlsx",
            skip = 4) -> kobis2019_1excel)

#
(kobis2019_1excel |> 
    mutate(
      연도 = year(개봉일),
      월 = month(개봉일), 
      일 = day(개봉일), .before = 3) |> 
    select(-c(개봉일, 
              `매출액\n점유율`,국적)) -> kobis2019_2select)


#
(kobis2019_2select |> 
    filter(관객수 > 1000) |> 
    drop_na(영화명) -> kobis2019_3under1000)


#write
kobis2019_3under1000 |> 
  write_csv("./2th/5st/excel/top1000/KOBIS_2019_c1000.xlsx")


#2018 ------------------------------------------------------
(read_excel("./2th/5st/excel/KOBIS_2018.xlsx",
            skip = 4) -> kobis2019_1excel)

#
(kobis2018_1excel |> 
    mutate(
      연도 = year(개봉일),
      월 = month(개봉일), 
      일 = day(개봉일), .before = 3) |> 
    select(-c(개봉일, 
              `매출액\n점유율`,국적)) -> kobis2018_2select)


#
(kobis2018_2select |> 
    filter(관객수 > 1000) |> 
    drop_na(영화명) -> kobis2018_3under1000)


#write
kobis2018_3under1000 |> 
  write_csv("./2th/5st/excel/top1000/KOBIS_2018_c1000.xlsx")



# ==========================================================
# ----------------------------------------------------------
# 2018년
(read_excel("./2th/5st/excel/KOBIS_2018.xlsx",
            skip = 4) -> kobis2018_1excel)

# 2019년
(read_excel("./2th/5st/excel/KOBIS_2019.xlsx",
            skip = 4) -> kobis2019_1excel)

# 2020년
(read_excel("./2th/5st/excel/KOBIS_2020.xlsx",
            skip = 4) -> kobis2020_1excel)

# 2021년
(read_excel("./2th/5st/excel/KOBIS_2021.xlsx",
            skip = 4) -> kobis2021_1excel)

# 2022
(read_excel("./2th/5st/excel/KOBIS_2022.xlsx",
            skip = 4) -> kobis2022_1excel)


#write_csv --------------------------------------------
kobis2018_1excel |> 
  write_csv("./2th/5st/excel/KOBIS_2018_edit.xlsx")

kobis2019_1excel |> 
  write_csv("./2th/5st/excel/KOBIS_2019_edit.xlsx")

kobis2020_1excel |> 
  write_csv("./2th/5st/excel/KOBIS_2020_edit.xlsx")

kobis2021_1excel |> 
  write_csv("./2th/5st/excel/KOBIS_2021_edit.xlsx")

kobis2022_1excel |> 
  write_csv("./2th/5st/excel/KOBIS_2022_edit.xlsx")

