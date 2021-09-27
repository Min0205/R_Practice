##working with factors
##'pupae' part
pupae <- read.csv("pupae.csv")
##show the structure of data sheet
str(pupae) 
##convert data type to factor
pupae$CO2_treatment <- as.factor(pupae$CO2_treatment)
str(pupae)
pupae$T_treatment <- as.factor(pupae$T_treatment)
table(pupae$T_treatment)
##keep only the 'ambient' treatment
pupae_amb <- subset(pupae, T_treatment == "ambient")
table(pupae_amb$T_treatment)
##delete the levels that contain 0 value
pupae_amb2 <- droplevels(pupae_amb)
str(pupae_amb)
str(pupae_amb2)
table(pupae_amb$T_treatment)
table(pupae_amb2$T_treatment)
##assign the level of a factor accordingly
levels(pupae$T_treatment) <- c("Ambient","Ambient + 3C")
table(pupae$T_treatment)
levels(pupae$T_treatment) <- c("Ambient + 3C","Ambient")
table(pupae$T_treatment)
##assign the first level of a factor
levels(pupae$T_treatment)[1] <- "Control"
table(pupae$T_treatment)

##'allom' part
allom <- read.csv("Allometry.csv")
str(allom)
##convert 'species' to factor
allom$species <- as.factor(allom$species)
str(allom)
##show the levels of the data frame
levels(allom$species)
##show the levels and count the number of rows in the data frame
table(allom$species)
##convert 'species' to factor logically
allom$species <- factor(allom$species, levels=c("PSME","PIMO","PIPO"))
##onvert 'species' to factor according to value
allom$treeSizeClass <- factor(ifelse(allom$diameter < 10, "small", "large"))
table(allom$treeSizeClass)
allom$treeSizeClass <- cut(allom$diameter, breaks=c(0,25,50,75),labels=c("small","medium","large"))
table(allom$treeSizeClass)

##logical data
10 > 5
##equal
101 == 100 + 1
apple <- 2
pear <- 3
apple == pear
##not equal
apple != pear
101 != 100 + 1
## Logical comparisons like these also work for vectors, for example:
nums <- c(10,21,5,6,0,1,12)
nums > 5
## Find which of the numbers are larger than 5:
which(nums > 5)
any(nums > 25)
any(nums > 20)
# Are all numbers less than or equal to 10?
all(nums <= 10)
all(nums <= 25)
pupae_bigpupal <- subset(pupae, PupalWeight > 0.4)
str(pupae_bigpupal)
##use & for AND to take subsets where two conditions are met
subset(pupae, PupalWeight > 0.4 & Frass > 3)
## use | for OR
nums[nums < 2 | nums > 20]
## How many numbers are larger than 5?
##- Short solution
sum(nums > 5)
sum(nums)
##- Long solution
nums <- c(10,21,5,6,0,1,12)
length(nums)
length(nums[nums > 5])