library(dplyr)
data=read.csv('project2result.csv')

data1=select(data,fraud)

nrow(data1)/100
a=158

tot_fraud=sum(data1)

Random=data.frame()
sample=rep(1:25)
for( i in sample){
  
  Random[i,1]=sum(data1[(a*(i-1)+1):(a*i),]) #fraud
  Random[i,2]=a-Random[i,1]   
  Random[i,3]=Random[i,1]/a
  Random[i,4]=Random[i,2]/a
}
str(data)
colnames(data)[2]='lp'
colnames(data)[3]='nn'
colnames(data)[4]='bt'
colnames(data)[5]='bf'
colnames(data)[6]='svm'
data2=data%>%select(c(1,5))%>%arrange(-bf)

model=data.frame()
for( i in sample){
  
  model[i,1]=sum(data2[1:(a*i),1])
  model[i,2]=i*a-model[i,1]
  model[i,3]=100*(model[i,1]/tot_fraud)
  model[i,4]=100*(model[i,2]/(nrow(data)-tot_fraud))
  model[i,5]=model[i,3]-model[i,4]
  model[i,6]=model[i,2]/model[i,1]
}


write.csv(model,'model.csv')
write.csv(Random,'random.csv')
