#23-0808 tue 00:12

#
library(tidyverse)
install.packages("tidytext")
library(tidytext)
install.packages("wordcloud")
library(wordcloud)
install.packages("janeaustenr")
library(janeaustenr)

#
wordcloud::wordcloud()
janeaustenr::austen_books()
austen_books()
janeaustenr::sensesensibility
sensesensibility |> dim()
glimpse(sensesensibility)

#
austen_books() |> dim()
austen_books() |> count(book)
austen_books() |> print(n = 20)
austen_books() |> 
  filter(book == "Sense & Sensibility") -> tidy_austen

tidy_austen |> 
  unnest_tokens(word, text) -> tidy_2austen

tidy_2austen |> count(word, sort = T) |> 
  anti_join(stop_words) -> tidy_3austen

tidy_3austen |> with(wordcloud(words = word,
                  freq = n,
                  max.words = 50,
                  random.order = F))

#