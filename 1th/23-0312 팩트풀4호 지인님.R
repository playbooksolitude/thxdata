#23-0312 sun 18:37 4호 팩트풀니스 그래프

#
library(tidyverse)
library(bbplot)

getwd()
read_csv("./data_source/material footprint.csv") -> footprint

#pre-processing
footprint |> rename(
  Material_footprint = 3
) -> footprint2_rename

#컬러를 입히기 위해 데이터 테이블 변경
pivot_longer(footprint2_rename, 
             cols = !Year,
             names_to = "type",
             values_to = "value") -> footprint3_pivot

#그래프
ggplot(footprint3_pivot,
       aes(x = Year,
           y = value, 
           fill = type, 
           color = type)) +
  geom_line(size = 2) +
  coord_cartesian(ylim = c(100,180)) +
  bbc_style()

# ------------------------------------------- 두번째 그래프
read_csv("./data_source/capita.csv") -> caita
caita

(pivot_longer(
  caita,
  cols = !Income,
  names_to = "Year",
  values_to = "Value"
) -> caita2_pivot)

(caita2_pivot |> filter(!is.na(Income)) -> caita3_narm) #na 제거
c("2000" = "#E9D4AF","2017" = "#C07820") -> c_color     #color 예쁘게


#NA 제거 전 #caita2_pivot
ggplot(data = caita2_pivot,
       aes(x = Income, 
           y = Value, fill = Year)) +
  geom_bar(stat = "identity",
           position = "dodge") +
  coord_cartesian(ylim = c(0,30)) +
  coord_flip() +
  scale_fill_manual(values = c_color) +
  bbc_style() +
  geom_text(aes(label = round(Value,1)),
            position = position_dodge(width = 1), hjust = 1.2,
            size = 5)
  
#NA 제거 후 #caita3_narm
ggplot(data = caita3_narm,
       aes(x = Income |> fct_reorder(desc(Income)),
           y = Value, fill = Year)) +
  geom_bar(stat = "identity",
           position = "dodge") +
  coord_cartesian(ylim = c(0,30)) +
  coord_flip() +
  scale_fill_manual(values = c_color) +
  bbc_style() +
  geom_text(aes(label = round(Value,1)),
            position = position_dodge(width = 1), hjust = 1.2,
            size = 5)


