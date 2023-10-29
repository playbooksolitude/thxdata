#23-1026 thu 23:34

#
library(tidyverse)
library(bbplot)
library(showtext)
showtext_auto()

#
googlesheets4::read_sheet("https://docs.google.com/spreadsheets/d/1kWw5IbuS9L9EwX3lfu6gPrLhrnWlBWrXX0k8GfEoEf0/edit?usp=sharing") -> pp1_csv

#
pp1_csv |> dim()

#
pp1_csv |> colnames()

pp1_csv |> view()

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

#
pp3_1기부자


















