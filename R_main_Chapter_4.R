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


##pie chart
election <- read.csv("dutchelection.csv")
str(election)
percentages <- unlist(election[6, 2:ncol(election)])
par(mfrow=c(1,2))
barplot(matrix(percentages), beside=FALSE, col=rainbow(12), ylim=c(0,100))
##a pie chart
pie(percentages, col=rainbow(12))
percentages2 <- election[c(1, nrow(election)), -1]
percentages2 <- as.matrix(percentages2)
rownames(percentages2) <- election[c(1, nrow(election)), 'Date']
barplot(t(percentages2), beside=FALSE, col=rainbow(12), ylim=c(0,100),
        xlim=c(0, 4), legend=colnames(percentages2))

