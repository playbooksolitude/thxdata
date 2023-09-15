#23-0915 fri 09:02

#
library(tidyverse)
library(googlesheets4)

#1
read_sheet("https://docs.google.com/spreadsheets/d/1pAcNs4HYfD8ttGwpKPi0mPhf3KK7EtMQrczkiC2MIHw/edit#gid=100333345",
           sheet = "설문지 응답 시트1") -> thx_1sheet


  ##
thx_1sheet |> dim()        #13 * 17
thx_1sheet |> glimpse()
thx_1sheet |> view()


#2
(thx_1sheet |> slice(-1) -> thx_2slice)     #12 * 17


#3 제목
thx_2slice |> colnames()
thx_2slice |> 
  rename("스터디방식" = 2) |> colnames()

#
thx_2slice |> 
  rename("스터디방식입니다" = "설문조사는 무기명으로 하며, 결과는 카페에 공유해 다함께 봅니다." ) |> colnames()

#
thx_2slice |> 
  rename("스터디방식" = 2,
         "목표" = 3,
         "자기평가" = 4,
         "실력과역량" = 5,
         "태도와자세" = 6,
         "공부계획" = 7,
         "시작전과비교" = 8,
         "소득" = 9,
         "공부횟수" = 10,
         "총평" = 11,
         "장점" = 12,
         "개선점" = 13,
         StudyWithMe = 14,
         미니프로젝트 = 15) |> colnames()

#3
thx_2slice |> 
  rename("스터디방식" = 2,
         "목표" = 3,
         "자기평가" = 4,
         "실력과역량" = 5,
         "태도와자세" = 6,
         "공부계획" = 7,
         "시작전과비교" = 8,
         "소득" = 9,
         "공부횟수" = 10,
         "총평" = 11,
         "장점" = 12,
         "개선점" = 13,
         StudyWithMe = 14,
         미니프로젝트 = 15) -> thx_3rename

#ifelse
ifelse(thx_3rename$스터디방식 == "오프라인 스터디 참여",
       "오프라인", "온라인") -> thx_3rename$스터디방식
thx_3rename


#4
#thx_3rename |> select(-1)
(thx_3rename[,2:15] -> thx_4index)


#5
thx_4index |> mutate(
  num = row_number(), .before = 1) -> thx_5number


#
thx_5number |> 
  pivot_longer(cols = c(목표:미니프로젝트),
               names_to = "구분",
               values_to = "값") #|> view()


#6
(thx_5number |> 
  pivot_longer(cols = c(목표:미니프로젝트),
               names_to = "구분",
               values_to = "값") -> thx_6pivot)

#parse_number(thx_6pivot$값) |> view()
             
#
# thx_6pivot |> 
#   mutate(value = parse_number(thx_6pivot$값)) |> view()


#7
(thx_6pivot |> 
  mutate(value = parse_number(thx_6pivot$값)) -> thx_7tidy)

#
thx_7tidy |> 
  filter(구분 == "총평") |> 
  ggplot(aes(x = as_factor(num), 
             y = value)) +
  geom_bar(stat = "identity") 


# ----------------------------------------------------------
library(showtext)  
showtext_auto()

thx_7tidy |> 
  filter(구분 == "총평") |> 
  ggplot(aes(x = as_factor(num), 
             y = value)) +
  geom_bar(stat = "identity") +
  labs(x = "참여 번호", y = "평가 점수", 
       title = "THX 2기 스터디 설문조사",
       subtitle = "스터디 평가")
  


#8
thx_7tidy |> filter(
  구분 == "소득") |> 
  separate(col = 값, 
           into = c("소득1", "소득2", "소득3", "소득4", "소득5"), 
           sep = ", ", remove = T) |> 
  pivot_longer(cols = c(소득1:소득5),
               names_to = "얻은것",
               values_to = "값") |> 
  drop_na(값) -> thx_8pivot_dropna
  
thx_8pivot_dropna

#
library(wordcloud)
(thx_8pivot_dropna |> 
  count(값) -> thx_9wordcloud)


#
wordcloud(words = thx_9wordcloud$값,
          freq = thx_9wordcloud$n,
          scale = c(2,.5), min.freq = 1,
          random.order = F, 
          random.color = T,
          colors = brewer.pal(name = "Dark2", 8))


#10
library(tidytext)

#
extractNoun(text$value)
text |> 
  unnest_tokens(input = value,
                output = words,
                token = extractNoun)

#8_edit
extractNoun(thx_8pivot_dropna$값)
(thx_8pivot_dropna$값 |> as_tibble() -> thx_8koNLP)


(thx_8koNLP |> 
  unnest_tokens(input = value,
                output = words,
                token = extractNoun) |> 
  count(words) -> thx_8koNLP2)

#
thx_8koNLP2 |> 
  filter(str_count(thx_8koNLP2$words) > 1) |> 
  with(wordcloud(words = words, freq = n, min.freq = 2,
                 random.color = T, random.order = F,
                 colors = brewer.pal("Dark2", n = 8)))
  

# --------------------------------------------------------
thx_7tidy |> 
  filter(구분 == "자기평가") |> 
  ggplot(aes(x = factor(num), y = value)) +
  geom_bar(aes(fill = 스터디방식), 
           stat = "identity", 
           position = "dodge")



















