#23-0725 tue 11:15

#
library(tidyverse)
library(bbplot)
library(gt)

starwars
#퀴즈

#1 starwars
ggplot(data = starwars,
       aes(x = sex)) +
  geom_bar()

#2 ordering
ggplot(data = starwars,
       aes(x = sex |> fct_infreq(),
           y = after_stat(count))) +
  geom_bar()

#3 remove NA
starwars #87 
starwars |> filter(!is.na(starwars$sex)) |>  #83
  ggplot(
         aes(x = sex |> fct_infreq(),
             y = after_stat(count))) +
  geom_bar()

#4 label
starwars |> filter(!is.na(starwars$sex)) |>  #83
  ggplot(
    aes(x = sex |> fct_infreq(),
        y = after_stat(count))) +
  geom_bar() +
  geom_label(aes(label = after_stat(count)), stat = "count", 
             size = 5) +
  labs(x = "gender") 

#5
starwars |> filter(!is.na(starwars$sex)) |>  #83
  ggplot(
    aes(x = sex |> fct_infreq(),
        y = after_stat(count)
        )) +
  geom_bar() +
  geom_label(aes(label = after_stat(count)), 
             stat = "count", 
             size = 7) +
  labs(x = "gender") + # x축 이름 변경
  bbc_style() #bbplot()

#6 color
starwars |> filter(!is.na(starwars$sex)) |>  #83
  ggplot(
    aes(x = sex |> fct_infreq(),
        y = after_stat(count))) +
  geom_bar(aes(fill = sex), 
           alpha = .8,
           show.legend = F) +
  geom_label(aes(label = after_stat(count)), 
             stat = "count", 
             size = 7) +
  labs(x = "gender") +
  bbc_style() +
#  scale_fill_manual(values = mrc_c)
  scale_fill_manual(values = c(
    "male" = "blue",
    "female" = "red",
    "none" = "grey",
    "hermaphroditic" = "black")) +
  coord_cartesian(ylim = c(0,70))

# color mapping
mrc_c <- c(
  "male" = "#53af97", 
  "female" = "#cfae73",
  "none" = "#f57777",
  "hermaphroditic" = "#50bcff")

# data
data()


#7 distinct 
starwars |> distinct(sex)

  #7-1 relevel
starwars$sex |> as_factor() #Levels: male none female hermaphroditic

  #7-2 level 재정의
starwars$sex |> as_factor() |> 
  relevel("female", "male", "hermaphroditic", "none")

starwars$sex |> as_factor()  #check 

  #7-3 level 재정의 설정
starwars$sex |> as_factor() |> 
  relevel("female", "male", "hermaphroditic", "none") -> starwars$sex

starwars$sex |> as_factor()  #Levels: female male none hermaphroditic
starwars

  #7-4 ggplot, relevel
starwars
ggplot(data = starwars, 
       aes(x = sex |> fct_inorder(), 
           y = after_stat(count))) +
  geom_bar()


#8 pivot_wider
starwars |> count(gender, sex) |> gt()
starwars |> count(gender, sex) |> pivot_wider(
  names_from = sex,
  values_from = n) |> 
  gt()


