##
###
# try improve by only scale census + interest cols -> not help
# use 80% of data for training and 20% for test
sample <- sample.split(data$Six.Month.Averages, SplitRatio = 0.8)
train  <- subset(data, sample == TRUE)
test   <- subset(data, sample == FALSE)

# Normalize independent variables based on training data 
temp <- train[,1:30]
train.scaled <- scale(train[,31:48])
train <- as.data.frame(cbind(temp, train.scaled))

temp <- test[,1:30]
test.scaled <- scale(test[,31:48], center=attr(train.scaled, "scaled:center"), scale=attr(train.scaled, "scaled:scale"))
test<- as.data.frame(cbind(temp, test.scaled))