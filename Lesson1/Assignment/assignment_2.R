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

# Select Student.ID, Year, Grade, School on thisyear for ease.


# QC the data.
# How many schools are in the newer enrollment file? Are any missing?

# Do any students do not have an ID? (Hint: You can check is a value is missing with the is.na function.)

# Are there any dublicate students?

# Modify thisyear to include a column that is 1 if
# the student is backfilled and 0 if the student is not.
# Think about the rules of Backfilled when making your flag
# (Hint: You may need to join in the school table.)


# 1. K - 7 can be backfilled
# 2. Enter uncommon at a grade that is not normally entered (ie. not 5, or K)
# 3. BUT feeder schools have backfilling in the 5th grade if not from ES

# MA: anyone in 6,7 and anyone in 5 but not EA
# MS: 6, 7, 8
# ES: not K

##################
# Quick Analysis #
##################
# What is the bacfilled rate by school and grade this year? Last year? 

# What is the difference in backfilled rate by school?
