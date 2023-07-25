#23-0725 tue 11:15

#
library(tidyverse)
library(bbplot)

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
  geom_bar(aes(fill = sex), alpha = .7) +
  geom_label(aes(label = after_stat(count)), 
             stat = "count", 
             size = 5) +
  labs(x = "gender") +
  bbc_style() +
#  scale_fill_manual(values = mrc_c)
  scale_fill_manual(values = c(
    "male" = "blue",
    "female" = "red",
    "none" = "grey",
    "hermaphroditic" = "black"))


mrc_c <- c(
  "male" = "#53af97", 
  "female" = "#cfae73",
  "none" = "#f57777",
  "hermaphroditic" = "#50bcff")

data()
