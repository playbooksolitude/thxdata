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
             vlcex = 2,
             title = "Data Analytics") 

#Engineer
thx4_csv |> slice(1:3) |> 
  radarchart(pcol="#1B9E77", pfcol = "#1B9E7780",
             title = "Data Engineer",
             vlcex = 2)   

#Scientist
thx4_csv |> slice(1,2,5) |> 
  radarchart(pcol="#E79C54", pfcol = "#E79C5480",
             title = "Data Scientist",
             vlcex = 2) 

#ML engineer
thx4_csv |> slice(1,2,6) |> 
  radarchart(pcol="#847574", pfcol = "#84757480",
             title = "ML Engineer",
             vlcex = 2) 

#컬러에 알파값을 적용하고 
# library(RColorBrewer)
# brewer.pal.info
# coul <- brewer.pal(4, "Set3")
# (colors_border <- coul)
# library(scales)
# (colors_in <- alpha(coul, 0.5))


#화면 분할
op <- par(mar=c(1, 2, 2, 1),mfrow=c(2, 2))
op
#화면 분할 해제
dev.off()
