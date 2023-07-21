#23-0722 sat 00:33

#
library(tidyverse)

mpg
mpg |> count(manufacturer)
mpg |> count(manufacturer, class) |> arrange(manufacturer)

# without class
mpg |> count(manufacturer) |> 
  ggplot(aes(x = manufacturer |> fct_reorder(n), 
             y = n)) +
  geom_bar(stat = "identity") +
  theme(axis.text = element_text(size = 15),
        axis.title = element_blank()) +
  coord_flip() +
  geom_label(aes(label = n)) 
 
# filter
mpg |> filter(manufacturer %in% c("ford"),
              class == "pickup")

#
mpg |> count(manufacturer, class) |> 
  ggplot(aes(x = manufacturer |> fct_reorder(n), 
             y = n)) +
  geom_bar(stat = "identity") +
  theme(axis.text = element_text(size = 15),
        axis.title = element_blank()) +
  coord_flip() +
  geom_label(aes(label = n),
             position = position_stack(vjust = .5)) +
  facet_wrap(.~class, scales = "free", ncol = 4) +
  theme(strip.text = element_text(size = 15))

bbc_style

#data changed
mpg |> count(manufacturer, class) |> 
  ggplot(aes(x = class |> fct_reorder(n), 
             y = n)) +
  geom_bar(stat = "identity") +
  theme(axis.text = element_text(size = 15),
        axis.title = element_blank()) +
  coord_flip() +
  geom_label(aes(label = n)) +
  facet_wrap(.~manufacturer, scales = "free")

#table
table(mpg$model) |> as.data.frame()
