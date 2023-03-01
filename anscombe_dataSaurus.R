#23-0211 sat 20:31

#
cor.test()


read.table(
  pipe("pbpaste"), header = T, sep = "\t"  
) -> anscombe2
anscombe2
anscombe

library(datasets)
datasets::anscombe

anscombe |> select(x,y)
anscombe |> select(contains("1"))
anscombe |> select(contains("2"))
anscombe |> select(contains("3"))


#data saurus
read_tsv("DatasaurusDozen-wide.tsv")
read_tsv("DatasaurusDozen.tsv") -> cairo
table(cairo$dataset)
colnames(cairo)

ggplot(data = cairo, aes(x = x, y = y)) + geom_point() +
  facet_wrap(.~dataset, nrow = 4) +
  geom_smooth(se = F, method = "lm")

datasaurus_dozen |> filter(dataset == "dino") |> 
ggplot(aes(x = x, y = y)) + geom_point() +
  facet_wrap(.~dataset, nrow = 4) +
  geom_smooth(se = F) + geom_smooth(se = F, method = "lm")

datasaurus_dozen |> filter(dataset == "circle") |> 
  ggplot(aes(x = x, y = y)) + geom_point() +
  facet_wrap(.~dataset, nrow = 4) +
  geom_smooth(se = F) + geom_smooth(se = F, method = "lm")

datasaurus_dozen |> filter(dataset == "dots") |> 
ggplot(aes(x = x, y = y)) + geom_point() +
  facet_wrap(.~dataset, nrow = 4) +
  geom_smooth(se = F) + geom_smooth(se = F, method = "lm")

#dots star x_shape v_lines high_lines

ggplot(aes(x = x, y = y)) + geom_point() +
  facet_wrap(.~dataset, nrow = 4) +
  geom_smooth(se = F) + geom_smooth(se = F, method = "lm")

#-

cairo |> group_by(dataset) |> 
  summarise(mean = mean(x), 
            sd = sd(x),
            cor = cor(x,y))

install.packages("datasauRus")
library(datasauRus)
datasaurus_dozen

datasaurus_dozen |> group_by(dataset) |> 
  summarise(mean = mean(x), 
            sd = sd(x),
            cor = cor(x,y))

