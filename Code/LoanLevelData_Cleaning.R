#Cleaning Freddie Mac loan level data for interest rates
#setwd("C:/Users/krist/OneDrive/Documents/Georgia Tech/2024_Spring_Semester/MGT 6203/Project/Data")


rm(list = ls())
Q1_loans <- read.table("~/Georgia Tech/2024_Spring_Semester/MGT 6203/Project/Data/Freddie_Mac_historical_data_2023Q1.txt", sep = "|", header = FALSE)
Q2_loans <- read.table("~/Georgia Tech/2024_Spring_Semester/MGT 6203/Project/Data/Freddie_Mac_historical_data_2023Q2.txt", sep = "|", header = FALSE)

#Append the two datasets (Q1 and Q2 2023)
Q1_Q2_loans <- rbind(Q1_loans, Q2_loans)


#header names were provided in a different document
header_names <- readxl::read_excel("~/Georgia Tech/2024_Spring_Semester/MGT 6203/Project/Data/Header_Names.xlsx", skip = 1)
new_headers <- header_names$'ATTRIBUTE NAME'
colnames(Q1_Q2_loans) <- new_headers

Q1_Q2_loans_cleaned <- Q1_Q2_loans[, c("Postal Code", "Loan Purpose", "Original Interest Rate", "Original Loan Term", "Property State")]
Q1_Q2_loans_cleaned$LowAm <- ifelse(Q1_Q2_loans_cleaned$`Original Loan Term` < 240, 1, 0)

#Only keeping purchase (refinance would add unnecessary noise)
Q1_Q2_loans_cleaned <-Q1_Q2_loans_cleaned[Q1_Q2_loans_cleaned$`Loan Purpose` == "P", ]
#Only keeping California Property State = CA
Q1_Q2_loans_cleaned <- Q1_Q2_loans_cleaned[Q1_Q2_loans_cleaned$`Property State` == "CA", ]

median_interest_rate <- aggregate(`Original Interest Rate` ~ `Postal Code` + LowAm, data = Q1_Q2_loans_cleaned, median)

colnames(median_interest_rate) <- c("Zip_Code", "LowAm", "Median_Interest_Rate")

write.csv(median_interest_rate, "median_interest_rate.csv", row.names = FALSE)
