#23-0915 fri 09:02

#
library(tidyverse)
#install_java("googlesheets4")
library(googlesheets4)

#1
read_sheet("https://docs.google.com/spreadsheets/d/1pAcNs4HYfD8ttGwpKPi0mPhf3KK7EtMQrczkiC2MIHw/edit#gid=100333345",
           sheet = "설문지 응답 시트1") -> thx_1sheet


  ##

thx_1sheet |> dim()        #13 * 17
thx_1sheet |> glimpse()
thx_1sheet #|> view()


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
# thx_2slice |> 
#   rename("스터디방식" = 2,
#          "스터디 목표" = 3,
#          "자신에대한 평가" = 4,
#          "실력과 역량" = 5,
#          "태도와 자세" = 6,
#          "공부 계획" = 7,
#          "시작전과 비교" = 8,
#          "소득" = 9,
#          "공부 횟수" = 10,
#          "스터디평가" = 11,
#          "장점" = 12,
#          "개선점" = 13,
#          StudyWithMe = 14,
#          "미니 프로젝트 참여" = 15) |> colnames()

#3
thx_2slice |> 
  rename("스터디방식" = 2,
         "목표" = 3,
         "목표 달성" = 4,
         "실력과 역량" = 5,
         "태도와 자세" = 6,
         "공부계획" = 7,
         "시작전과 비교" = 8,
         "소득" = 9,
         "공부횟수" = 10,
         "스터디평가" = 11,
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
# thx_4index |> mutate(
#   num = row_number(), .before = 1) -> thx_5number

letters

(thx_4index |> 
  mutate(
  num = letters[1:13], .before = 1) -> thx_5number)

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
  filter(구분 == "스터디평가") |> 
  ggplot(aes(x = as_factor(num), 
             y = value)) +
  geom_bar(stat = "identity") 


# ----------------------------------------------------------
library(showtext)  
showtext_auto()

thx_7tidy |> 
  filter(구분 == "스터디평가") |> 
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
           into = c("소득1", "소득2", "소득3", 
             "소득4", "소득5"), 
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
  with(wordcloud(words = words, 
    freq = n, 
    min.freq = 2,
    scale = c(6,1),
    random.color = T, 
    random.order = F,
    colors = brewer.pal("Dark2", n = 8)))

wordcloud()

# --------------------------------------------------------
library(nord)
nord::nord_palettes

thx_7tidy |> 
  filter(구분 %in% c("실력과 역량", "태도와 자세",
                   "목표 달성", "스터디평가")) |> 
  ggplot(aes(x = factor(num), y = value)) +
  geom_bar(aes(fill = 스터디방식), 
           stat = "identity") +
  facet_wrap(.~구분, ncol = 2)+
  scale_fill_nord(palette = "afternoon_prarie") +
  theme(legend.position = "top")


#온라인 vs 오프라인
thx_5number |> 
  colnames()

#
thx_5number |> 
  ggplot(aes(x = 목표 |> fct_reorder(목표))) +
  geom_bar() +
  coord_flip() +
  geom_label(aes(label = stat(count)), 
    stat = "count", size = 7) +
  theme(axis.title = element_blank())


#공부 계획
thx_5number |> 
  ggplot(aes(x = 공부계획)) +
  geom_bar() +
  coord_flip() +
  geom_label(aes(label = stat(count)), 
    stat = "count", size = 7) +
  theme(axis.title = element_blank()) +
  scale_y_continuous(breaks = c(0,2,4,6,8,10, 12))


#스터디는 시작전과 비교해?
thx_5number |> colnames()

thx_5number |> filter(str_c(`시작전과 비교`)>10) |> 
  ggplot(aes(x = `시작전과 비교`)) +
  geom_bar() +
  coord_flip() +
  geom_label(aes(label = stat(count)), 
    stat = "count", size = 7) #+
  theme(axis.title = element_blank()) +
  scale_y_continuous(breaks = c(0,2,4,6,8,10, 12))

library(gt)
thx_5number$`시작전과 비교` 
thx_5number |> 
  count(`시작전과 비교`) |> gt()


#
thx_5number |> colnames()

thx_5number |> 
ggplot(aes(x = 공부횟수)) +
  geom_bar() +
  coord_flip() +
  geom_label(aes(label = stat(count)), 
    stat = "count", size = 7) +
  theme(axis.title = element_blank())


#
thx_5number |> colnames()

thx_5number |> 
ggplot(aes(x = 장점)) +
  geom_bar() +
  coord_flip() +
  geom_label(aes(label = stat(count)), 
    stat = "count", size = 7) +
  theme(axis.title = element_blank()) #+
scale_y_continuous(breaks = c(0,2,4,6,8,10))


thx_5number |> 
  select(num, 장점) |> 
  separate(col = 장점, into = c("장점1", "장점2",
    "장점3", "장점4", "장점5"),
    sep = ", "
  ) |> 
  pivot_longer(cols = !num,
    names_to = "name", 
    values_to = "value") |> 
  drop_na(value) |> 
  ggplot(aes(x = value |> fct_infreq())) +
  geom_bar() +
  coord_flip() +
  geom_label(aes(label = stat(count)), 
    stat = "count", size = 7) +
  theme(axis.title = element_blank()) +
  scale_y_continuous(breaks = c(0,2,4,6,8,10)) +
  labs(title = "스터디 장점
    ")


#개선점
thx_5number |> colnames()

thx_5number |> 
  select(num, 개선점) |> 
  separate(col = 개선점, into = c("단점1", "단점2",
    "단점3", "댠점4", "단점5"),
    sep = ", "
  ) |> 
  pivot_longer(cols = !num,
    names_to = "name", 
    values_to = "value") |> 
  drop_na(value) |> gt()


thx_5number |> filter(num != "k") |> 
  select(num, 개선점) |> 
  separate(col = 개선점, into = c("단점1", "단점2",
    "단점3", "댠점4", "단점5"),
    sep = ", "
  ) |> 
  pivot_longer(cols = !num,
    names_to = "name", 
    values_to = "value") |> 
  drop_na(value) |> 
  ggplot(aes(x = value |> fct_infreq())) +
  geom_bar() +
  coord_flip() +
  geom_label(aes(label = stat(count)), 
    stat = "count", size = 7) +
  theme(axis.title = element_blank()) +
  scale_y_continuous(breaks = c(0,2,4,6,8,10)) +
  labs(title = "스터디 단점
    ")


#
thx_5number |> colnames()
library(bbplot)

thx_7tidy$num |> table()

thx_7tidy |> 
  drop_na(value) |> 
  group_by(스터디방식,구분, value) |> 
  reframe(n = n()) |> 
  ggplot(aes(x = 구분, y = value, fill = n)) +
  geom_tile() +
  geom_text(aes(label = n), color = "white") +
  scale_fill_gradient(low = "grey", high = "red") +
  facet_wrap(.~스터디방식) +
  theme(axis.title = element_blank(),
        legend.position = "none",
        strip.text = element_text(size = 20),
        axis.text = element_text(size = 13),
        plot.title = element_text(size = 20)) +
  labs(title = "설문조사 객관식 항목",
       subtitle = "참여: 오프라인 7명, 온라인 6명
       ") 

bbc_style

#평균
thx_7tidy |> 
  drop_na(value) |> 
  mutate(오프평균 = ifelse(스터디방식 == "오프라인",
    mean(value), NA),
    온라인평균 = ifelse(스터디방식 == "온라인",
      mean(value), NA))
