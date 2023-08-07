#23-0629 thu 1)00

#
#install.packages("fmsb")
library(fmsb)
library(showtext)
showtext_auto()

#1 csv
(read_tsv("./2th/files/data_job8.tsv") -> thx4_csv)
    

#Analytics
thx4_csv |> slice(1,2,4) |> 
  radarchart(pcol="#F76461", pfcol = "#F7646180",
             vlcex = 1.5,
             title = "Data Analytics") 

#Engineer
thx4_csv |> slice(1:3) |> 
  radarchart(pcol="#1B9E77", pfcol = "#1B9E7780",
             title = "Data Engineer",
             vlcex = 1.5)   

#Scientist
thx4_csv |> slice(1,2,5) |> 
  radarchart(pcol="#E79C54", pfcol = "#E79C5480",
             title = "Data Scientist",
             vlcex = 1.5) 

#ML engineer
thx4_csv |> slice(1,2,6) |> 
  radarchart(pcol="#847574", pfcol = "#84757480",
             title = "ML Engineer",
             vlcex = 1.5) 

# 동시에 그리기 ----------------------------------
thx4_csv |> 
  radarchart(pcol="#847574", pfcol = "#84757480",
    title = "ML Engineer",
    vlcex = 1.5) 

  # 컬러 지정 #1 수동
c("#F76461", "#1B9E77", 
  "#E79C54", "#847574") -> colors_in #면적

c("#F764614c", "#1B9E774c", 
  "#E79C544c", "#8475744c") -> colors_out #테두리


  # 동시에 그리기 ---------------------------
thx4_csv |> 
  radarchart(pcol=colors_in, 
    pfcol = colors_out,
    title = "Data Job Skill",
    vlcex = 1.2)


# 컬러에 적용할 팔레트 보기
library(RColorBrewer)
brewer.pal.info
library(scales) #alpha 값 추출 함수


  #팔레트 이용하기
  (brewer.pal(4, "Set3") -> coul)
  (coul -> colors_border)
  (alpha(coul, 0.3) -> colors_in) #알파값 추출


#화면 4분할
#op <- par(mar=c(1, 2, 2, 1), mfrow=c(2, 2))
op <- par(mfrow=c(2, 2))
op

#화면 분할 해제
dev.off()

#
thx4_csv |>  
  radarchart(
    pcol = colors_in,           #테두리
    #pfcol = colors_in,       #면 채우기
    pfcol = colors_out,       #면 채우기
    plwd = 0.5,                #색칠 테두리 굵기
    plty = .5,                #테두리 점선
    cglcol = "grey",         #거미줄 색깔
    cglty = 1,               #거미줄 모양
    vlcex = 1.2)             #폰트 크기



#
