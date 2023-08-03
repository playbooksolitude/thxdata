#23-0730 sun 14:00 2회차 오프라인

library(tidyverse)



ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ
    , y = hwy)
    , color = "blue")


base::Filter()
dplyr::filter()



mpg |> count(manufacturer,drv) |> 
  ggplot(aes(x = manufacturer,
    y = n)) +
  geom_bar(stat = "identity", aes(fill=drv)) +
  facet_wrap(.~drv, scale = "free") +
  coord_flip()

geom_bar(stat = "identity")


#
ggplot(data=mpg)+
  geom_point(mapping=aes(x=class, y=drv), 
    alpha = .01)

ggplot(data=mpg)+
  geom_jitter(mapping=aes(x=class, y=drv), 
    width = .5)

#
ggplot(data=mpg)+  
  geom_point(mapping=aes(x=displ, y=hwy))+  
  geom_smooth(mapping=aes(x=displ,y=hwy), 
    se = F, method = 'lm')

#
ggplot(data=mpg)+  
  geom_point(mapping=aes(x=displ, y=hwy))+  
  geom_smooth(mapping=aes(x=displ,y=hwy))

#
ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth()

#
mpg
str(mpg)
str(mpg)
glimpse(mpg)
summary(mpg) #기술통계

#
ggplot(data = mpg) +
  
  geom_point(mapping = aes(x = displ, y = hwy)) +
  
  facet_wrap(~ class, nrow = 2)


ggplot(data=mpg, 
  mapping=aes(x=displ, y=hwy, color=drv)) + 
  geom_point(show.legend = F) + 
  geom_smooth(se=F, show.legend = F)


#
mpg |>
  
  count(manufacturer, drv, name = "n") |>
  
  group_by(manufacturer) |>
  
  mutate(total_n = sum(n)) |>
  
  ggplot(aes(x = manufacturer, y = n, fill = drv)) +
  
  geom_bar(stat = "identity") +
  
  geom_text(aes(label = n), 
    position = position_stack(vjust = 0.5), size = 3) +
  
  geom_text(aes(label = total_n, y = total_n + 2), 
    vjust = -0.5, size = 3) +
  
  ylim(0,40)


# stat, identity
mpg #x = manu, y = cyl
ggplot(data = mpg,
  aes(x = manufacturer, 
    y = cyl)) +
  geom_point()

#1 mpg dataset
mpg

#2 mpg 제조사별 카운트
mpg |> count(manufacturer, sort = T)

# mpg 제조사별 막대그래프
mpg |> 
  count(manufacturer, sort = T) |> 
  ggplot() +
  geom_bar(aes(x = manufacturer, 
    y = n), 
    stat = "identity")

#
mpg
ggplot(data = mpg, 
  aes(x = manufacturer, 
    y = stat(count))) +
  geom_bar(stat = "count")

# 함수의 인수를 보여주는 함수
args(geom_bar)

#정렬
mpg |> 
  count(manufacturer, sort = T) |> 
  ggplot() +
  geom_bar(aes(x = manufacturer |> 
      fct_reorder(n), 
    y = n), 
    stat = "identity")

#정렬 내림 차순
mpg |> 
  count(manufacturer, sort = T) |> 
  ggplot() +
  geom_bar(aes(x = manufacturer |> 
      fct_reorder(desc(n)), 
    y = n), 
    stat = "identity")

#
mpg
mpg |> count(manufacturer) |> 
  ggplot() + 
  geom_bar(aes(x = manufacturer |> 
      fct_reorder(desc(n)), 
    y = n), stat = "identity") +
  labs(x = "manu", y = "nnnn") +
  coord_flip()

