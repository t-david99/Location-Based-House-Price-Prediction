
rm(list=ls())

library(dplyr)
library(corrplot)

df <- read.csv("../Data/all_data.csv")

sum(is.na(df))

colnames(df)

summary(df) # shows that we have character columns?

data <- df %>% 
  # dplyr::select(-c(zipcode, State, City, Metro, County)) %>%
  mutate_if(is.character,as.numeric) # census columns are character instead of number

# explore missing values
sum(is.na(data)) # 54 NA values
missing <- data[!complete.cases(data), ] # in 39 rows

# To help address corrplot issues, identified below,
# shorten column names + 
# remove cols with complete overlap, e.g., only need 2 of pop, pop male and pop female)
data <- data %>%
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
         "low_am_interest_rate" = 'low_am_0_median_interest_rate',
         "reg_am_interest_rate" = 'low_am_1_median_interest_rate')

na_cols <- data %>% 
  select_if(function(x) any(is.na(x))) %>% 
  summarise(across(everything(), ~ sum(is.na(.)))) # 5 columns with NA

# Option 1: remove NA cols for correlation testing
data1 <- data %>% dplyr::select(-c(unlist(colnames(na_cols)))) %>% as.data.frame()

# Option 2: remove NA rows 
data2 <- data %>% na.omit()

# Option 3: impute missing values

# # correlation
# names(data1) <- substr(names(data1), 1, 20) # some col names too long for display
# names(data2) <- substr(names(data2), 1, 20) # some col names too long for display

cor.data1 <- cor(data1)
cor.data2 <- cor(data2)
dev.new()
corrplot(cor.data1, type = 'lower')
corrplot(cor.data2, type = 'lower', tl.cex = 0.8)
mtext("Correlation Matrix", at=20, line=-0.5, cex=2)


# Multi-collinearity is an issue: 
# As shown below there are 11 pairs of variables related > 0.9 and 42 > 0.8
# if get rid of the overla columns, reduces to 7 and 30 
length(cor.data2[cor.data2 > 0.8 & cor.data2!= 1]) / 2
length(cor.data2[cor.data2 > 0.9 & cor.data2!= 1]) / 2


