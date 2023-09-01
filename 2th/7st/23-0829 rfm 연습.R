#23-0422 sat

#
library(tidyverse)
library(rfm)
library(bbplot)
library(showtext)
showtext_auto()

#
rfm_data_customer |> 
  count(cut_width(recency_days, 30,boundary = 0)) |> 
  mutate(num = row_number(), .before = 1, 
         num = num * 30) |> 
  ggplot(aes(x = num, y = n)) +
  geom_point() +
  geom_line() +
  annotate(geom = "rect", 
    xmin = c(250, 300, 350, 400,450), 
    ymin = -Inf, 
    xmax = 500, 
    ymax = c(2500,3000,3500,4000,4500),
    alpha = .2, fill = "blue") +
  annotate(geom = "text", 
    x = 275, 
    y = 2500, 
    label = "text", 
    size = 7)
  
#
example("annotate")

# 
  ggplot(data = rfm_data_customer) +
  geom_point(aes(x = recency_days, 
    y = number_of_orders)) +
  annotate(geom = "rect", 
    xmin = 750, 
    ymin = 0, 
    xmax = Inf, 
    ymax = 5, 
    alpha = .3, 
    fill = "blue")
  
#
rfm_data_customer |> mutate(
  vip3 = number_of_orders/10,
  vip2 = number_of_orders/5,
  vip1 = number_of_orders/3
) |> filter(vip3 > 2)

range(rfm_data_customer$number_of_orders)

#
rfm_data_customer
rfm_data_customer |> filter(recency_days < 31)
rfm_data_customer |> filter(recency_days > 30, 
                      recency_days < 61)
rfm_data_customer |> 
  count(cut_width(recency_days,30, 
    boundary = 0, labels = F)) |> 
  rename("기간" = 1, "users" = 2) |> 
  mutate(a = 30,
         days = 기간*a) |> select(days, users) |> 
  mutate(cum_users = cumsum(users),
         pop = cum_users/last(cum_users)*100) |> 
  rename("기간"= 1, "고객수" = 2, 
         "누적고객수" = 3, "비율" = 4) -> rfm_cus_cum

# 기간별 고객수 분포
ggplot(data = rfm_cus_cum, 
       aes(x = as.factor(기간), y = 고객수)) + 
  geom_bar(stat = "identity") + geom_label(aes(label = 고객수)) +
  bbc_style() +
  labs(title = "RFM 분석 예시: 가입기간별 고객수 분포", 
       subtitle = "X축 : 회원 가입일, Y축 고객수 ")

#
ggplot(data = rfm_cus_cum, 
       aes(x = as.factor(기간), 
           y = 누적고객수)) +
  geom_bar(stat = "identity") + 
  geom_label(aes(label = 누적고객수)) +
  bbc_style() #+

#
rfm_cus_cum

#
ggplot(data = rfm_cus_cum, 
       aes(x = as.factor(기간))) +
  geom_bar(aes(y = 고객수), stat = "identity") + 
  geom_line(aes(y = 누적고객수), group = 1) +
  bbc_style() 

#비율로 보기
ggplot(data = rfm_cus_cum, 
       aes(x = as.factor(기간))) +
  geom_bar(aes(y = 비율), stat = "identity") + 
  geom_line(aes(y = 비율), group = 1, 
    size = 2, color = "grey") +
  bbc_style() 


#
ggplot(data = rfm_data_customer, aes(x = as.factor(number_of_orders))) + 
  geom_point(stat = "count") + 
  geom_label(aes(label = after_stat(count)), 
    stat = "count") +
  bbc_style() +
  labs(title = "RFM 분석 예시: 구매건수별 고객수", 
       subtitle = "X축 구매건수, Y축 고객수")


rfm_data_customer |> 
  ggplot(aes(recency_days, 
    number_of_orders)) + 
  geom_point(stat = "identity",
             color = "#588195",
             alpha = .3) +
  bbc_style() +
  labs(title = "RFM 분석 예시: 가입기간 * 구매건수 추세", 
       subtitle = " ")

rfm_data_customer

#