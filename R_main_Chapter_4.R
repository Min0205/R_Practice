##Chapter 4 Visualizing data
##Use the plot function
# Option 1: plot of X and Y
with(dfr, plot(X,Y))
# Option 2: formula interface (Y 'as a function of' X)
plot(Y ~ X, data=dfr)
##bar plot
##a simple bar plot
nums <- c(2.1,3.4,3.8,3.9,2.9,5)
barplot(nums)
##using ggplot2 to make complex bar plot and add error bar
rainbow(7)
library(RColorBrewer)
colors <- brewer.pal(n, "Set1")
cereal <- read.csv("Cereals.csv")
str(cereal)
library(ggplot2)
ggplot(cereal, aes(x=Manufacturer, y=rating)) +
  stat_summary(geom='bar', fun=mean) +
  stat_summary(geom='errorbar', fun.data=mean_se, width=0.25)
ggplot(cereal, aes(x = Cold.or.Hot, y = rating)) +
  stat_summary(geom = 'bar', fun = mean) +
  stat_summary(geom = 'errorbar', fun.data = mean_se, width = 0.25)

##histograms and curves
rannorm <- rnorm(500)
# set up two plots side-by-side
par(mfrow=c(1,2))
# A frequency diagram
hist(rannorm, freq=TRUE, main="")
# A density plot with a normal curve
hist(rannorm, freq=FALSE, main="", ylim=c(0,0.4))
curve(dnorm(x), add=TRUE, col="blue")
curve(sin(x), from=0, to=2*pi)

##pie chart
election <- read.csv("dutchelection.csv")
str(election)
##unlist makes this into a vector; [1 means from the first row, 
##2:ncol(election) means from the second to the last columns in 'elevation', 
##calculate mean of each column]
percentages <- unlist(election[1, 2:ncol(election)])
percentages
par(mfrow=c(1,2))
##'matrix' convert the diagram, Beside=FALSE makes this a stacked barplot
barplot(matrix(percentages), beside=FALSE, col=rainbow(12), ylim=c(0,100))
##a pie chart
pie(percentages, col=rainbow(12))
##subset 'election' to contain only the first and last rows, and subset the first column
percentages2 <- election[c(1, nrow(election)), -1]
##convert the dataframe to matrix
percentages2 <- as.matrix(percentages2)
percentages2
rownames(percentages2) <- election[c(1, nrow(election)), 'Date']
##t() transposes the party data from columns to rows
##xlim() creates extra space on the right of the plot for the legend
barplot(t(percentages2), beside=FALSE, col=rainbow(12), ylim=c(0,100),
        xlim=c(0, 4), legend=colnames(percentages2))
percentages3 <- election[c(1, 2, 3), -1]
percentages3
percentages3 <- as.matrix(percentages3)
percentages3
rownames(percentages3) <- election[c(1, 2, 3), 'Date']
barplot(t(percentages3), beside=FALSE, col=rainbow(12), ylim=c(0,100),
        xlim=c(0, 5), legend=colnames(percentages3))

##box plot
cereal <- read.csv("Cereals.csv")
str(cereal)
boxplot(sodium ~
          Manufacturer, data=cereal, ylab="Sodium content", xlab="Manufacturer")
boxplot(sugars ~
          Manufacturer, data=cereal, ylab="Sugar content", xlab="Manufacturer", col='orange')

##scatter plot
allom <- read.csv("allometry.csv")
allom$species <- as.factor(allom$species)
# Default scatter plot
with(allom, plot(diameter, height, col=species))
palette(c("blue","orange","forestgreen"))
with(allom, plot(diameter, height, col=species,
                 pch=15, xlim=c(0,80), ylim=c(0,50)))
par(xaxs="i", yaxs="i", cex.lab=1.4)
palette(c("blue","red","forestgreen"))
plot(height ~
       diameter, col=species, data=allom,
     pch=15, xlim=c(0,80), ylim=c(0,50),
     xlab="Diameter (cm)",
     ylab="Height (m)")
# Add a legend
legend("bottomright", levels(allom$species), pch=15, col=palette(), title="Species")

##fine-tuning the format of plots
##customizing and choosing colors
colors()
palette(c("blue2","goldenrod1","firebrick2","chartreuse4",
          "deepskyblue1","darkorange1","darkorchid3","darkgrey",
          "mediumpurple1","orangered2","chocolate","burlywood3",
          "goldenrod4","darkolivegreen2","palevioletred3",
          "darkseagreen3","sandybrown","tan",
          "gold","violetred4","darkgreen"))
# A simple graph showing the colors.
par(cex.axis=0.8, las=3)
n <- length(palette())
barplot(rep(1,n),
        col=1:n,
        names.arg=1:n,axes=FALSE)
##gradient ramp colors
redblue <- colorRampPalette(c("red","blue"))
a <- palette(redblue(10))
barplot(rep(1,10),
        col=a,
        names.arg=1:10,axes=FALSE)
whiteblack <- colorRampPalette(c("white","black"))
b <- palette(whiteblack(10))
barplot(rep(1,10),
        col=b,
        names.arg=1:10,axes=FALSE)

##set gradient ramp colors for scatterplot in two ways
##discrete value
hfemet <- read.csv("hfemet2008.csv")
str(hfemet)
##make a factor variable with 10 levels of rh.
hfemet$RHbin <- cut(hfemet$RH, breaks=10)
levels(hfemet$RHbin)
##set colors correspondingly, from red to blue.
blueredfun <- colorRampPalette(c("red","blue"))
palette(blueredfun(10))
##plot VPD and Tair, with the color of the symbol varying by rh.
par(cex.lab=1.3)
with(hfemet, plot(Tair, VPD, pch=19, cex=0.5, col=RHbin))
##add a legend
legend("topleft", levels(hfemet$RHbin), fill=palette(), title="RH")
##continuous value
library(ggplot2)
ggplot(hfemet, aes(x=Tair, y=VPD, col=RH)) +
##add the scatterplot layer
  geom_point() + 
  scale_colour_gradient(low='red', high='blue')