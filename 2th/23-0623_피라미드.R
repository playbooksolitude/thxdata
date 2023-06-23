#23-0623 fri 09:31

#
library(tidyverse)
library(showtext)
showtext_auto()


#1
getwd()
(read_tsv("../thxdata/2th/files/people_2021_google.tsv", 
          skip = 1) -> people1_tsv)



#2 평균연령 등 제외
people1_tsv |> select("연령별", "내국인_남자(명)", "내국인_여자(명)") |> 
  rename(내국인_남자 = 2,
         내국인_여자 = 3) |> print(n = Inf)

(people1_tsv |> select("연령별", "내국인_남자(명)", "내국인_여자(명)") |> 
  rename(남자 = 2,
         여자 = 3) |> slice(2:22) -> people2_rename)



#3 pivot
(people2_rename |> pivot_longer(
  cols = !연령별,
  names_to = "성별",
  values_to = "인구"
) -> people3_pivot)



#4 성별에 -1 곱하기
(people3_pivot |> 
  mutate(인구편집 = if_else(성별 == "여자",
                        인구,
                        -1 * 인구),
         num = row_number()) -> people4_편집)


people4_편집 |> print(n = Inf)



#5 그래프 #if_else
people4_편집 |> 
  ggplot(aes(연령별 |> fct_reorder(num), 
             인구편집)) +
  geom_bar(stat = "identity",
           fill = if_else(people4_편집$성별 == "남자", "blue", "red")) +
  coord_flip() +
  geom_label(aes(label = round(인구/(1000),0))) +
  theme(axis.title = element_blank(),
        axis.text.x = element_blank(),
                legend.position = "top")


# 6 그래프 #scale_fill_manual
people4_편집 |> 
  ggplot(aes(연령별 |> fct_reorder(num), 
             인구편집)) +
  geom_bar(stat = "identity", aes(fill = 성별)) +
  coord_flip() +
  geom_label(aes(label = round(인구/(1000),0))) +
  theme(axis.title = element_blank(),
        axis.text.x = element_blank(),
        axis.text.y = element_text(size = 15),
        legend.position = "top",
        axis.ticks = element_blank()) +
  scale_fill_manual(values = c("남자" = "blue",
                               "여자" = "red")) +
  labs(title = "2021년 한국 연령/성별 인구분포")



#7 세로 막대 그래프
people4_편집 |> 
  ggplot(aes(연령별 |> fct_reorder(num), 
             인구/1000,
             fill = 성별)) +
  geom_bar(stat = "identity",
           position = "dodge") +
  scale_fill_manual(values = c("여자" = "red", "남자" = "blue")) +
  theme(axis.title = element_blank(),
        axis.text.x = element_text(angle = 45))
  



