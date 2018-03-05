  
#Download packages and datasets
list.of.packages <- c("nycflights13", 
                      "gapminder", 
                      "Lahman", 
                      "tidyverse", 
                      "readxl", 
                      "fivethirtyeight", 
                      "praise",
                      "giphyr",
                      "caret",
                      "MASS",
                      "DT")

new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages) > 0) install.packages(new.packages)


# set system langaue to english, just in case
Sys.setenv(LANGUAGE = "en")

rm(list = ls())

# library(readxl)
# 
# # Define A Load Data Functions
# loaddata <- function(file, sheetname, cn){
#   x <- read_excel(file, sheet = sheetname, na = "", col_names = cn)
#   valid_column_names <- make.names(names=names(x), unique=TRUE, allow_ = TRUE)
#   names(x) <- valid_column_names
#   return(x)
# }
# 
# # Load the Data (fill in these commands)
# thisyearEnrollment <- read.csv("S:/Data Analytics/Interim Assessments/SY16-17/R/Input/Current_Year_Enrollment_Q3.csv", header=TRUE, stringsAsFactors = FALSE, na.strings=c("","NA"))
# schoolMap <- loaddata("S:/Data Analytics/Resource Library/R Help/Assignment/Enrollment.xlsx", 3, T)
# 
# 
# IAdata <- "S:/Data Analytics/Interim Assessments/SY15-16/Source files/Tableau/Raw Data_v1_SY1516_upload.xlsx"
# coltypes <- rep("text", 23)
# coltypes[c(13, 20, 21)] <- "numeric"
# IAs <- read_excel(IAdata, "Student IA Results", col_names=T, col_types=coltypes)
# valid_column_names <- make.names(names=names(IAs), unique=TRUE, allow_ = TRUE)
# names(IAs) <- valid_column_names
# 
# assessMap <- loaddata(IAdata, "Assessment mapping", T) %>%
#   select(Assessment.Name:Year)
# 
# saveRDS(IAs, "S:/Data Analytics/Resource Library/R Help/data/IAs.rds")
# saveRDS(assessMap, "S:/Data Analytics/Resource Library/R Help/data/assessMap.rds")
# saveRDS(schoolMap, "S:/Data Analytics/Resource Library/R Help/data/schoolMap.rds")
# saveRDS(thisyearEnrollment, "S:/Data Analytics/Resource Library/R Help/data/thisyearEnrollment.rds")
# 
# rm(list = ls())

IAs <- readRDS("S:/Data Analytics/Resource Library/R Help/data/IAs.rds")
assessMap <- readRDS("S:/Data Analytics/Resource Library/R Help/data/assessMap.rds")
schoolMap <- readRDS("S:/Data Analytics/Resource Library/R Help/data/schoolMap.rds")
thisyearEnrollment <- readRDS("S:/Data Analytics/Resource Library/R Help/data/thisyearEnrollment.rds")

# library(beepr)
library(praise)
# beepr::beep()
praise::praise()