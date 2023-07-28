#23-0725 tue 16:02
#마부뉴스
#https://kkockko.substack.com/p/7d3?sd=pf

library(readxl)
library(scales)

#1 파일 불러오기
  #1-1
read_excel("./2th/2st/fe_dod_compo_crois_va.xlsx") -> france1_excel

  #1-2 컬럼명 확인하기 2번행 제목, 3번행부터 값
france1_excel
france1_excel |> colnames()

#2 
  #2-1 #1~2번행 제거
france1_excel |> slice(-c(1:2)) #제거안됨

  #2-2 #components 는 skip으로 제거 필요
read_excel("./2th/2st/fe_dod_compo_crois_va.xlsx",
           skip = 1) -> france1_excel #성공

  #2-3 
france1_excel |> colnames()
france1_excel |> select(-"...2") #병합된 2열 제거
france1_excel |> select(-"...2") -> france2_select

#3 
france2_select |> 
  select(Year, `Population on january, first`,
         "Natural increase", "Net migration") |> 
  rename(population = 2, 
         natural = 3,
         net_migration = 4) -> france3_tidy


########## <<<<< -----------------------------------------------------


#4 tidy
france3_tidy |> 
  ggplot(aes(x = Year)) +
  geom_bar(aes(y = population),
           stat = "identity") #2014 Mayotte error #2014 두배


  #4-1 Mayotte 제거
france3_tidy |> print(n = Inf) #2014년부터 Mayotte 포함
france3_tidy |> slice(-33) -> france4_tidy
#france3_tidy 삭제해도 됨


########## ----------------------------------------------------- >>>>>


#5 tidy_re
france4_tidy |> 
  ggplot(aes(x = Year)) +
  geom_bar(aes(y = population),
           stat = "identity") 


france4_tidy |> 
  ggplot(aes(x = Year)) +
  geom_bar(aes(y = population),
           stat = "identity")  +
  coord_flip() #error #47~51번 라인


########## <<<<< -----------------------------------------------------


france4_tidy |> tail(10)
france4_tidy |> print(n = Inf)
france4_tidy |> slice(1:41) -> france5_tidy


########## ----------------------------------------------------- >>>>>


#6 정상 그래프
france5_tidy |> 
  ggplot(aes(x = Year)) +
  geom_bar(aes(y = population),
           stat = "identity") # + coord_flip()

  #6-1 theme angle
france5_tidy |> 
  ggplot(aes(x = Year)) +
  geom_bar(aes(y = population/1000),
           stat = "identity") +
  theme(axis.text.x = element_text(angle = 45, hjust = .7),
        axis.title = element_blank()) +
  scale_y_continuous(breaks = c(20000,40000,60000, 80000)) +
  coord_cartesian(ylim = c(0,80000))


  #6-2 error goem_line 안보인다 (너무 작아서)
france5_tidy |> 
  ggplot(aes(x = Year)) +
  geom_bar(aes(y = population/1000),
           stat = "identity") +
  geom_line(aes(y = natural/1000, group = 1), 
            stat = "identity", size = 2, color = "red") +
  theme(axis.text.x = element_text(angle = 45, hjust = .7),
        axis.title = element_blank()) +
  scale_y_continuous(breaks = c(20000,40000,60000, 80000)) +
  coord_cartesian(ylim = c(0,80000))


########## <<<<< -----------------------------------------------------


france5_tidy |> str()
france5_tidy$natural |> as.numeric() -> france5_tidy$natural
france5_tidy$net_migration |> as.numeric() -> france5_tidy$net_migration
france5_tidy |> str()
france5_tidy$Year |> as.factor() -> france5_tidy$Year


########## ----------------------------------------------------- >>>>>


#7 이중축
france5_tidy |> 
  ggplot(aes(x = Year)) +
  geom_bar(aes(y = population/225),
           stat = "identity", 
          fill = "#91BBE3", alpha = .5) +
  geom_line(aes(y = natural, group = 1), color = "blue", size = 1) +
  geom_line(aes(y = net_migration, group = 1), 
            color = "red", size =1) +
  theme(axis.text.x = element_text(hjust = 1.5, vjust = 2.5, angle = 45),
        axis.title = element_blank(),
        axis.text.y = element_blank(),
        panel.background = element_blank(),
        axis.ticks = element_blank(),
        plot.title = element_text(size = 28),
        plot.subtitle = element_text(size = 22)) +
  scale_y_continuous(sec.axis = sec_axis(~./10, name = "population")) +
  labs(title = "마부뉴스 7월 13일", 
       subtitle = "프랑스는 관용의 나라인가?") + 
  scale_x_discrete(expand = c(.1, .1)) #여백주기


#8 이민자, 
library(showtext)
showtext_auto()

france5_tidy |> 
  ggplot(aes(x = Year)) +
  geom_line(aes(y = natural/1000, group = 1), color = "blue", size = 1) +
  geom_line(aes(y = net_migration/1000, group = 1), 
            color = "red", size =1) +
  theme(axis.text.x = element_text(hjust = 1.5, vjust = 2.5, angle = 45),
        axis.title = element_blank(),
        panel.background = element_blank(),
        axis.ticks = element_blank()) +
  labs(title = "프랑스 이민자", 
       subtitle = "단위: 천 명") +
  annotate(geom = "text", x = "2000", y = 290, 
           label = "비-이민자", color = "blue", size = 10) +
  annotate(geom = "text", x = "1996", y = 100, 
           label = "이민자", color = "red", size = 10)



#8-1 y값 지수 표현 해결 #예전에 실행했던 코드를 우연히 발견했다
france5_tidy |> 
  ggplot(aes(x = Year)) +
  geom_line(aes(y = natural, group = 1), color = "blue", size = 1) +
  geom_line(aes(y = net_migration, group = 1), 
            color = "red", size =1) +
  theme(axis.text.x = element_text(hjust = 1.5, vjust = 2.5, angle = 45),
        axis.title = element_blank(),
        panel.background = element_blank(),
        axis.ticks = element_blank()) +
  labs(title = "프랑스 이민자") +
  annotate(geom = "text", x = "2000", y = 290000, 
           label = "비-이민자", color = "blue", size = 10) +
  annotate(geom = "text", x = "1996", y = 100000, 
           label = "이민자", color = "red", size = 10) +
  scale_y_continuous(labels = scales::comma)  


