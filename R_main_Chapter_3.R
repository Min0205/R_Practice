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

##working with missing values
myvec1 <- c(11,13,5,6,NA,9)
mean(myvec1)
##calculate mean after removing the missing values
mean(myvec1, na.rm=TRUE)
##check if NA exist
is.na(myvec1)
## [1] FALSE FALSE FALSE FALSE TRUE FALSE
##check which of the elements of a vector is missing
which(is.na(myvec1))
##calculate numbers of NA values in a vector
sum(is.na(myvec1))
##make NA values
datavec <- c(2,-9999,100,3,-9999,5)
##assign NA to the values that were -9999
datavec[datavec == -9999] <- NA
datavec
# A character vector, some of these look like numbers:
myvec <- c("101","289","12.3","abc","99")
as.numeric(myvec)
##The warning message NAs introduced by coercion means that missing values were produced by when
##we tried to turn one data type (character) to another (numeric).
log(-1)
##NaN means not a number
1000/0
##case study using 'pupae'
pupae <- read.csv("pupae.csv")
summary(pupae)
pupae_subs1 <- subset(pupae, !is.na(pupae$Gender))
summary(pupae_subs1)
pupae_subs2 <- subset(pupae, !is.na(Frass) & !is.na(Gender))
summary(pupae_subs2)
## A more rigorous subset: remove all rows from a dataset where ANY variable
## has a missing value:
pupae_nona <- pupae[complete.cases(pupae),]
summary(pupae_nona)
##subsetting when there are missing values
dfr2 <- data.frame(a=1:4, b=9:12)
dfr2
dfr <- data.frame(a=1:4, b=c(4,NA,6,NA))
dfr
##subset drops all missing values
subset(dfr, b > 4, select=b)
subset(dfr, b > 2, select=b)
##square bracket notation keeps them
dfr[dfr$b > 4,"b"]
dfr[dfr$b > 2,"b"]
##drop them when we use 'which'
dfr[which(dfr$b > 4),"b"]
dfr[which(dfr$b > 2),"b"]

##Working with text
sentence <- "Not a very long sentence."
nchar(sentence)
substr(sentence, 1, 3)
substr(c("good","good riddance","good on ya"),1,4)
nchar(c("hey","hi","how","ya","doin"))
txt <- c("apple","pear","banana")
paste(txt, "-fruit")
paste(txt, collapse="-")
paste("Question", 1:3, collapse=", ")
paste("Question", 1:3)
##making new variables in a dataframe
pupae$T_CO2 <- with(pupae, paste(T_treatment, CO2_treatment, sep="-"))
##show the first several lines of a data sheet
head(pupae$T_CO2)
##show the last several lines of a data sheet
tail(pupae$T_CO2)
##check NAs
summary(pupae$T_CO2)
##see data type
str(pupae$T_CO2)

##change the names of a dataframe
hydro <- read.csv("hydro.csv")
names(hydro) 
head(hydro)
names(hydro) <- c("Date","Dam_Storage") 
names(hydro)[1] <- "Datum"
names(hydro)
##find out which columns have particular names
match(c("diameter","leafarea"), names(allom))

##working with c/r with complex characters
##keep string as character type
cereal <- read.csv("cereals.csv", stringsAsFactors=FALSE)
##check if certain column or row is character
is.character(cereal$Cereal.name)
cereal <- read.csv("cereals.csv")
cereal$Cereal.name <- as.character(cereal$Cereal.name)
cerealnames <- cereal$Cereal.name
##return the index of values that contain Raisin
grep("Raisin",cerealnames)
##return TRUE or FALSE
grepl("Raisin",cerealnames)
##return the name that contain 'a'
cerealnames[grep("Raisin",cerealnames)]
##"^" means start with
grep("^Raisin",cerealnames)
cerealnames[grep("^Raisin",cerealnames)]
##"$" means end with
grep("Bran$", cerealnames)
grep("BRAN",cerealnames)
##ignore the case-sensitivity
grep("BRAN",cerealnames,ignore.case=TRUE)
cereal$BranOrNot <- grepl("Bran$", cerealnames)
summary(cereal$BranOrNot)

##Working with dates and times
##reading date
library(lubridate)
as.Date("2008-5-22")
as.Date("22-5-2008")
as.Date(dmy("22-5-2008"))
as.Date(dmy("31/12/1991"))
as.Date(dmy("31-12-1991"))
as.Date(mdy("4-17-92"))
as.Date(ymd("1976-5-22"))
as.Date("2011 121", format="%Y %j")
as.Date(ISOdate(2008,12,2))

##calculation
as.Date("2011-5-12") + 7
as.Date("2009-7-1") - as.Date("2008-12-1")
as.Date("2011-3-1") - as.Date("2011-2-27")
as.Date("2012-3-1") - as.Date("2012-2-27")
difftime(as.Date("2009-7-1"), as.Date("2008-12-1"), units = "weeks")
as.Date("2013-8-18") + years(10) + months(1)
##time Qitian Wen and Min Zhao fall in love with each other
difftime(as.Date("2021-9-28"), as.Date("2021-3-28"), units = "hours")
difftime(as.Date("2021-9-28"), as.Date("2021-3-28"), units = "days")
difftime(as.Date("2021-9-28"), as.Date("2021-3-28"), units = "weeks")
today() - as.Date("1996-2-5")
##use dates in a dataframe
hydro <- read.csv("Hydro.csv")
head(hydro)
hydro$Date <- as.Date(dmy(hydro$Date))
head(hydro$Date)
any(is.na(hydro$Date))
myvec1 <- c(11,13,5,6,NA,9)
any(is.na(myvec1))
min(hydro$Date)
max(hydro$Date)
max(hydro$Date) - min(hydro$Date)
with(hydro, plot(Date, storage, type='l'))

