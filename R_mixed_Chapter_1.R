##Chapter 1
##example 1: individual-level variation in tree canopy gradients
getwd()
#read the data
pref <- read.csv("prefdata.csv")
head(pref)
unique(pref$species)
#plot to observe general patterns
library(ggplot2)
ggplot(pref, aes(x=dfromtop, y=LMA, colour=species, fill=species)) + 
  geom_point() + 
  geom_smooth(method='lm')
#plot to see whether the relationship between LMA and dfromtop varies from tree to tree
ggplot(pref, aes(x=dfromtop, y=LMA, colour=species)) +
  geom_point() +
  geom_smooth(method='lm', mapping=aes(group=ID), se=FALSE)
#fitting the mixed-effects models
library(lme4)
#random intercept only
m1 <- lmer(LMA ~ species * dfromtop + (1|ID), data = pref)
#random intercept and slope
m2 <- lmer(LMA ~species * dfromtop + (dfromtop|ID), data = pref)
#AIC test for models
AIC(m1, m2)
#likelihood ratio test for models
anova(m1, m2)
#using Anova from 'car' to get p-values of main effects
library(car)
Anova(m1, test = 'F')
summary(m1)
#plot predictions
visreg(m1, "dfromtop", by="species", overlay=TRUE)
#make diagnostic plots
#residuals against fitted values
plot(m1)
#quantile-quantile p
qqPlot(resid(m1))
=======
##Chapter 1
##example 1: individual-level variation in tree canopy gradients
getwd()
#read the data
pref <- read.csv("prefdata.csv")
head(pref)
unique(pref$species)
#plot to observe general patterns
library(ggplot2)
ggplot(pref, aes(x=dfromtop, y=LMA, colour=species, fill=species)) + 
  geom_point() + 
  geom_smooth(method='lm')
#plot to see whether the relationship between LMA and dfromtop varies from tree to tree
ggplot(pref, aes(x=dfromtop, y=LMA, colour=species)) +
  geom_point() +
  geom_smooth(method='lm', mapping=aes(group=ID), se=FALSE)
#fitting the mixed-effects models
library(lme4)
#random intercept only
m1 <- lmer(LMA ~ species * dfromtop + (1|ID), data = pref)
#random intercept and slope
m2 <- lmer(LMA ~species * dfromtop + (dfromtop|ID), data = pref)
#AIC test for models
AIC(m1, m2)
#likelihood ratio test for models
anova(m1, m2)
#using Anova from 'car' to get p-values of main effects
library(car)
Anova(m1, test = 'F')
summary(m1)
#plot predictions
visreg(m1, "dfromtop", by="species", overlay=TRUE)
#make diagnostic plots
#residuals against fitted values
plot(m1)
#quantile-quantile p
qqPlot(resid(m1))
>>>>>>> b17979bcedd580a4844ca015567b60faf1140a28
