#23-0515 mon 09:00

#
library(tidyverse)
library(tidytext)
#install.packages("multilinguer")
library(multilinguer)
#install_jdk()

#install.packages(c("stringr", "hash", "tau", "Sejong", 
#                   "RSQLite", "devtools"), type = "binary")

#install.packages("remotes")
remotes::install_github("haven-jeon/KoNLP",
                        upgrade = "never",
                        INSTALL_opts = c("--no-multiarch"))
library(KoNLP)
useNIADic()

#
tibble(
  value = c("대한민국은 민주공화이다.",
            "대한민국의 주권은 국민에게 있고, 모든 권력은 국민으로부터 나온다.")
) -> text

text
extractNoun(text$value)

text |> 
  unnest_tokens(input = value,
                output = words,
                token = extractNoun)
  
