# Data Issues addressed: 
# 1) Ensure all columns numeric 
# 2) shorten column names 
# 3) Change total population male and female to proportions
# 4) 39 rows removed that had NAs (preferred rows to columns since since NA 
#   were in 5 key columns including the Median earnings ones)
# Data Issues intentionally not addressed:
# 1) For modeling, independent variables will need to be scaled,  
#     not doing here because should be done after train-test split.
# 2) Still colinearity issues that will need to be addressed
rm(list=ls())

library(dplyr)

df <- read.csv("../Data/all_data.csv", header=T, 
               na.strings=c(""," ","NA", "-")) # ensure read cols as numeric

# shorten column names
df <- df %>%
  rename("Population.Total" = "Estimate.Total.Total.population", 
         "Poulation.Male" = "Estimate.Male.Total.population",
         "Population.Female" = "Estimate.Female.Total.population",
         "Median.Earnings.25up" = "Estimate.Total.MEDIAN.EARNINGS.IN.THE.PAST.12.MONTHS..IN.2022.INFLATION.ADJUSTED.DOLLARS..Population.25.years.and.over.with.earnings",
         "Median.Earnings.25up.Male" = "Estimate.Male.MEDIAN.EARNINGS.IN.THE.PAST.12.MONTHS..IN.2022.INFLATION.ADJUSTED.DOLLARS..Population.25.years.and.over.with.earnings",
         "Median.Earnings.25up.Female" = "Estimate.Female.MEDIAN.EARNINGS.IN.THE.PAST.12.MONTHS..IN.2022.INFLATION.ADJUSTED.DOLLARS..Population.25.years.and.over.with.earnings",
         "Labor.Force.Rate.16up" = "Estimate.Labor.Force.Participation.Rate.Population.16.years.and.over",
         "Employment.Ratio.16up" = "Estimate.Employment.Population.Ratio.Population.16.years.and.over",
         "Employment.Ratio.16upMale" = "Estimate.Employment.Population.Ratio.Population.20.to.64.years.SEX.Male",
         "Employment.Ratio.16upFemale" = "Estimate.Employment.Population.Ratio.Population.20.to.64.years.SEX.Female",
         "Unemployment.Rate.16up" = "Estimate.Unemployment.rate.Population.16.years.and.over",
         "Unemployment.Rate.20to64" = "Estimate.Unemployment.rate.Population.20.to.64.years", 
         "Unemployment.Rate.20to64Male" = "Estimate.Unemployment.rate.Population.20.to.64.years.SEX.Male", 
         "Unemployment.Rate.20to64Female" ="Estimate.Unemployment.rate.Population.20.to.64.years.SEX.Female",
         "Unemployment.Rate.Below.Poverty.Level." = "Estimate.Unemployment.rate.Population.20.to.64.years.POVERTY.STATUS.IN.THE.PAST.12.MONTHS.Below.poverty.level",
         "Unemployment.Rate.Above.Poverty.Level" = "Estimate.Unemployment.rate.Population.20.to.64.years.POVERTY.STATUS.IN.THE.PAST.12.MONTHS.At.or.above.the.poverty.level",
         "Unemployment.Rate.Disability"  = "Estimate.Unemployment.rate.Population.20.to.64.years.DISABILITY.STATUS.With.any.disability",
         "Interest_rate_reg_am" = 'low_am_0_median_interest_rate',
         "Interest_rate_low_am" = 'low_am_1_median_interest_rate') 
df <- df %>% 
  mutate(Population.Male.Ratio = Poulation.Male / Population.Total) %>%
  select(-c(Poulation.Male, Population.Female))
colorder <- colnames(df)

# City and Metro both have NA values but we don't want that to disqualify them
id_cols <- df %>% select(zipcode, City, Metro)
df <- df %>% select(-c(City, Metro))
df <- df %>% na.omit() # 39 rows removed, 1250 remaining
df <- df %>% left_join(id_cols) %>% select(all_of(colorder))

write.csv(df, "../Data/modified_all_data.csv", row.names = FALSE)

