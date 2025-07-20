
#25-0628 sat 16:42

#
demo('colors')

#25-0703

#data()
#demo()

#https://grok.com/chat/21408e77-1e04-41bb-becc-1852b072ac46

version
R.version.string
RStudio.Version()

#
library(tidyverse)

#
demo()
demo(package = .packages(all.available = TRUE))

#graphics     
demo(package = 'graphics')
demo(topic = 'Hershey', package = 'graphics')    # 특수기호
demo(topic = 'Japanese', package = 'graphics')   # 일본어
demo(topic = 'graphics', package = 'graphics')   # graphics
demo(topic = 'image', package = 'graphics')      # map 
demo(topic = 'persp', package = 'graphics')      # 3d
demo(topic = 'plotmath', package = 'graphics')   # 수식

# 멈추고 싶을 땐 esc

# console


#
demo(lm.glm, package = "stats")
demo(lm.glm)  # 선형 모델과 일반화 선형 모델 예제

#
library(igraph)
demo(package = 'igraph', topic = 'smallworld')

#
library(diagram)
demo(package = 'diagram', topic = 'flowchart')

# ----
#
file.show(system.file("demo/plotmath.R", package = "graphics"))

#
demo(colors)
demo(hclColors)

# 
demo(package = 'knitr', topic = 'notebook')
#demo(package = 'knitr', topic = 'gwidgets') #javaScript 


#
library(colorspace)
demo(topic = 'brewer', package = 'colorspace')
demo(topic = 'carto', package = 'colorspace')

#
demo(topic = 'error.catching', package = 'base')

#
library(AER)
demo(topic = 'Ch-Basics', package = 'AER')

#
library(plotly)
demo(topic = 'crosstalk-filter-dynamic-axis', package = 'plotly')


#
library(zoo)
demo(topic = 'zoo-overplot', package = 'zoo')

