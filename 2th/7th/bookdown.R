#23-0829 tue 23:09 #bookdwon

#
bookdown::html_book()
?bookdown
install.packages("pak")
library(pak)

pak::pak('rstudio/bookdown')

ggplot(mpg) + 
  geom_bar(aes(y = manufacturer))