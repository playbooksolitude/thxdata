#23-0811 thu 11

#
library(tidyverse)
library(bbplot)

#
read_csv("./2th/4st/thxdata - KOBIS_23-01-06.csv", 
  skip = 4) -> kobis_1csv

#2
kobis_1csv$순위 |> as.numeric() -> kobis_1csv$순위
kobis_1csv |> glimpse()

kobis_1csv |> mutate(
  연도 = year(개봉일),
  월 = month(개봉일),
  일 = day(개봉일), .before = 3
) |> select(-c(`매출액\n점유율`, 개봉일)) -> kobis_2날짜
  

#
kobis_2날짜 |> drop_na(순위)
kobis_2날짜 |> filter(is.na(순위))
kobis_2날짜 |> tail()

# na check
colSums(is.na(kobis_2날짜)) |> as.data.frame()
kobis_2날짜 |> filter(is.na(연도))

kobis_2날짜 |> 
  ggplot(aes(x = 순위, y = 누적매출액, fill = 누적매출액)) +
  geom_tile()

#
glimpse(kobis_2날짜)

kobis_2날짜 |> filter(순위 < 101) |> 
  ggplot(aes(x = 순위, y = 대표국적, fill = 관객수)) +
  geom_tile() +
  scale_fill_gradient(low = "grey", high = "red")

#
table(kobis_2날짜$등급) |> as.data.frame()


#
kobis_2날짜 |> 
  filter(순위 < 31, 연도 == "2023") |> 
  ggplot(aes(x = 순위, y = as.factor(월), fill = 누적관객수)) +
  geom_tile() +
  geom_text(aes(label = round(누적관객수/10000,0)), color = "white")


#
kobis_2날짜 |> filter(순위 < 21) |> 
  ggplot(aes(x = 영화명 |> fct_reorder(desc(순위)), 
    y = 매출액)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  labs(y = "순위", x = "영화명")















