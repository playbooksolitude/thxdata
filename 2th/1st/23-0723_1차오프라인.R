#23-0723 sun 15:30
# 테스트

# 땡쓰데이터 2기 1차 오프라인 스터디

# 1 패키지 다운로드 (설치)
# 실행 ctrl + Enter
# 실행 command + Enter
# 블럭으로 잡고 쌍따옴표
# 단축키 command + shift + m |>
# count()
# view()
# 인코딩

#1 설치
install.packages("tidyverse")    # 설치
library("tidyverse")             # 실행

#2 데이타셋
mpg
mpg |> ggplot(aes(x = manufacturer,
                  y = stat(count))) +
  geom_bar()

#after_stat(count)
mpg |> ggplot(aes(x = manufacturer,
                  y = after_stat(count))) +
  geom_bar()

# count
mpg |> count(manufacturer)
mpg |> count(manufacturer)

# count model
mpg |> count(model)
mpg |> count(model) |> view()
mpg |> count(model) #|> view()

# count manufacturer, model, drv
mpg |> count(manufacturer, model, drv)
mpg |> count(manufacturer, model, drv, sort = TRUE)

# 
mpg |> count(manufacturer, drv) |> 
  ggplot(aes(x = manufacturer,
             y = after_stat(count))) +
  geom_bar() +
  facet_wrap(.~drv, scale = "free", ncol = 1)

# 변경
mpg |> count(manufacturer, drv) |> 
  ggplot(aes(x = manufacturer,
             y = n)) +
  geom_bar(stat = "identity")


#
mpg |> count(manufacturer, drv) |> 
  ggplot(aes(x = manufacturer, 
             y = n)) +
  geom_bar(stat = "identity") +
  facet_wrap(.~drv, scale = "free") +
  coord_flip()
  



#
mpg |> count(manufacturer,drv) |> 
  ggplot(aes(x = manufacturer,
             y = after_stat(count()))) + 
           geom_bar() #+
           facet_wrap(.~drv,scale = "free", ncol = 1)

  
  