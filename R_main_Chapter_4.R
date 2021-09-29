##Chapter 4 Visualizing data
##Use the plot function
# Option 1: plot of X and Y
with(dfr, plot(X,Y))
# Option 2: formula interface (Y 'as a function of' X)
plot(Y ~ X, data=dfr)
##bar plot
nums <- c(2.1,3.4,3.8,3.9,2.9,5)
barplot(nums)
cereal <- read.csv("Cereals.csv")
library(ggplot2)
ggplot(cereal, aes(x=Manufacturer, y=rating)) +
  stat_summary(geom='bar', fun=mean) +
  stat_summary(geom='errorbar', fun.data=mean_se, width=0.25)

##histograms and curves
rannorm <- rnorm(500)
par(mfrow=c(1,2))
hist(rannorm, freq=TRUE, main="")
hist(rannorm, freq=FALSE, main="", ylim=c(0,0.4))
curve(dnorm(x), add=TRUE, col="blue")
