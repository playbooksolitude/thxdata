#23-0802 wedn 08:55

#
library(tidyverse)

presidential #1953
economics    #1967

#1 subset
subset(presidential, start > economics$date[1])
subset(presidential, start > economics$date[1]) -> temp1

ggplot() +
  geom_line(data = economics,
              aes(x = date, y = unemploy)) +
  geom_rect(data = subset(presidential, 
                          start > economics$date[1]),
            aes(xmin = start, xmax = end,
                ymin = 0, ymax = Inf, 
                fill = party), alpha = .4) +
  scale_fill_manual(values = c("Democratic" = "blue",
                               "Republican" = "red"))

#대통령 이름
ggplot() +
  geom_line(data = economics,
            aes(x = date, y = unemploy)) +
  geom_rect(data = subset(presidential, 
                          start > economics$date[1]),
            aes(xmin = start, xmax = end,
                ymin = 0, ymax = Inf, 
                fill = party), alpha = .4,
            show.legend = F) +
  scale_fill_manual(values = c("Democratic" = "blue",
                               "Republican" = "red")) +
  geom_label(data = subset(presidential,
                          start > economics$date[1]),
            aes(label = name, 
                x = start, 
                y = if_else(party == "Democratic",
                            11000, 12000), 
                color = party)) +
  scale_color_manual(values = c("Democratic" = "blue",
                               "Republican" = "red")) +
  labs(title = "미국 집권당에 따른 unemploy") +
  theme(legend.position = "top")

library(showtext)
showtext_auto()
