#23-0815 화 22:31

#
library(tidyverse)
library(readxl)
library(showtext)
showtext_auto()
data()

#1 불러오기
(read_excel("./2th/5st/excel/KOBIS_2022.xlsx",
           skip = 4) -> kobis2022_1excel)

#2 구조파악
kobis2022_1excel |> glimpse()

(kobis2022_1excel |> 
  mutate(
    연도 = year(개봉일),
    월 = month(개봉일), 
    일 = day(개봉일), .before = 3) |> 
  select(-c(개봉일, 
            `매출액\n점유율`,국적)) -> kobis2022_2select)


#3 adult 유의미한 콘텐츠 구분
kobis2022_2select |> head()
kobis2022_2select |> 
  slice(3990:4000) |>
  select(1:9)
kobis2022_2select |> dim()


(kobis2022_2select |> 
  filter(관객수 > 1000) -> kobis2022_3under) #5004 -> #774



# ----------------------------------------------------------


kobis2022_3under |> 
  drop_na(월) |> 
  count(대표국적, 월, sort = T) |> 
  ggplot(aes(x= 대표국적, y = n)) +
  geom_bar(stat = "identity") +
  facet_wrap(.~월, scales = "free") +
  coord_flip()

#
kobis2022_3under |> 
  drop_na(월) |> 
  count(대표국적, 월, sort = T) |> 
  ggplot(aes(x= 대표국적, y = n)) +
  geom_bar(stat = "identity") +
  facet_wrap(.~월) +
  coord_flip()

#
kobis2022_3under |> 
  filter(연도 == "2022") |> 
  drop_na(월) |> 
  count(대표국적, 월, sort = T) |> 
  ggplot(aes(x= 대표국적, y = 월, fill = n)) +
  geom_tile() +
  geom_text(aes(label = n)) +
  scale_fill_gradient(low = "grey", high = "red") +
  scale_y_continuous(breaks = c(1:12)) +
  theme(axis.title = element_blank(),
        panel.background = element_blank()) +
  coord_flip()

#------------------------------
#
library(gt)
kobis2022_3under |> 
  filter(연도 == "2022") |> 
  drop_na(월) |> 
  count(대표국적, 월) |> 
  arrange(월) |> 
  pivot_wider(
    names_from = 월,
    values_from = n
  ) |> gt()

#  매출액
library(treemapify)
kobis2022_3under |> filter(순위 < 21) |> 
  ggplot(aes(area = 매출액, 
             fill = 대표국적, 
             label = 영화명,
             subgroup = 대표국적,
             subgroup2 = 
               paste(round(관객수/10000,0),"만명"))) +
  geom_treemap() +
  geom_treemap_text(color = "white") +
  geom_treemap_subgroup_text(place = "centre",
                             grow = T,
                             min.size = 0,
                             alpha = .2,
                             fontface = "italic") +
  theme(legend.position = "none") +
  geom_treemap_subgroup2_text(color = "white", size = 12,
                              place = "center")


#매출액 표
kobis2022_3under |> filter(순위 < 21) |> 
  group_by(대표국적) |> 
  summarise(sum = sum(매출액)) |> 
  mutate(
    매출액합계 = sum(sum),
    비율 = round(sum / 매출액합계,3) * 100)


#  관객수
kobis2022_3under |> filter(순위 < 21) |> 
  ggplot(aes(area = 관객수, 
             fill = 대표국적, 
             label = 영화명,
             subgroup = 대표국적,
             subgroup2 = 
               paste(round(관객수/10000,0), "만명"))) +
  geom_treemap(alpha = .5) +
  geom_treemap_text(color = "white") +
  geom_treemap_subgroup_text(place = "centre",
                             grow = T,
                             min.size = 0,
                             alpha = .2,
                             fontface = "italic") +
  theme(legend.position = "none") +
  geom_treemap_subgroup2_text(color = "white",size = 12,
                              place = "center") +
  scale_fill_manual(values =  
                       c("한국" = "blue", 
                         "미국" = "red"))

?geom_treemap_subgroup2_text()



# 관객수 표
kobis2022_3under |> filter(순위 < 21) |> 
  group_by(대표국적) |> 
  summarise(sum = sum(관객수)) |> mutate(
    관객수합계 = sum(sum),
    비율 = round(sum / 관객수합계,3) * 100
  )


#

G20
G20  |> 
  treemapify(aes(area = region, fill = country))

G20 |> mutate(num = row_number(), .before = 1) |> 
  ggplot(aes(area = gdp_mil_usd, fill = hdi,
             label = paste(num, country, hdi))) +
  geom_treemap() +
  geom_treemap_text(color = "white")

#
kobis2022_3under |> 
  filter(연도 != "2023") |> select(1:5)



# ----------------------------------------------------------
# 2018년
(read_excel("./2th/5st/excel/KOBIS_2018.xlsx",
            skip = 4) -> kobis2018_1excel)

# 2019년
(read_excel("./2th/5st/excel/KOBIS_2019.xlsx",
            skip = 4) -> kobis2019_1excel)

# 2020년
(read_excel("./2th/5st/excel/KOBIS_2020.xlsx",
            skip = 4) -> kobis2020_1excel)

# 2021년
(read_excel("./2th/5st/excel/KOBIS_2021.xlsx",
            skip = 4) -> kobis2021_1excel)



# colorspace -------------------------------------
install.packages("colorspace")
library(colorspace)

colorspace::hcl_palettes()
colorspace::hcl_palettes(plot = T)
colorspace::hcl_palettes(plot = T, type = "Qualitative")
colorspace::hcl_palettes(plot = T, 
                         type = "Qualitative",
                         palette = "Cold", 
                         n = 6)

colorspace::hcl_palettes(plot = T, 
                         type = "Qualitative",
                         palette = "Cold", 
                         n = 6)

#컬러코드를 알고 싶을 때
colorspace::qualitative_hcl(6, palette = "Dark 3")
colorspace::qualitative_hcl(n = 6, 
                            palette = "Cold")



library(palmerpenguins)
library(tidyverse)
penguins |> 
  drop_na() |> 
  ggplot(aes(x = species, 
             y = body_mass_g, 
             color = body_mass_g)) +
  geom_jitter(width = .2)



#
penguins |> 
  drop_na() |> 
  ggplot(aes(x = species, 
             y = body_mass_g, 
             color = body_mass_g)) +
  geom_jitter(width = .2) +
  colorspace::scale_color_continuous_sequential(
    palette = "Teal", begin = .1, end = .9)

hcl_palettes(plot = T, type = "Sequential")

penguins |> 
  drop_na() |> 
  ggplot(aes(x = species, 
             y = body_mass_g, 
             color = body_mass_g)) +
  geom_jitter(width = .2) +
  colorspace::scale_color_continuous_sequential(
    palette = "Teal", begin = .9, end = .1)


# 이산형
penguins |> 
  ggplot(aes(x = body_mass_g, fill = species)) +
  geom_histogram(bins = 10, color = "white") +
  scale_fill_discrete_qualitative(palette = "cold",
                                  alpha = .8, 
                                  order = c(2,3,1)) +
  labs(title = "colorspace")

hcl_palettes(plot = T)




















