# Variable selection with stepwise regression
rm(list=ls())

library(dplyr)
library(car)
library(caTools)
library(caret)
library(leaps)
library(MASS)

set.seed(1)

###################################################
print_results <- function(model, test){
  model.summary <- summary(model)
  print(model.summary) 
  print(paste("Training adjusted R2:", round(model.summary$adj.r.squared, 4)))
  
  pred <- exp(predict(model, test))
  actual <- exp(test$Six.Month.Averages)
  n <- nrow(test)
  mae.untranform <-sum(abs(pred-actual)) / n
  print(paste("Test MAE, reversing log tranform: $", round(mae.untranform, 2), sep=""))
  mape <- (sum(abs((actual - pred)/actual))/ n) * 100
  print(paste("Test MAPE, reversing log tranform: ", round(mape, 3), "%", sep=""))
  print("-----------------------------------------")
}

###################################################
# Get and clean data
df <- read.csv('../Data/modified_all_data.csv')
summary(df)
data <- df %>% dplyr::select(-c(zipcode, State, City, Metro, County)) 

# for log-linear model: log transformation of response
data$Six.Month.Averages = log(data$Six.Month.Averages)

# use 80% of data for training and 20% for test
sample <- sample.split(data$Six.Month.Averages, SplitRatio = 0.8)
train  <- subset(data, sample == TRUE)
train.X <- train %>% dplyr::select(-c(Six.Month.Averages))
test   <- subset(data, sample == FALSE)
test.X <- test %>% dplyr::select(-c(Six.Month.Averages))

# Normalize independent variables based on training data 
train.scaled <- scale(train.X)
test.scaled <- scale(test.X, center=attr(train.scaled, "scaled:center"), scale=attr(train.scaled, "scaled:scale"))

Six.Month.Averages <- train$Six.Month.Averages
train.scaled <- as.data.frame(cbind(Six.Month.Averages, train.scaled))

Six.Month.Averages <- test$Six.Month.Averages
test.scaled <- as.data.frame(cbind(Six.Month.Averages, test.scaled))


###################################################
# Naive method (based on p-value)
lm1 <-lm(Six.Month.Averages~., data=train.scaled)                      
summary <- summary(lm1)
summary
summary$adj.r.squared
summary$r.squared
p_values <- summary$coefficients[,4] 
dev.new()
par(mfrow=c(2,2))
plot(lm1)

df.coef <- data.frame(data.frame(matrix(ncol = 1, nrow = length(coef(lm1)))))
colnames(df.coef) <- c("variables")
df.coef$variables <- names(coef(lm1))
df.coef$linear.reg <- round(coef(lm1), 3)

alphas = c(0.05, 0.01)

for (alpha in alphas) {
  print("------------ Naive feature selection ---------------")
  model.name <- paste("Naive_alpha=", alpha, sep="")
  print(model.name)
  significant <- p_values < alpha
  print(paste("Number significant coefficents =",sum(significant))) # 20 values at alpha = 0.5, 6 at alpha = 0.01
  col_names <-unlist(names(p_values)[significant])
  col_names <- col_names[col_names != "(Intercept)"]
  temp.data <- train.scaled %>% dplyr::select(c(Six.Month.Averages, col_names))
  lm2 <-lm(Six.Month.Averages~., data=temp.data)
  # plot(lm2)
  # join to coef data frame
  temp.coef <- data.frame(data.frame(matrix(ncol = 1, nrow = length(coef(lm2)))))
  colnames(temp.coef) <- c(model.name)
  temp.coef[[model.name]] <- round(coef(lm2), 3)
  temp.coef$variables <- names(coef(lm2))
  df.coef <- df.coef %>% left_join(temp.coef)

  print_results(lm2, test.scaled)
}


###################################################
# Step-wise regression: AIC
# based on: https://www.statology.org/stepwise-regression-r/
set.seed(1)
print("Stepwise Regression: AIC")
#define intercept-only model
intercept_only <- lm(Six.Month.Averages ~ 1, data=train.scaled)

#perform stepwise regression
both <- step(intercept_only, direction='both', scope=formula(lm1), trace=0)

#view results of  stepwise regression
both$anova
#view final model
both$coefficients
print(paste("Number coeficents:", length(both$coefficients)))
# plot residuals
plot(both$residuals, main = "Stepwise Regression Residuals", ylab = "Residuals")
par(mfrow=c(2,2))
plot(both)
# join to coef data frame
temp.coef <- data.frame(data.frame(matrix(ncol = 1, nrow = length(coef(both)))))
colnames(temp.coef) <- c("Stepwise Regression")
temp.coef[["Stepwise Regression AIC"]] <- round(coef(both), 3)
temp.coef$variables <- names(coef(both))
df.coef <- df.coef %>% left_join(temp.coef)

print_results(both, test.scaled)

###################################################
# Step-wise regression: BIC
set.seed(1)
print("Stepwise Regression: BIC")
#define intercept-only model
intercept_only <- lm(Six.Month.Averages ~ 1, data=train.scaled)

#perform stepwise regression
both <- step(intercept_only, direction='both', scope=formula(lm1), 
             trace=0, k=log(nrow(train.scaled)))

#view results of  stepwise regression
both$anova
#view final model
both$coefficients
print(paste("Number coeficents:", length(both$coefficients)))
# plot residuals
plot(both$residuals, main = "Stepwise Regression Residuals", ylab = "Residuals")

# join to coef data frame
temp.coef <- data.frame(data.frame(matrix(ncol = 1, nrow = length(coef(both)))))
colnames(temp.coef) <- c("Stepwise Regression")
temp.coef[["Stepwise Regression BIC"]] <- round(coef(both), 3)
temp.coef$variables <- names(coef(both))
df.coef <- df.coef %>% left_join(temp.coef)

print_results(both, test.scaled)

clipr::write_clip(df.coef)
