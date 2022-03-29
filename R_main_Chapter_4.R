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

##set semi-transparent colors
##load the package for the function 'alpha'
library(scales)
x <- rnorm(1000)
y1 <- x + rnorm(1000, sd=0.5)
y2 <- -x + rnorm(1000, sd=0.6)
plot(x,y1,pch=19,col=alpha("blue",0.3))
points(x,y2, pch=19, col=alpha("red",0.3))

##customizing symbols and lines
X <- 1:5
Y <- c(4,5.5,6.1,5.2,3.1)
plot(X,Y, type='p', main="type='p'")
plot(X,Y, type='o', main="type='o'")
plot(X,Y, type='b', main="type='b'")
plot(X,Y, type='l', main="type='l'")
plot(X,Y, type='h', main="type='h'")
plot(X,Y, type='s', main="type='s'")
par(mfrow=c(2,2))
##open triangles
with(allom, plot(diameter, height, pch=2, col="red"))
##red solid squares
with(allom, plot(diameter, height, pch=15, col="green", bg="green"))
##filled circles, with a black edge, and a grey fill color
with(allom, plot(diameter, height, pch=21, bg="grey", col="black"))
##custom plotting symbol (any character works)
with(allom, plot(diameter, height, pch="W"))
with(allom, plot(diameter, height, pch="$"))
with(allom, plot(diameter, height, pch="@"))

##set symbol types by a factor level
palette(c("blue","red","forestgreen"))
with(allom, plot(diameter, height,
                 col=species,
                 pch=c(1,2,15)[species],
                 xlim=c(0,80), ylim=c(0,50)))
grey <- colorRampPalette(c("grey","darkgrey"))
palette(grey(3))
par(xaxs="i", yaxs="i", cex.lab=1.4)
with(allom, plot(diameter, height,
                 col=species,
                 pch=c(1,2,15)[species],
                 xlim=c(0,80), ylim=c(0,50)))
legend("bottomright", levels(allom$species), pch=c(1,2,15), col=palette(), title="Species")

##formatting units, equations and special symbols
?plotmath
?expression
expression(Infected~area~(cm^2))
expression(Photosynthesis~ ~(mu*mol~m^-2~s^-1))
expression(Temperature~ ~(degree*C))
par(mar=c(5,5,2,2))
x <- 1:5
y <- c(4,5.5,6.1,5.2,3.1)
plot(x,y, xlab = expression(Temperature~ ~(degree*C)), ylab=expression(Photosynthesis~ ~(mu*mol~m^-2~s^-1)))
plot(x,y, xlab = expression(5[3]), ylab=expression(Photosynthesis~ ~(mu*mol~m^-2~s^-1)))
expression(Permille~"\u00A5")
expression(Permille~"\u00BC")
##reset the graphical characters
dev.off()

##changing the font
##!!!this part has an unsolved bug!!!
install.packages("extrafont")
library(extrafont)
library(remotes)
remotes::install_version("Rttf2pt1", version = "1.3.8")
font_import()
y
fonts()
plot(x,y, xlab="some label", family="Comic Sans MS")
plot(x,y, main="Italic text", font=6)

##change system language
Sys.setlocale("LC_TIME", "English")

##adding to a current plot
election <- read.csv("dutchelection.csv")
election$Date <- as.Date(election$Date)
str(election)
##plot the first variable (make sure to set the Y axis range
##wide enough for all the other data!)
plot(VVD ~
       Date, data=election, type='l', col="blue", ylim=c(0,40),
     ylab="Poll result (%)", lty=1)
##add the rest of the results, one at a time using points
points(PvdA ~
         Date, data=election, type='l', col="red")
points(SP ~
         Date, data=election, type='l', col="red", lty=5)
points(GL ~
         Date, data=election, type='l', col="forestgreen")
##add a vertical line at x=0
abline(v=0)
##add a horizontal line at y=50
abline(h=50)
##add a line with an intercept of 0 and a slope of 1
##(known as a 1:1 line)
abline(0,1)
plot(x,y, abline(h=4))
plot(x,y, abline(v=3))
plot(x,y, abline(0,1))
plot(x,y, abline(h=4))
points(x,y, abline(v=3))
points(x,y, abline(0,1))
##add a legend
legend("topleft", expression(bold(A)), bty='n', inset=0.000001)

##change the layout of plot
par(mfrow=c(2,2),mar=c(4.1,4.1,0.1,0.1))
plot(leafarea~
       height,data=allom,col=species,xlab='', pch=15)
plot(leafarea~
       diameter,data=allom,col=species,xlab='',ylab='',pch=15)
plot(branchmass~
       height,data=allom,col=species,pch=15)
plot(branchmass~
       diameter,data=allom,col=species,ylab='',pch=15)
l<-layout(matrix(c(1,1,1,2,3,4),nrow=3,ncol=2,byrow=F))
layout.show(l)
layout(matrix(c(1,1,1,2,3,4),nrow=3,ncol=2,byrow=F))
plot(leafarea~
       height,data=allom,col=species,xlab='', pch=15)
plot(leafarea~
       diameter,data=allom,col=species,xlab='',ylab='',pch=15)
plot(branchmass~
       height,data=allom,col=species,pch=15)
plot(branchmass~
       diameter,data=allom,col=species,ylab='',pch=15)
p <- layout(matrix(c(1,1,1,2,3,4),nrow=3,ncol=2,byrow=F))
layout.show(p)

##example1
vessel <- read.csv("vessel.csv")
str(vessel)
vesselBase <- subset(vessel, position=="base")
vesselApex <- subset(vessel, position=="apex")
par(mfrow=c(1,2))
##simple histograms, default settings.
dev.off()
hist(vesselBase$vesseldiam)
hist(vesselApex$vesseldiam)
##fine tune formatting with par()
par(mfrow=c(1,2), mar=c(5,5,4,1), cex.lab=1.3, xaxs="i", yaxs="i")
##first panel
hist(vesselBase$vesseldiam,
     main="Base",
     col="darkgrey",xlim=c(0,160), breaks=seq(0,160,by=10),
     xlab=expression(Vessel~
                       diameter~ ~
                       (mu*m)),
     ylab="Number of vessels")
##second panel
hist(vesselApex$vesseldiam,
     main="Apex",
     col="lightgrey",
     xlim=c(0,160), breaks=seq(0,160,by=10),
     xlab=expression(Vessel~
                       diameter~ ~
                       (mu*m)),
     ylab="Number of vessels")
dev.off()
##example2
##read the hfemet data. Avoid conversion to factors.
hfemet <- read.csv("HFEmet2008.csv", stringsAsFactors=FALSE)
str(hfemet)
##convert to a proper DateTime class
install.packages("lubridate")
library(lubridate)
hfemet$DateTime <- mdy_hm(hfemet$DateTime)
##Add the Date line
hfemet$Date <- as.Date(hfemet$DateTime)
str(hfemet$Date)
str(hfemet)
hfemetsubs <- subset(hfemet, Date==as.Date("2008-6-1"))
with(hfemetsubs, plot(DateTime, Tair, type='l'))

##use par(new=TRUE) to produces the next plot right on top of the old one
par(new=TRUE)
with(hfemetsubs, plot(DateTime, PAR, type='l', col="red",
                      axes=FALSE, ann=FALSE))
par(mar=c(5,5,2,5), cex.lab=1.2, cex.axis=0.9)
with(hfemetsubs, plot(DateTime, Tair, type='l',
                      ylim=c(0,20), lwd=2, col="blue",
                      xlab="Time",
                      ylab=expression(T[air]~ ~
                                        (""^"o"*C))))
par(new=TRUE)
with(hfemetsubs, plot(DateTime, PAR, type='l', col="red",
                      lwd=2,
                      ylim=c(0,1000),
                      axes=FALSE, ann=FALSE))
axis(4)
mtext("a",side =4,line=3)
mtext(expression(PAR~ ~
                   (mu*mol~
                      m^-2~
                      s^-1)), side=4, line=3, cex=1.2)
legend("topleft", c(expression(T[air]),"PAR"), lwd=2, col=c("blue","red"),
       bty='n')

##notes about adjusting plots
##Two ways to plot
##Option 1: plot of X and Y
with(data, plot(X,Y))
##Option 2: formula interface (Y 'as a function of' X)
plot(Y ~ X, data=)

##Fine tune formatting with par()
##plot
##combine multiple figures in one plot
##mfrow=c(a,b)
##Set plot size
##mar=c(a,a,b,b)
##mar=c(a,b,c,d)

##axis
##Set axis
##axes=FALSE (no x and y axis)
##Set font size of axis
##cex.axis=num
##Set limit of axis
##xlim=c(num1, num2), breaks=seq(num1, num2, by=num)
##ylim=c(num1, num2)

##axis label
##Set axis label
##xlab = "text"
##xlab = expression()
##xlab = ''   ## (null)
##ann = FALSE (no x and y lab)
##set font size of axis label
##cex.lab=num

##Set line
##width
##lwd=num
##Color
##col=""

##Format units, equations and special symbols
##?plotmath
##examples:
expression(Photosynthesis~ ~(mu*mol~m^-2~s^-1))
expression(Temperature~ ~(degree*C))
expression(T[air]~ ~ (""^"o"*C))
##^represent superscript, []represent subscript
##Network of special characters: https://en.wikipedia.org/wiki/Unicode_symbols
expression(Permille~"\u00A5")

##Adding to a current plot
##method 1
election <- read.csv("dutchelection.csv")
election$Date <- as.Date(election$Date)
##plot the first variable (make sure to set the Y axis range wide enough for all the other data!)
plot(VVD ~ Date, data=election, type='l', col="blue", ylim=c(0,40), ylab="Poll result (%)")
##add the rest of the results, one at a time using points
points(PvdA ~  Date, data=election, type='l', col="red")
points(SP ~   Date, data=election, type='l', col="red", lty=5)
points(GL ~  Date, data=election, type='l', col="forestgreen")
##method 2
plot1
par(new=TRUE)
plot2

##Add a line
##add a vertical line at x=0
abline(v=0)
##add a horizontal line at y=50
abline(h=50)
##add a line with an intercept of 0 and a slope of 1
##(known as a 1:1 line)
abline(0,1)

##Add right y-axis
axis(4)
##add right y-axis label
mtext("a",side =4, line=num)  ##line set the distance of "a" to y-axis

##Add a legend
legend("topleft", expression(bold(A)), bty='n', inset=0.02)  ##bty='n' means no boundary line; inset set the position 
legend("topleft", c("a","b"), lwd=2, col=c("col1","col2"), bty='n')

##special plots
##plot1
cereal <- read.csv("Cereals.csv")
str(cereal)
# Choose colours
# Find the order of factor levels, so that we can assign colours in the same order
levels(cereal$Cold.or.Hot)
cereal$Cold.or.Hot <- as.factor(cereal$Cold.or.Hot)
levels(cereal$Cold.or.Hot)
# We choose blue for cold, red for hot
palette(c("blue","red"))
# Make the plot
with(cereal, symbols(fiber, potass, circles=fat, inches=0.2, bg=Cold.or.Hot,
                     xlab="Fiber content", ylab="Potassium content"))
with(cereal, symbols(fiber, potass, circles=fat, inches=0.2, bg=as.factor(Cold.or.Hot),
                     xlab="Fiber content", ylab="Potassium content"))
##??here with col= can't read color??
with(cereal, symbols(fiber, potass, circles=fat, inches=0.2, col=Cold.or.Hot,
                     xlab="Fiber content", ylab="Potassium content"))
with(cereal, symbols(fiber, potass, circles=fat, inches=0.2, col=as.factor(Cold.or.Hot),
                     xlab="Fiber content", ylab="Potassium content"))
with(cereal, symbols(fiber, potass, circles=protein, inches=0.1, bg=as.factor(Cold.or.Hot),
                     xlab="Fiber content", ylab="Potassium content"))

##plo2
pupae <- read.csv("pupae.csv")
pupae$CO2_treatment <- as.factor(pupae$CO2_treatment)
##a standard plot showing means and 95% confidence limits
install.packages("ggplot2")
library(ggplot2)
install.packages("Hmisc")
library(Hmisc)
palette(c("blue","red"))
ggplot(pupae, aes(x=T_treatment, y=Frass, fill=CO2_treatment)) +
  stat_summary(geom='bar', fun=mean,
##the 'position' argument is used to offset the pars in relation to each other
               position=position_dodge(width=0.9)) +
##add the error bars layer, calculating the standard error for each group
##'width' is the proportion of the width of the bar that the line should extend
  stat_summary(geom='errorbar', fun.data=mean_cl_normal, width=0.25,
               position=position_dodge(width=0.9))

##plot3
##log-log axes
allom <- read.csv("allometry.csv")
head(allom)
# Magic axis package
install.packages("magicaxis")
library(magicaxis)
par(cex.lab=1.2)
##log-log plot of branch mass versus diameter; 
##set axes=FALSE to suppress the axes
with(allom, plot(log10(diameter), log10(branchmass),
                 xlim=log10(c(1,100)),
                 ylim=log10(c(1,1100)),
                 pch=21, bg="lightgrey",
                 xlab="Diameter (cm)", ylab="Branch mass (kg)",
                 axes=FALSE))
with(allom, plot(log10(diameter), log10(branchmass),
                 pch=21, bg="lightgrey",
                 xlab="Diameter (cm)", ylab="Branch mass (kg)",
                 ))
with(allom, plot(log10(diameter), log10(branchmass),
                 xlim=log10(c(1,100)),
                 ylim=log10(c(1,1100)),
                 pch=21, bg="lightgrey",
                 xlab="Diameter (cm)", ylab="Branch mass (kg)",
                 ))
with(allom, plot(diameter, branchmass,
                 pch=21, bg="lightgrey",
                 xlab="Diameter (cm)", ylab="Branch mass (kg)",
                 ))
##add axes: unlog='xy' will make sure the labels are shown in the original scale,
##and we want axes on sides 1 (X) and 2 (Y)
magaxis(unlog='xy', side=c(1,2))
##add a regression line,but only to cover the range of the data.
library(plotrix)
ablineclip(lm(log10(branchmass) ~
                log10(diameter), data=allom),
           x1=min(log10(allom$diameter)),
           x2=max(log10(allom$diameter)))
ablineclip(lm(log10(branchmass) ~
                log10(diameter), data=allom))
##add a box
box()

##plotting with ggplot2
library(ggplot2)
##default scatter plot
##first set up what data are to be plotted
ggplot(allom, aes(x=diameter, y=height, col=species)) +
##then indicate what type of plot should be used
  geom_point()

##change plotting symbols
ggplot(allom, aes(x=diameter, y=height, col=species, shape=species)) +
  geom_point()

ggplot(allom, aes(x=diameter, y=height, col=species, shape=species)) +
  geom_point() +
##set the minimum and maximum values for each axis
  xlim(0, 80) + ylim(0, 50) +
##state the colours to use for the three levels of 'species'
  scale_colour_manual(values=c('blue', 'red', 'forestgreen'))

ggplot(allom, aes(x=diameter, y=height, col=species, shape=species)) +
  geom_point() +
  xlim(0, 80) + ylim(0, 50) +
  scale_colour_manual(values=c('blue', 'red', 'forestgreen')) +
##state the shapes to use for the three levels of 'species'
  scale_shape_manual(values=c(0, 1, 16))

ggplot(allom, aes(x=diameter, y=height, col=species, shape=species)) +
  geom_point() +
  xlim(0, 80) + ylim(0, 50) +
  scale_colour_manual(values=c('blue', 'red', 'forestgreen')) +
  scale_shape_manual(values=c(0, 1, 16)) +
##specify axis labels
  labs(title='Allometric relationships for three tree species',
       x='Tree diameter at breast height (m)', y='Tree height (m)',
       colour='Tree species')

ggplot(allom, aes(x=diameter, y=height, col=species)) +
  geom_point() +
  xlim(0, 80) + ylim(0, 50) +
##change the labels in the colour legend
##note that here use named vectors here
  scale_colour_manual(values=c(PIPO='blue', PIMO='red', PSME='forestgreen'),
                      labels=c(PIMO='P. imo.', PSME='P. sme.', PIPO='P. ipo.')) +
  labs(title='Allometric relationships for three tree species',
       x='Tree diameter at breast height (m)', y='Tree height (m)',
       colour='Tree species')

##layouts with ggplot2
vessel <- read.csv("vessel.csv")
library(ggplot2)
##plot separate histograms (one for 'base' data, one for 'apex' data)
ggplot(vessel, aes(x=vesseldiam)) +
  geom_histogram()+
##seperate two plots
  facet_wrap(~ position)

install.packages("patchwork")
library(patchwork)
##produce three plots and save them as objects
p1 <- ggplot(cereal, aes(x=Manufacturer, y=rating)) + stat_summary(geom='bar', fun=mean) +
  stat_summary(geom='errorbar', fun.data=mean_se, width=0.25)
p2 <- ggplot(vessel, aes(x=vesseldiam, fill=position)) + geom_density(alpha=0.5)
p3 <- ggplot(allom, aes(x=diameter, y=height)) + geom_point() + facet_wrap(~ species, ncol=3)
##plot the panels together, two on one line and one on a second line
(p1 + p2) / p3

##exporting figures
windows(4,4)
par(mar=c(5,5,2,2))
plot(x,y)
dev.copy2pdf(file="Figure1.pdf")
dev.copy2eps(file="Figure1.eps")
##export a large PNG file of the current plot
dev.print(png, file = "myplot.png", width = 1024, height = 768)

