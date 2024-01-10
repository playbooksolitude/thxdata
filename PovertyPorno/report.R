#23-1026 thu 23:34

#
library(tidyverse)
library(bbplot)
library(showtext)
showtext_auto()
#install.packages("geomtextpath")
library(geomtextpath)
library(bbplot)

#
googlesheets4::read_sheet("https://docs.google.com/spreadsheets/d/1kWw5IbuS9L9EwX3lfu6gPrLhrnWlBWrXX0k8GfEoEf0/edit?usp=sharing",
                          sheet = "설문지 응답 시트1의 사본 1") -> pp1_csv

#
pp1_csv |> dim()

#
pp1_csv |> colnames()

pp1_csv |> head(20) |> 
  view()

#
pp1_csv$`3. 귀하가 해당하는 유형을 선택해주세요.` |> 
  table()

pp1_csv |> colnames()

#
pp1_csv |> 
  rename(타임스탬프 = 1,
         개인정보동의 = 2,
         이름과휴대번호 = 3,
         연령대 = 4,
         성별 = 5,
         유형 = 6,
         기부_시작_계기 = 7,
         기부_기관명 = 8,
         기관_선택_이유 = 9,
         후원_유형 = 10,
         기부_캠페인 = 11,
         기부_지속_이유 = 12,
         빈곤사진_경험 = 13,
         빈곤사진_미디어 = 14,
         빈곤사진_기부결정 = 15,
         빈곤사진_기부미결정_이유 = 16,
         모금액_사용처명시 = 17,
         모금액_수혜대상 = 18,
         모금액_문제원인_통계제공 = 19,
         수혜자_개인정보_가명 = 20,
         기부선호_캠페인 = 21,
         빈곤포르노_비기부자_용어인지 = 22,
         빈곤포르노_비기부자_매체경험 = 23,
         빈곤포르노_비기부자_인지경로 = 24,
         실무자_근무경력 = 25,
         실무자_담당업무 = 26,
         실무자_모금홍보사업_경험 = 27,
         빈곤포르노_실무자_용어인지 = 28,
         빈곤포르노_실무자_관점 = 29,
         빈곤포르노_실무자_재직기관활용 = 30,
         빈곤포르노_실무자_모금성과 = 31,
         빈곤포르노_실무자_지속 = 32,
         빈곤포르노_실무자_지속이유 = 33,
         빈곤포르노_실무자_근절논의 = 34,
         빈곤포르노_실무자_근절논의시점 = 35,
         빈곤포르노_실무자_가이드라인 = 36,
         인상적인_모금콘텐츠 = 37,
         하고싶은말 = 38) -> pp2_rename


# ----------------------------------------------------------
pp2_rename$유형 |> table() |> data.frame() |> 
  tibble() 

pp2_rename$유형 |> table() |> 
  data.frame() |> 
  tibble() |> 
  mutate(pop = round(prop.table(Freq),2)*100,
         대상자 = ifelse(Var1 == "기부자 (기부를 하고 있거나 한 경험이 있는 사람)", "기부자",
                ifelse(Var1 == "비기부자 (기부한 경험이 없는 사람)", "비기부자", "실무자"))) -> pp2_1table

pp2_1table


#
pp2_1table |> 
  ggplot(aes(x = 대상자, y = Freq)) +
  geom_bar(stat = "identity", aes(fill = 대상자)) +
  geom_label(aes(label = paste(Freq, "명")), size = 10) +
  geom_text(aes(label = paste(pop, "%")), 
            size = 10, color = "white",
            position = position_stack(.5)) +
  bbc_style() +
  theme(legend.position = "none") +
  scale_fill_manual(values = c("#bf616a", "#81a1c1",
                               "#a3be8c"))


#
pp2_rename |> 
  filter(유형 == "기부자 (기부를 하고 있거나 한 경험이 있는 사람)") -> pp3_1기부자

pp2_rename |> 
  filter(유형 == "비기부자 (기부한 경험이 없는 사람)") -> 
  pp3_2비기부자

pp2_rename |> 
  filter(유형 == "국제개발협력 실무자") -> pp3_3실무자

#필터링 전,후
pp3_1기부자 |> nrow() + 
  pp3_2비기부자 |> nrow() + 
  pp3_3실무자 |> nrow()       #602명
pp2_rename |> nrow()          #602명

# ------------- 기부자
pp3_1기부자 #|> view()

pp3_1기부자 |> 
  colnames()

#
pp3_1기부자 |>
  filter(성별 != "기타") |> 
  count(성별, 연령대) |> 
  ggplot(aes(x = 연령대, y = 성별, fill = n)) +
  geom_tile() +
  geom_text(aes(label = n), size = 8) +
  scale_fill_gradient2(low = "grey", high = "red") +
  theme(panel.background = element_blank(),
        axis.text = element_text(size = 20),
        axis.title = element_blank(),
        axis.ticks = element_blank(),
        legend.position = "none") +
  labs(title = "기부자 성별/연령 분포")
  
#
pp3_2비기부자 |>
  filter(성별 != "기타") |> 
  count(성별, 연령대) |> 
  ggplot(aes(x = 연령대, y = 성별, fill = n)) +
  geom_tile() +
  geom_text(aes(label = n), size = 8) +
  scale_fill_gradient2(low = "grey", high = "red") +
  theme(panel.background = element_blank(),
        axis.text = element_text(size = 20),
        axis.title = element_blank(),
        axis.ticks = element_blank(),
        legend.position = "none") +
  labs(title = "비기부자 성별/연령 분포")

#
#
pp3_3실무자 |>
  filter(성별 != "기타") |> 
  count(성별, 연령대) |> 
  ggplot(aes(x = 연령대, y = 성별, fill = n)) +
  geom_tile() +
  geom_text(aes(label = n), size = 8) +
  scale_fill_gradient2(low = "grey", high = "red") +
  theme(panel.background = element_blank(),
        axis.text = element_text(size = 20),
        axis.title = element_blank(),
        axis.ticks = element_blank(),
        legend.position = "none") +
  labs(title = "비기부자 성별/연령 분포")

#
pp2_rename |>
  filter(성별 != "기타") |> 
  count(성별, 연령대) |> 
  ggplot(aes(x = 연령대, y = 성별, fill = n)) +
  geom_tile() +
  geom_text(aes(label = n), size = 8) +
  scale_fill_gradient2(low = "grey", high = "red") +
  theme(panel.background = element_blank(),
        axis.text = element_text(size = 20),
        axis.title = element_blank(),
        axis.ticks = element_blank(),
        legend.position = "none") +
  labs(title = "비기부자 성별/연령 분포")


#성별 분포
# pp2_rename |> 
#   filter(성별 != "기타") |> 
#   ggplot(aes(x = 성별, y = stat(count))) +
#   geom_bar() + 
#   geom_label(aes(label = stat(count)), 
#              stat = "count", size = 15) +
#   geom_text(aes(label = scales::percent(after_stat(prop),
#                                         accuracy = 1)),
#              stat = "prop", size = 15) +
#   bbc_style()


#
pp2_rename |> 
  filter(성별 != "기타") |> 
  count(성별) |> 
  mutate(sum = sum(n),
         비율 = n/sum)

#
pp2_rename$기부_시작_계기 |> table()
pp2_rename |> count(기부_시작_계기)


#계기-1
pp2_rename |> 
  mutate(num = row_number(), .before = 1) |> 
  separate(col = 기부_시작_계기, 
           into = c("계기1", "계기2", "계기3","계기4",
                    "계기5", "계기6", "계기7",
                    "계기8", "계기9"), 
           sep = ", ", remove = T) |> 
  select(1,5:16) |> 
  filter(!is.na(계기8)) |> view()


  #계기-2 ------- 기타때문에 다시
pp2_rename |> 
  mutate(번호 = row_number(), .before = 1) |> 
  separate(col = 기부_시작_계기, 
           into = c("계기1", "계기2", "계기3","계기4",
                    "계기5", "계기6", "계기7",
                    "계기8", "계기9"), 
           sep = ", ", remove = T) |> 
  select(1,5:16) |> 
  pivot_longer(cols = contains("계기"), 
               names_to = "계기",
               values_to = "value") |> 
  filter(!is.na(value)) |> 
  group_by(value) |> 
  summarise(n = n()) |> view()

  ggplot(aes(x = value, y = n)) +
  geom_bar(stat = "identity") +
  bbc_style()
  
  #계기-3
  pp2_rename |> 
    mutate(번호 = row_number(), .before = 1) -> pp2_2rownumber

  # #계기-4
  # pp2_2rownumber |> 
  #   mutate(기부_시작_계기2 = 
  #            ifelse(pp2_2rownumber$기부_시작_계기 == "시민으로서의 책임이라고 생각해서", 기부_시작_계기,
  #                   ifelse(pp2_2rownumber$기부_시작_계기 == "기부단체 등의 직접적인 요청을 받아서 (모금 요청 전화, 길거리 캠페인 등)", "기부단체 등의 직접적인 요청을 받아서",
  #                          ifelse(pp2_2rownumber$기부_시작_계기 == "어려운 처지의 사람을 돕고 싶어서", 기부_시작_계기,
  #                                 ifelse(pp2_2rownumber$기부_시작_계기 == "종교적 신념 때문에", 기부_시작_계기,
  #                                        ifelse(pp2_2rownumber$기부_시작_계기 == "세제 혜택 때문에", 기부_시작_계기,
  #                                               ifelse(pp2_2rownumber$기부_시작_계기 == "지인의 소개를 통해서", 기부_시작_계기,
  #                                                      ifelse(pp2_2rownumber$기부_시작_계기 == "남의 도움을 받은적이 있고, 이를 갚고 싶어서", "도움 받은 경험을 보답하고 싶어서",
  #                                                             ifelse(pp2_2rownumber$기부_시작_계기 == "남을 돕는 것이 행복해서", 기부_시작_계기,
  #                                                                    ifelse(pp2_2rownumber$기부_시작_계기 == "미디어에서의 후원광고를 보고", 기부_시작_계기, "기타")))))))))) |> 
  #   head() |> view()

# --------------------------------------
pp3_1기부자 |> 
    ggplot(aes(x = 모금액_사용처명시, 
                      y = after_stat(count))) +
    geom_bar(aes(fill = 모금액_사용처명시)) +
    geom_label(aes(label = after_stat(count)), 
               stat = "count", size = 12) +
    bbc_style() +
    scale_fill_manual(values = c("#bf616a", "#81a1c1",
                                 "#a3be8c")) +
    theme(legend.position = "none")


  pp3_3실무자 |> 
    ggplot(aes(x = 모금액_사용처명시, 
               y = after_stat(count))) +
    geom_bar(aes(fill = 모금액_사용처명시)) +
    geom_label(aes(label = after_stat(count)), 
               stat = "count", size = 12) +
    bbc_style() +
    scale_fill_manual(values = c("#bf616a", "#81a1c1",
                                 "#a3be8c")) +
    theme(legend.position = "none")

