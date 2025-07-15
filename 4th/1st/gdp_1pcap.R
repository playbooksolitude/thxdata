#25-0624 

library(tidyverse)
read_csv("./4th/files/lex.csv") -> life_1exp

life_1exp |> 
  #colnames()
  select(1,208:256) -> life_2exp

life_2exp

read_csv("./4th/files/gdp_pcap (1).csv") -> gdp_1pcap
gdp_1pcap |> 
  #colnames()
  select(1,167:216) -> gdp_2pcap

#
gdp_2pcap |> 
  distinct(country) |> 
  arrange(country) |> 
  print(n = Inf)

#
gdp_2pcap |> 
  filter(country %in% c('South Korea'))

gdp_2pcap |> 
  pivot_longer(cols = !country, names_to = 'year', values_to = 'value') |> 
  filter(country %in% c('Japan', 'South Korea'))

#
gdp_2pcap |> 
  pivot_longer(cols = !country, names_to = 'year', values_to = 'value') |> 
  filter(country %in% c('South Korea')) |> 
  ggplot(aes(x = year, y = value, color = country)) +
  geom_point()

gdp_2pcap |> 
  pivot_longer(cols = !country, names_to = 'year', values_to = 'value') |> 
  filter(country %in% c('South Korea')) |> 
  print(n = Inf)

#gdp_전처리 ----
gdp_2pcap |> 
  pivot_longer(cols = !country, names_to = 'year', values_to = 'value') |> 
  #filter(country %in% c('South Korea')) |> 
  mutate(value2 = parse_number(value), 
         value3 = ifelse(value2 < 1000, value2 * 1000, value2), 
         value4 = value3 / 1000) -> gdp_3pivot
  #print(n = Inf)

gdp_3pivot  |> 
  filter(country %in% c('South Korea', 'Japan', 'North Korea')) |> 
  ggplot(aes(x = year, y = value4, color = country)) +
  geom_point() +
  scale_x_discrete(labels = c(1970, 1980, 1990, 2000, 2010), 
                   breaks = c(1970, 1980, 1990, 2000, 2010)) +
  ggtitle(label = 'gdp_pcap', subtitle = '$1,000') +
  theme(legend.position = 'top') +
  bbplot::bbc_style() 
  
  
