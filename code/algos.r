# applying the logistic regresssion
#removing the column Passengerid,Name and Ticket

logit_model<- glm(Survived ~.,data=train_featured[-c(1,4,9)],family=binomial(link='logit'))

summary(logit_model)

anova(logit_model,test="Chisq")

#predict test data on the basis of trained model

prediction<- predict(logit_model,test_featured,type="response")

#prediction on the BASIS OF PROBABILITIES

prediction<- ifelse(prediction>0.5,1,0)

solution<- data.frame(PassengerId=test_featured$PassengerId,Survived=prediction)

write.csv(solution,file="solution.csv",row.names=FALSE)

---------------------------------------------------------------------------------------------------------------------
# Decision tree model
install.packages("rpart")
install.packages("rattle")
install.packages("RcolorBrewer")
install.packages("rpart.plot")

library(rpart)
library(rattle)
library(RcolorBrewer)
library(rpart.plot)

#making model on the basis of one attribute
tree1<- rpart(Survived ~ Sex,data=train_featured,method="class")
rpart.plot(tree1)
fancyRpartplot(tree1)

prediction1<- predict(tree1,test_featured,type="class")

sol1<- data.frame(PassengerId=test_featured$PassengerId,Survived=prediction1)

write.csv(sol1,file="solution1.csv",row.names=FALSE)


#without the features
tree2<- rpart(Survived ~ Pclass+Sex+Sibsp+Parch+Age+Fare,data=train_featured,method="class")
rpart.plot(tree2)
fancyRpartplot(tree2)
prediction2<- predict(tree2,test_featured,type="class")
sol2<- data.frame(PassengerId=test_featured$PassengerId,Survived=prediction2)
write.csv(sol2,file="solution2.csv",row.names=FALSE)


#with features we added
tree3<- rpart(Survived ~ Pclass+Sex+Sibsp+Parch+Age+Fare+Child+Familysize,data=train_featured,method="class")
fancyRpartplot(tree3)

prediction3<- predict(tree3,test_featured,type="class")
sol3<- data.frame(PassengerId=test_featured$PassengerId,Survived=prediction3)
write.csv(sol3,file="solution3.csv",row.names=FALSE)


tree4<- rpart(Survived ~ Pclass+Sex+Sibsp+Parch+Age+Fare+Child+Familysize,data=train_featured,method="class",control=rpart.control(minsplit=2,cp=0))
fancyRpartplot(tree4)  # very complex tree and it is gone very far

prediction4<- predict(tree4,test_featured,type="class")
sol4<- data.frame(PassengerId=test_featured$PassengerId,Survived=prediction4)
write.csv(sol4,file="solution4.csv",row.names=FALSE) # here we achieved overfitting problem


#handling overfitting problem
printcp(tree4)

#find the cp for which the cross validation error is minimum 
min(tree4$cptable[,"xerror"])
s<-which.min(tree$cptable[,"xerror"])
cpmin<- tree4$cptable[s,"CP"]
cpmin


#pruning of tree
tree5<-prune(tree4,cp=cpmin)
fancyRpartplot(tree5)

prediction5<- predict(tree5,test_featured,type="class")
sol5<- data.frame(PassengerId=test_featured$PassengerId,Survived=prediction5)
write.csv(sol5,file="solution5.csv",row.names=FALSE)


----------------------------------------------------------------------------------------------------------------
# RandomForest Model 
install.packages("randomForest")
library(randomForest)

model<- randomForest(as.factor(Survived) ~ Age+Child+Familysize+Sex+SibSp+Parch+Embarked,data=train_fatured,importance= TRUE,ntree=1000)

#checking the attributes importance
varImpPlot(model)

#prediction on the basis of trained model

my_prediction<- predict(model,test_featured,type="class")

solution<- data.frame(PassengerId=test_featured$PassengerId,Survived=my_prediction)

write.csv(solution,file="solution.csv",row.names=FALSE)

