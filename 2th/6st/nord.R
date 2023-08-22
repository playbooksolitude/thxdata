#23-0822 tues 19:26

#
library(nord)


#
mpg |> count(manufacturer, trans, sort = T) |> 
  ggplot(aes(x = manufacturer, y = n, fill = trans)) +
  geom_bar(stat = "identity", position = "stack") +
  scale_fill_nord(palette = "victory_bonds", reverse = T) #+
  geom_text(aes(label = n),
            position = position_stack(vjust = .5)) +
  facet_wrap(.~trans, scales = "free") +
  coord_flip() +
  #theme_void() +
  theme(legend.position = "none")

nord_palettes
nord_show_palette("afternoon_prarie")

?nord

#
image(volcano, col = nord("aurora", 5))
image(volcano, col = nord("aurora", 15))
image(volcano, col = nord("aurora", 25))

image(volcano, col = nord("baie_mouton", 5))


#
library(nord)
viridis_pal()
viridis.map
?viridis

#
library(colorspace)
colorspace::hcl_palettes(plot = T)

#