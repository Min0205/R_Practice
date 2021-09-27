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