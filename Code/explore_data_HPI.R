# DAB Team Project Spring 2024
# Team 1
# Initial investigation of California Healthy Places Index (HPI) dataset
rm(list=ls())

library(dplyr)
library(summarytools)
library(corrplot)

hpi_scores <- read.csv("../Data/hpiscore_zipcode.csv", header = TRUE)
# note numerator, denominator and se columns are all empty, 
# and name is identical to geoid
hpi_scores <- hpi_scores %>% select(-c(numerator, denominator, se, name))
# confirm geoid (zip) is unique
length(unique(hpi_scores$geoid)) == nrow(hpi_scores)

view(dfSummary(hpi_scores), file = "../Data/Data_info/hpi_score_summary.html")

# for report 
scores <- hpi_scores %>% select(value, percentile)
view(dfSummary(scores))

# example of just 1 indicator (air quality) by city/town
air <- read.csv("../Data/pm25_city.csv", header = TRUE)
air <- air %>% select(-c(numerator, denominator, se))
view(dfSummary(air), file = "../Data/Data_info/pm25_by_city_summary.html")

# example of just 1 indicator (tree cover) by county
tree <- read.csv("../Data/treecanopy_county.csv", header = TRUE)
tree <- tree %>% select(-c(numerator, denominator, se))
view(dfSummary(tree), file = "../Data/Data_info/tree_by_couty_summary.html")


## explore new combined dataset with all indicatres
hpi <- read.csv("../Data/HPI_clean.csv", header = TRUE)
view(dfSummary(hpi), file = "../Data/Data_info/hpi_indicators_summary.html")

hpi.cor = cor(hpi)
corrplot(hpi.cor) # surprisingly less correlation that I expected
