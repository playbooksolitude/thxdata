#23-0811 #thu 10:30

#
library(tidyverse)
library(readxl)



# excel
getwd()
read_excel("./2th/4st/thxdata_kobis.xlsx",
  sheet = "KOBIS_2023-08-11",skip = 5) -> kobis_1csv
  #자료 구조형 오류

#  
kobis_1csv |> view()

# csv
thxdata - KOBIS_2023-08-11
# read_csv("./2th/4st/thxdata - KOBIS_2023-08-11.csv",
#   skip = 5) -> kobis_1csv

read_csv("./2th/4st/thxdata - KOBIS_2023-08-11.csv",
  skip = 6) -> kobis_1csv

#2 csv
kobis_1csv |> colnames()
kobis_1csv |> print(n = 20)

table(kobis_1csv$국적)
  #날짜 개봉일

kobis_1csv |> view()
kobis_1csv |> select(1:5)
kobis_1csv |> ymd("개봉일")
kobis_1csv |> as_datetime("개봉일")
lubridate::as_date()

kobis_1csv |> year("개봉일")
today()
now()

#
kobis_1csv |> separate(col = "개봉일", 
  into = c("연도", "월", "일"),
  sep = "-") -> kobis_2날짜

kobis_2날짜$매출액 |> as.numeric() -> kobis_2날짜$매출액
kobis_2날짜$누적매출액 |> as.numeric() -> kobis_2날짜$누적매출액
kobis_2날짜$관객수 |> as.numeric() -> kobis_2날짜$관객수
kobis_2날짜$누적관객수 |> as.numeric() -> kobis_2날짜$누적관객수
kobis_2날짜$스크린수 |> as.numeric() -> kobis_2날짜$스크린수
kobis_2날짜$상영횟수 |> as.numeric() -> kobis_2날짜$상영횟수
kobis_2날짜$순위 |> as.numeric() -> kobis_2날짜$순위
kobis_2날짜$연도 |> as.numeric() -> kobis_2날짜$연도
kobis_2날짜$월 |> as.numeric() -> kobis_2날짜$월
kobis_2날짜$일 |> as.numeric() -> kobis_2날짜$일
kobis_2날짜$`매출액\n점유율`

#
kobis_2날짜 |> glimpse()
kobis_2날짜 |> view()
kobis_2날짜 |> with(순위)


#3
kobis_1csv
kobis_2날짜 |> select(-7) -> kobis_3select


#4
kobis_3select |> 
  filter(누적관객수 > 10000) -> kobis_4_10000


#5 drop_na
kobis_4_10000 |> drop_na(영화명, 순위, 매출액) -> kobis_5tidy
kobis_4_10000 |> filter(is.na(영화명))


#
kobis_5tidy |> filter(순위 < 21) |> print(n = Inf)
kobis_5tidy |> print(n = 100)


#
kobis_1csv |> with(순위)









