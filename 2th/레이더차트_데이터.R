#23-0629 

#
install.packages("fmsb")
library(fmsb)

#1 csv
(read_tsv("./files/csv/thxdata3.tsv") |> 
  select(-1) -> thx1_csv)

  #factor
as.factor(thx1_csv$type) -> thx1_csv$type

  #slice
(thx1_csv |> slice(1) -> thx2_engineers)
(thx1_csv |> slice(2) -> thx2_analysts)
(thx1_csv |> slice(3) -> thx2_scientists)
(thx1_csv |> slice(4) -> thx2_MLengineers)


  #marrix
data_max <- c(10)
data_min <- c(1)
radarchart(thx1_csv)
radarchart(thx2_analysts)

#2 csv_한개
(read_tsv("./files/csv/thxdata3_re.tsv") -> thx2_csv)
radarchart(thx2_csv)

#3 csv 합치기
(read_tsv("./files/csv/thxdata3_re1.tsv") -> thx3_csv)
radarchart(thx3_csv, 
           title = "Data")

?radarchart

  #3-1
thx3_csv |> 
  radarchart(pfcol=topo.colors(4), pcol=topo.colors(4), pdensity = c(5,20))
thx3_csv |> slice(1:3) |> radarchart()   #engineer
thx3_csv |> slice(1,2,4) |> radarchart() #analytics
thx3_csv |> slice(1,2,5) |> radarchart() #scientist
thx3_csv |> slice(1,2,6) |> radarchart() #ML engineer

dat <- data.frame(
  total=runif(3, 1, 5),
  phys=rnorm(3, 10, 2),
  psycho=c(0.5, NA, 3),
  social=runif(3, 1, 5),
  env=c(5, 2.5, 4))
dat
(dat <- rbind(maxmin,dat))
op <- par(mar=c(1, 2, 2, 1),mfrow=c(2, 2))
op
rm(op)

radarchart(dat, axistype=1, seg=5, plty=1, vlabels=c("Total\nQOL", "Physical\naspects", 
                                                     "Phychological\naspects", "Social\naspects", "Environmental\naspects"), 
           title="(axis=1, 5 segments, with specified vlabels)", vlcex=0.5)

radarchart(dat, axistype=2, pcol=topo.colors(3), plty=1, pdensity=c(5, 10, 30), 
           pangle=c(10, 45, 120), pfcol=topo.colors(3), 
           title="(topo.colors, fill, axis=2)")

radarchart(dat, axistype=3, pty=32, plty=1, axislabcol="grey", na.itp=FALSE,
           title="(no points, axis=3, na.itp=FALSE)")

radarchart(dat, axistype=1, plwd=1:5, pcol=1, centerzero=TRUE, 
           seg=4, caxislabels=c("worst", "", "", "", "best"),
           title="(use lty and lwd but b/w, axis=1,\n centerzero=TRUE, with centerlabels)")
par(op)



thx3_csv |> 
  radarchart(pfcol = colors_in, 
             pcol = coul)

thx3_csv |> slice(1:3) |> 
  radarchart(pcol="#1B9E77", pfcol = "#1B9E7780")   #engineer
thx3_csv |> slice(1,2,4) |> radarchart() #analytics
thx3_csv |> slice(1,2,5) |> radarchart() #scientist
thx3_csv |> slice(1,2,6) |> radarchart() #ML engineer

library(RColorBrewer)
brewer.pal.info
coul <- brewer.pal(4, "Set3")
(colors_border <- coul)
library(scales)
(colors_in <- alpha(coul, 0.5))
