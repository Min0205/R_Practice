###data cleaning, take water potential data as an example
###the needed packages: rio, skimr, janitor, doBy
##import and browse the data
#import
rio::import("EucFACE_tree_health/FACE_PMULTI_RA_waterpotential_L2_20120508-20211214.csv")
test_dat <- read.csv("EucFACE_tree_health/FACE_PMULTI_RA_waterpotential_L2_20120508-20211214.csv")
#browse, skim shows data summary, variable type, and NAs
skimr::skim(test_dat)
##clean colnames
#objectives: as short as possible, 
#            no space, 
#            no special characters, 
#            in similar forms
names(test_dat)
#change colnames automatically
test_dat_cleaned_col <- test_dat %>% janitor::clean_names()
names(test_dat_cleaned_col)
#fine-tuning the colnames
test_dat_cleaned_col <- doBy::renameCol(test_dat_cleaned_col, "campaign_day1", "campaign_day")
names(test_dat_cleaned_col)
#select needed columns
library(dplyr)
co2 <- test_dat_cleaned_col %>% select(co2)
needed1 <- test_dat_cleaned_col %>% select(starts_with("c"))
names(needed1)
needed2 <- test_dat_cleaned_col %>% select(contains("c"))
names(needed2)
needed3 <- test_dat_cleaned_col %>% select(where(is.numeric))
names(needed3)
