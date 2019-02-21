library(ISLR)
library(readxl)
library(dplyr)
library(e1071)
library(xlsx)

data = read_excel('4 Models.xlsx')

summary(data)

train_set = data %>%
              filter(`Test (0), Train (1), OOT (2)` == 1)
              

set.seed(1)
train = train_set[,1:22]

test_set = data %>% filter(`Test (0), Train (1), OOT (2)` == 0)
test =  test_set[,1:22]

oot_set = data %>% filter(`Test (0), Train (1), OOT (2)` == 2)
oot =  oot_set[,1:22]

colnames(data)

svmfit=svm(fraud~., data=train, kernel="linear", cost=10, scale=FALSE)

pred_train = predict(svmfit, train)
train_new = cbind(pred_train, train)

pred_test = predict(svmfit, test)
test_new = cbind(pred_test, test)

pred_oot = predict(svmfit, oot)
oot_new = cbind(pred_oot, oot)

as.data.frame.matrix(train_new) 
as.data.frame.matrix(test_new) 
as.data.frame.matrix(oot_new) 

write.csv(train_new, "svm_train_new.csv")
write.csv(test_new, "svm_test_new.csv")
write.csv(oot_new, "svm_oot_new.csv")

#Linear Regression
linearfit = lm(formula=fraud~., data=train)

pred_train_2 = predict(linearfit, train)
train_new_2 = cbind(pred_train_2, train)

pred_test_2 = predict(linearfit, test)
test_new_2 = cbind(pred_test_2, test)

pred_oot_2 = predict(linearfit, oot)
oot_new_2 = cbind(pred_oot_2, oot)

as.data.frame.matrix(train_new_2) 
as.data.frame.matrix(test_new_2) 
as.data.frame.matrix(oot_new_2) 

write.csv(train_new_2, "linreg_train_new.csv")
write.csv(test_new_2, "linreg_test_new.csv")
write.csv(oot_new_2, "linreg_oot_new.csv")
