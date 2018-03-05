# Set working directory
setwd("S:/Data Analytics/Resource Library/R help")

# Load packages
library(readxl)
library(tidyverse)

# Define Functions
# file = file name, sheetname = sheet number or name, cn = T or F
loaddata <- function(file, sheetname, cn){
  x <- read_excel(file, sheet = sheetname, na = "", col_names = cn)
  valid_column_names <- make.names(names=names(x), unique=TRUE, allow_ = TRUE)
  names(x) <- valid_column_names
  return(x)
}


# Load Data
statetestNYS <- loaddata("S:/Data Analytics/State Test Analysis/2015-2016/New York State Exams/Results Release/Tableau Data Files/Uncommon Student Level Results 15-16.xlsx", "Student Scores", T)

# Look at historical state test profiency by school for ELA and Math in schools
plotdat <- statetestNYS %>% 
  filter(Subject != "Science", Uncommon.school.abbreviation != "UCHS", Grade != 8 ) %>%
  group_by(Year, Uncommon.school.abbreviation, Subject, Grade) %>% 
  summarise(profiency = mean(ifelse(Standard.Achieved %in% c("Level 3", "Level 4"), 1, 0)))


qplot(data = plotdat, x=Year, y=profiency, color=Subject, geom="boxplot",
      facets = Subject~Grade)

