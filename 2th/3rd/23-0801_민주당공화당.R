#23-0801 tue 21:40

#
library(tidyverse)

economics
presidential

#
economics$date > presidential$start
filter(economics, economics$date > presidential$start,
       economics$date < presidential$end)

ggplot(data = economics) +
  geom_line(aes(x = date, y = unemploy)) +
  geom_segment(data = presidential,
               aes(x = start, xend = start, 
                   y = 0, yend = Inf,
                   color = party))

args(geom_segment)
?geom_segment

# bible
subset(economics, date > presidential$start[1])
subset(presidential, start > economics$date[1]) -> temp1

ggplot(data = economics) + 
  geom_line(aes(x = date, y = unemploy)) +
  geom_segment(data = temp1,
               aes(x = start, xend = start, 
                   y = 0, yend = Inf,
                   color = party))

args(geom_rect)
?geom_rect

ggplot(data = economics) + 
  geom_line(aes(x = date, y = unemploy)) +
  geom_rect(data = presidential,
               aes(xmin = start, xmax = end, 
                   ymin = 0, ymax = Inf, fill = party),
            alpha = .5) +
  scale_fill_manual(values = c("Democratic" = "red",
                               "Republican" = "blue"))


#두 데이터의 date 기간 통일
presidential2 <- subset(presidential, start > economics$date[1]) 

#
ggplot(data = economics) + 
  geom_line(aes(x = date, y = unemploy)) +
  geom_rect(data = presidential2,
    aes(xmin = start, xmax = end, 
      ymin = 0, ymax = Inf, fill = party),
    alpha = .5) +
  scale_fill_manual(values = c("Democratic" = "red",
    "Republican" = "blue"))

