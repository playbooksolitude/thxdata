#23-0822 tues 19:26

#
library(nord)


#
mpg |> count(manufacturer, trans, sort = T) |> 
  ggplot(aes(x = manufacturer, y = n, fill = trans)) +
  geom_bar(stat = "identity", position = "stack") +
  scale_fill_nord(palette = "afternoon_prarie") +
  geom_text(aes(label = n),
            position = position_stack(vjust = .5)) +
  facet_wrap(.~trans, scales = "free") +
  coord_flip() +
  #theme_void() +
  theme(legend.position = "none")


nord_palettes()

#
library(nord)
viridis_pal()
viridis.map
?viridis

#
library(colorspace)
colorspace::hcl_palettes(plot = T)