###data cleaning, take water potential data as an example
###the needed packages: rio, skimr, janitor, doBy
##import and browse the data
#import
getwd()
setwd("D:/doc_study/mygit")
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
##clean data
#generate new variables
test_dat_cleaned_col %>% mutate(postive_lwp = -lwp)
#compare and fill columns
preferred_data <- c("a", "b", NA, NA)
alternate_data <- c("a", "c", "a", "d")
data <- coalesce(preferred_data, alternate_data)
data
test_dat_cleaned_col_cleaned_date <- test_dat_cleaned_col %>% mutate(real_date = coalesce(campaign_day, date))
test_dat_cleaned_col_cleaned_date
#use "mutate" and  "case_when" to recode(change the wrong value in columns)
test_dat_cleaned_col_cleaned_date %>% mutate(real_lwp = case_when(
  time == "Morning" ~ -lwp, time == "Midday" ~ lwp, is.na(time) ~ lwp, TRUE ~ NA_real_))
#replace NAs
#??there are null cells in 'comment', but are not identified as NAs.
test_dat_cleaned_col_cleaned_date$date[test_dat_cleaned_col_cleaned_date$date == as.Date("2012-05-08")] <- NA
test_dat_cleaned_col_cleaned_date
change1 <- test_dat_cleaned_col_cleaned_date %>% mutate(date = fct_explicit_na(date, "Missing"))
change2 <- test_dat_cleaned_col_cleaned_date %>% mutate(date = replace_na(date, "None"))
change3 <- test_dat_cleaned_col_cleaned_date %>% mutate(comment = replace_na(comment, "None"))

