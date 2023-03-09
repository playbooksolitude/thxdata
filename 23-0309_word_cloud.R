#23-0309 thu

#기본 라이브러리
library(tidyverse)

#워드 크라우드 라이브러리
#install.packages("wordcloud") 인스톨 #주석 제거 후 실행
library("RColorBrewer")    #컬러 적용
library(wordcloud)         #word cloud 패키지

#한글일 경우 실행 필요
library(showtext) 
showtext_auto()

#사용할 데이터셋
library(nycflights13)

#dataset 만들기---------------
#nycflight 출발공항 dest 활용

flights |> group_by(dest) |> 
  summarise(n = n()) -> word_cloud2

#예쁜 컬러 선택
brewer.pal.info  #저는 "Spectral", 11가지 색
color <- brewer.pal(11,"Spectral")

#워드 클라우드 만들기
wordcloud(words = word_cloud2$dest,
          freq = word_cloud2$n,
          min.freq = 10,
          max.words = 105,
          random.order = F,
          rot.per = .1,
          scale = c(4,0.3),
          colors = color,
          use.r.layout = T)

#good