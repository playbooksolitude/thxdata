#23-0814 mon 17:03

#
library(tidyverse)
library(rfm)

#
rfm_data_customer
rfm_data_orders
rfm_data_orders |> 
  count(revenue)

rfm_data_customer |> count(number_of_orders)

# cut width ------------------------------------------------
# center = .5, 중심으로 
# width = 1    좌우간격


# labels
rfm_data_customer |> 
  count(
  cut_width(number_of_orders,
            center = .5,
            width = 1, 
            closed = "left",
            labels = F)) |> 
  rename(number_of_orders = 1)

#
rfm_data_customer |> 
  count(
    cut_width(recency_days,
              center = 50,
              width = 100, 
              closed = "right", 
              labels = F)) |> 
  rename(recency_days = 1) 


#
rfm_data_customer |> count(number_of_orders) |> print(n = Inf)
rfm_data_customer |> count(recency_days) |> 
  distinct() |> tail()

rfm_data_orders
rfm_data_customer |> 
mutate(grade = if_else(number_of_orders < 6, "L1",
                 if_else(number_of_orders < 11, "L2",
                 if_else(number_of_orders < 16, "L3", 
                 if_else(number_of_orders < 21, "L4", "L5"))))) |> 
  count(number_of_orders, grade) |> 
  ggplot(aes(x = grade, y = as.factor(number_of_orders), 
             fill = n)) +
  geom_tile()


#
#지수 표현 처리 필요
rfm_data_customer |> 
  count(
    cut_width(recency_days, center = 15, width = 30)) |> 
  print(n = Inf)


#
rfm_data_customer |> 
  count(
    cut_width(recency_days, center = 15, width = 30)) |> 
  mutate(num = row_number() * 30) |> print(n = Inf)