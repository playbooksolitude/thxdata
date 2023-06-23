#tidyr fill() #소득수준 공공데이터

#
#read_xlsx ---------------------
library(tidyverse)
getwd()
library(readxl)
read_excel("/Users/yohanchoi/Downloads/capital.xlsx") -> capital

#datasize check
dim(capital);colnames(capital)
c("cases", "net_assets", "category", "April", "May", "June") -> colnames(capital)
table(capital$cases) %>% as.data.frame()
capital %>% view()

#fill() ----- #cases #net_assets
capital %>% fill(cases, .direction = "down") %>% 
  fill(net_assets, .direction = "down") %>% print(n = 30)

#capital_2_tidy
(capital_2_tidy <- capital %>% fill(cases, .direction = "down") %>% 
    fill(net_assets, .direction = "down") %>% slice(-1)) #부채보유 여부별 제거

table(capital_2_tidy$cases) #check
#capital_2_tidy %>% view()
#file 분리 #cases -> #전체 #부채 보유 #부채 미보유

(capital_2_tidy %>% filter(net_assets == "전체") -> capital_3_summary)

(capital_2_tidy %>% filter(net_assets != "전체", 
                           cases == "전체") -> capital_3_all)

(capital_2_tidy %>% filter(net_assets != "전체", 
                           cases == "부채 보유") -> capital_3_dept)

(capital_2_tidy %>% filter(net_assets != "전체", 
                           cases == "부채 미보유") -> capital_3_not_dept)
table(capital_2_tidy$cases)

#capital_2_tidy %>% view()

capital_3_summary %>% print(n = Inf) %>% view()
capital_3_all %>% print(n = Inf) %>% view()
capital_3_dept %>% print(n = Inf) %>% view()
capital_3_not_dept %>% print(n = Inf) %>% view()
