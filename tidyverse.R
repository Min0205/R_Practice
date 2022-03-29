install.packages("tidyverse")
#%>%
diff(sort(abs(round(rnorm(n = 100, mean = 0, sd = 15)))))
library(tidyverse)
rnorm(n = 100, mean = 0, sd = 15) %>% round(x = .) %>% abs() %>% sort() %>% diff()  ##x = .can be omitted
#package dplyr
##group_by(),example 1
test <- read.csv("test.csv", encoding = "UTF-8")
group_by(test, X.U.FEFF.name, test)
a <- group_by(test, X.U.FEFF.name, test)
summarise(a, score=sum(score))
####example 2
data <- read.csv("variable_data.csv")
b <- group_by(data, species)
summarise(b, ed_duration.day.=mean(ed_duration.day.))
######another expression
group_by(data, species) %>% summarise(ed_duration.day.=mean(ed_duration.day.))
##filter()
DFA = tibble(RT=rnorm(n = 500, mean = 600, sd = 150) %>% round(x= ., digits = 3))
DFA1 = DFA %>% filter (RT >200 & RT <800)
DFA2 = DFA %>% filter (RT < mean(RT) - 3*sd(RT) | RT > mean(RT) + 3*sd(RT))
DFB = test
DFB1 = DFB %>% group_by(X.U.FEFF.name, test) %>% filter(score > 2 & score < 7)
DFB1 = DFB %>% group_by(X.U.FEFF.name, test) %>% filter(score > mean(score))
##select() 
head(iris)
iris %>% select(Sepal.Length) %>% head()
iris %>% select(Sepal.Length, Sepal.Width) %>% head()
iris %>% select(-c(Sepal.Length, Sepal.Width)) %>% head()
iris %>% select(starts_with('Petal')) %>% head()
iris %>% select(ends_with('Width')) %>% head()
##mutate() generate new variables
head(mtcars)
DF0 = mtcars %>% select(c(mpg, wt))
DF0
DF0 = as.tibble(DF0)
DF0
DF0 %>% mutate(wt0 = wt-1)
DF0 %>% mutate(wt0 = wt*mpg)
DF0 %>% mutate(mpg_Z = scale(mpg))
DF0 %>% mutate(mpg_Z = scale(mpg), wt0 = wt-1, mpg_wt = wt*mpg)
DF0 %>% mutate(mpg_Z = scale(mpg), mpg_wt = wt*mpg_Z)
##arrange()
head(mtcars)
DF00 = mtcars %>% select(c(mpg, am, gear))
DF00
DF00 %>% arrange(mpg)
DF00 %>% arrange(-mpg)
DF00 %>% arrange(-am, gear, mpg)
##summarise()
DF00
DF00 %>% group_by(am) %>% summarise(Meanmpg = mean(mpg), SDmpg = sd(mpg))
DF00 %>% group_by(am) %>% summarise(Meanmpg = mean(mpg), SDmpg = sd(mpg), Maxmpg = max(mpg), Minmpg = min(mpg))
##rename() rename variables
DF00 %>% .[1:5, ] %>% rename(haoyouliang = mpg, biansuqi = am, chilun = gear)

#package tidyr, used to transform data
library(tidyr)
miniiris <- iris[c(1,51,101),]
miniiris
##pivot_longer(), long
####method 1
pivot_longer(data = iris, 
             cols = c(Sepal.Length, Sepal.Width, Petal.Length, Petal.Width), 
             names_to = "flower", 
             values_to = "value", 
             values_drop_na = F)
####method 2
iris %>% pivot_longer(c(Sepal.Length, Sepal.Width, Petal.Length, Petal.Width), "flower", "value")
####method 3
miniiris %>% pivot_longer(contains(c("Length", "width")), "flower", "value")
#pivot_wider(),wide
long <- miniiris %>% pivot_longer(contains(c("Length", "width")), "flower", "value")
long %>% pivot_wider(names_from = flower, values_from = value)
####practice
data <- read.csv("variable_data.csv")
str(data)
a <- data %>% select(ac_RSWC, ad_RSWC, ec_RSWC, ed_RSWC) %>% tibble() %>% pivot_longer(c(ac_RSWC, ad_RSWC, ec_RSWC, ed_RSWC), "RSWC", "value")
a
ggplot(a, aes(x=RSWC, y=value))+     
  geom_boxplot(aes(fill=RSWC))
#package ggplot2
##package patchwork, layout figures
library(patchwork)
p1 <- ggplot(mtcars) + 
  geom_point(aes(mpg, disp), colour = "#7fc97f") + 
  ggtitle('Plot 1')
p1
p2 <- ggplot(mtcars) + 
  geom_boxplot(aes(gear, disp, fill = factor(gear)), 
               show.legend = FALSE) + 
  ggtitle('Plot 2')
p2
p3 <- ggplot(mtcars) + 
  geom_point(aes(hp, wt, colour = mpg)) + 
  scale_colour_gradientn(
    colours = c("#66c2a5", "#fc8d62", "#8da0cb")) +
  ggtitle('Plot 3')
p3
p4 <- ggplot(mtcars) + 
  geom_bar(aes(gear, fill = factor(gear)), 
           show.legend = FALSE) + 
  facet_wrap(~cyl) +   
  ggtitle('Plot 4')
p4
p1 + p2
patch <- p1 + p2
p3 + patch
patch + p3
p1 + p2 + p3
patch - p3 ##or wrap_plots(patch, p3)
p1 | p2
p1 / p2
p1 / (p2 | p3)
wrap_plots(p1, p2, p3, p4) ##or wrap_plots(list(p1, p2, p3, p4))
p1 + plot_spacer() + p2 + plot_spacer() + p3 + plot_spacer()
(p1 + plot_spacer() + p2) / (plot_spacer() + p3 + plot_spacer())
p1 + p2 + p3 + p4 + plot_layout(ncol = 3)
p1 + p2 + p3 + p4 + plot_layout(widths = c(2, 1))
p1 + p2 + p3 + p4
p1 + p2 + p3 + p4 + plot_layout(widths = c(2, 1), heights = unit(c(3, 1), c('cm', 'null')))
p1 + p2 + p3 + p4 + plot_layout(widths = 0.5)
layout <- "
##BBBB
AACCDD
####DD"
p1 + p2 + p3 + p4 + 
  plot_layout(design = layout)
layout <- c(
  area(t = 1, l = 1, b = 2, r = 4),
  area(t = 2, l = 2, b = 2, r = 4))
p1 + p2 + plot_layout(design = layout)
