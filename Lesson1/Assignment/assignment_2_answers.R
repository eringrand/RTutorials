# In this file you will look at backfilled students in Uncommon Schools.


##########
# Set Up #
##########

# Set your working directory
setwd("S:/Data Analytics/Resource Library/R Help/Assignment/")


# Load packages
library(tidyverse)
library(readxl)

# Define Functions
loaddata <- function(file, sheetname, cn){
  x <- read_excel(file, sheet = sheetname, na = "", col_names = cn)
  valid_column_names <- make.names(names=names(x), unique=TRUE, allow_ = TRUE)
  names(x) <- valid_column_names
  return(x)
}




# Load the Data (fill in these commands)
lastyear <- loaddata("Enrollment.xlsx", 1, T)
thisyear <- loaddata("Enrollment.xlsx", 2, T)
schools <- loaddata("Enrollment.xlsx", 3, T)



#####################
# Data Manipulation #
#####################
# Make sure that each file doesn't have any extra data (other years, other grades, ... etc)



# Create a "Year" column in both data frames 
# set this value to "2015-16" in lastyear and "2016-17" in thisyear
lastyear$Year <- rep("2015-16", nrow(lastyear))
thisyear$Year <- rep("2016-17", nrow(thisyear))

# Select Student.ID, Year, Grade, School on thisyear for ease.
thisyear <- thisyear %>% select(Student.ID, Year, Grade, School)


# QC the data.
# How many schools are in the newer enrollment file? Are any missing?
nrow(thisyear %>% distinct(School))

# Do any students do not have an ID? (Hint: You can check is a value is missing with the is.na function.)
nrow(thisyear %>% filter(is.na(Student.ID)))
nrow(lastyear %>% filter(is.na(Student.ID)))

# Are there any dublicate students?
nrow(thisyear %>% group_by(Student.ID) %>% tally() %>% filter(n > 1))
nrow(lastyear %>% group_by(Student.ID) %>% tally() %>% filter(n > 1))

# Modify thisyear to include a column that is 1 if
# the student is backfilled and 0 if the student is not.
# Think about the rules of Backfilled when making your flag
# (Hint: You may need to join in the school table.)
thisyear <- thisyear %>% left_join(schools, by = c("School" = "School.abbreviation"))

thisyear <- thisyear %>% mutate(
  new_student = ifelse(Student.ID %in% lastyear$Student.ID, 1, 0),
  backfill_MA = ifelse(K.8.School...1.yes..0.no.== 1 & Grade.span=="MS" & new_student == 1, 1, 0),
  backfill_MS = ifelse(K.8.School...1.yes..0.no.== 0  & new_student == 1 & Grade == "5th Grade", 1, 0),
  backfill_ES = ifelse(Grade.span == "ES" & new_student == 1 & Grade != "Kindergarten", 1, 0),
  backfill_this_year = backfill_MA + backfill_MS + backfill_ES
)


##################
# Quick Analysis #
##################
# What is the bacfilled rate by school and grade this year? Last year? 
x <- thisyear %>% group_by(School, Grade) %>% summarise(b2016 = mean(backfill_this_year))
y <- lastyear %>% group_by(School, Grade) %>% summarise(b2015 = mean(ifelse(Backfilled..this.Year. == "N", 0, 1)))

# What is the difference in backfilled rate by school and grade?
z <- inner_join(x, y) %>% mutate(p.diff = (b2016 - b2015) )
