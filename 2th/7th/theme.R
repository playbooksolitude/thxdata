


#월별 관객수
library(bbplot)
kobis2022_4월별관객수 |> 
  ggplot(aes(x = as.factor(월) |> fct_reorder((월)), 
             y = 관객수합계/1000000)) + 
  geom_bar(stat = "identity") +
  labs(x = "월", y = "월별 누적 관객수") +
  geom_label(aes(label = round(관객수합계/1000000,1)), size = 7) +
  scale_y_continuous(breaks = c(5,10,15,20)) +
  labs(title = "2022년 월별 극장관객수", 
       subtitle = "단위: 백만 명
       ") +
  #bbc_style()
  theme(panel.background = element_blank(),
        plot.title = element_text(size = 28), 
        plot.subtitle = element_text(size = 22), 
        panel.grid.major.y = element_line(color = "grey"),
        axis.text = element_text(size = 18),
        axis.title = element_blank(),
        axis.ticks = element_blank())
bbc_style


theme(panel.background = element_blank(),
      plot.title = element_text(size = 28), 
      plot.subtitle = element_text(size = 22), 
      panel.grid.major.y = element_line(color = "grey"),
      axis.text = element_text(size = 18),
      axis.title = element_blank(),
      axis.ticks = element_blank())