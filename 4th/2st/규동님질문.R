#25-0715 규동님 질문

library(tidyverse)


#참고
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + #그래프
  geom_point(aes(color = class)) +                      #산점도
  geom_smooth()                                   #회귀선
# mpg 데이터로 그래프를 그려라, x 축은 displ, y축은 hwy
# 산점도 그래프고, class별로 색깔을 다르게 해라
# 회귀선도 그려라. 표준오차는 표시하지 마라 (T 혹은 F)


#교재
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth(se = F, 
              data = filter(mpg, class == 'subcompact') #class가 subcompact인 것만 선으로 그려라
  )
# mpg 데이터로 그래프를 그려라, x 축은 displ, y축은 hwy
# 산점도 그래프고, class별로 색깔을 다르게 해라
# 회귀선도 그려라. 표준오차는 표시하지 마라 (T 혹은 F)
#회귀선에 사용할 데이터는 mpg 데이터셋에서 class가 'subcompact'인 것만 사용해라

#비교2
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_smooth(se = F, data = filter(mpg, class == 'subcompact'))

data()
