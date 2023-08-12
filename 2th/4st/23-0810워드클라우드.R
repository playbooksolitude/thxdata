#23-0810 thu 21:35

#
library(palmerpenguins)
library(tidyverse)
library(tidytext)
library(janeaustenr)
library(wordcloud)

#
janeaustenr::sensesensibility
janeaustenr::austen_books()

# snese & sensibility
austen_books() |> 
  filter(book %in% c("Sense & Sensibility")) -> temp_1

# 
temp_1 |> print(n = 100)
temp_1 |> unnest_tokens(word, text) |> 
  count(word, sort = T) |> 
  anti_join(stop_words, by = "word") |> 
  with(
    wordcloud(word, 
              freq = n,
              max.words = 500,
              min.freq = 100,
              colors = ))

#
penguins |> drop_na(bill_length_mm)
penguins |> filter(is.na(bill_length_mm)) #2
penguins |> filter(!is.na(bill_length_mm)) #342

penguins |> view()
penguins |> drop_na(sex, bill_length_mm)

#
penguins |> 
  gt::gt()

colSums(is.na(penguins)) |> as.data.frame()
colSums(is.na(penguins)) |> table()
colSums(is.na(penguins)) |> data.frame()
