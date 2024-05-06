# Combine all hpi indicators into 1 dataframe/csv
rm(list=ls())

library(dplyr)

files <- list.files(path='../Data/HPI_indicators', pattern="\\.csv$")
df <- read.csv('../Data/HPI_indicators/census_response.csv')
hpi_df <- df %>%  select(geoid) %>% rename(zipcode = geoid)

for (i in 1:length(files)) {
  filename <- files[i]
  colname <- strsplit(filename, ".csv")[1]
  path <- paste('../Data/HPI_indicators/', filename, sep="")
  df <- read.csv(path)
  df <- df %>% 
    select(geoid, value) %>% 
    setNames(c("zipcode", colname)) 
  hpi_df <- hpi_df %>% full_join(df)
}
write.csv(hpi_df, "../Data/HPI_all.csv", row.names=FALSE)

sum(is.na(hpi_df)) # 20 missing values from 17 rows, in 2 columns 
missing <- hpi_df[!complete.cases(hpi_df), ]
hpi_df2 <- hpi_df %>% select(-preschool, -highschool_enrollment)
sum(is.na(hpi_df2)) # removing 2 columns, so no NA values
write.csv(hpi_df2, "../Data/HPI_clean.csv", row.names=FALSE)

