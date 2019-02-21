# get train test and out of time dataset

library(dplyr)
data=readRDS("expert variables")
View(data)
names(data)
data=data%>%
  select(starts_with("same"),"fraud")%>%
  select(ends_with("x"),"fraud")
# seperate dataset
numberofmonth=round(nrow(data)/12)
# out of time
row=nrow(data)
oot=data[c((row-2*numberofmonth+1):row),]
# train and test
tt=data[c(1:(row-2*numberofmonth)),]
tt=tt[sample(nrow(tt),nrow(tt)),]
numberofmonth=round(nrow(tt)/10)
train=tt[c(1:(6*numberofmonth)),]
test=tt[c((6*numberofmonth+1):nrow(tt)),]
# check 
nrow(tt)==nrow(train)+nrow(test)

write.csv(train, "train.csv",row.names = FALSE)
saveRDS(train, "train.rds")
saveRDS(test,"test.rds")
saveRDS(oot,"oot.rds")
