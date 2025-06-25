#23-1013 fri 

#
library(tidyverse)
library(readxl)
library(bbplot)
library(showtext)
showtext_auto()
#
read_excel("./mirae.xlsx") -> mirae
mirae |> view()
mirae |> colnames()

mirae |> 
  slice(1:19) -> mirae2

#
mirae |> 
  slice(1:19) |> 
  ggplot(aes(x = `법적인 성별`, y = stat(count))) +
  geom_bar() +
  bbc_style() +
  geom_label(aes(label = stat(count)), stat = "count", 
    size = 10)

#
mirae$활동지역
mirae |> 
  slice(1:19) |> 
  count(활동지역, 연령대) |> 
  ggplot(aes(x = 활동지역, y = 연령대, fill =n)) +
  geom_tile() +
  geom_text(aes(label = n), color = "white", size = 9)

mirae |> 
  slice(1:19) |> 
  rename(활동분야 = 23) |> 
  with(`활동분야`) |> 
  data.frame() |> 
  rename(활동분야 = 1) |> 
  group_by(활동분야) |> 
  summarise(n = n()) |> 
  ggplot(aes(x =활동분야 |> fct_reorder(n), 
    y = n)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  bbc_style() +
  geom_label(aes(label = n), size = 7)


#
mirae2 |> 
  rename(유입경로 = 3) |> 
  ggplot(aes(x = 유입경로, y = stat(count))) +
  geom_bar(stat = "count") +
  geom_label(aes(label = stat(count)), stat = "count", 
    size = 10) +
  labs(title = "유입경로") +
  bbc_style()

#
mirae2 |> view()
mirae2 |> 
  select(2, 6:14) |> 
  pivot_longer(cols = !1,
    names_to = "항목", 
    values_to = "값") -> mirae3

mirae3 |> 
  rename(분류 = 1) -> mirae4

mirae4 |> colnames()
mirae4 |> view()

mirae4 |> 
  group_by(항목, 값) |> 
  summarise(n = n()) |> 
  ggplot(aes(x = 항목, y = 값, fill = n)) +
  geom_tile() +
  geom_text(aes(label = n), color = "white") +
  scale_fill_gradient(low = "grey", high = "red") +
  facet_wrap(.~항목, scales = "free")
  
bbc_style
