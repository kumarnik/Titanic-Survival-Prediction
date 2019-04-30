
#explore the insights from the data by ggplot2 package 
install.packages(ggplot2)
library(ggplot2)

#mark the significant variables from the data and their dependencies on other variable
#categorical variables
xtabs(~Survived,train_cleaned)

ggplot(train_cleaned)+geom_bar(aes(x=Sex))
ggplot(train_cleaned)+geom_bar(aes(x=Survived))
ggplot(train_cleaned)+geom_bar(aes(x=Embarked))
ggplot(train_cleaned)+geom_bar(aes(x=Pclass))
ggplot(train_cleaned)+geom_bar(aes(x=Parch))


#numerical variable
ggplot(train_cleaned)+geom_histogram(aes(x=Fare),fill="yellow",color="red",bins=30)
ggplot(train_cleaned)+geom_histogram(aes(x=Age),fill="white",color="black",bins=30)


#bivariate EDA,categorical-categorical analysis
xtabs(~Survived+Pclass,train_cleaned)
xtabs(~Survived+Sex,train_cleaned)
xtabs(~Survived+Embarked,train_cleaned)

ggplot(train_cleaned)+geom_bar(aes(x=Pclass,fill=factor(Survived))
ggplot(train_cleaned)+geom_bar(aes(x=Sex,fill=factor(Survived)))
ggplot(train_cleaned)+geom_bar(aes(x=Embarked,fill=factor(Survived)))

#numerical-categorical analysis
ggplot(train_cleaned)+geom_boxplot(aes(x=factor(Survived),y=Age))
ggplot(train_cleaned)+geom_boxplot(aes(x=factor(Survived),y=Fare))


#multivariate analysis
xtabs(~Survived+Pclass+Sex,train_cleaned)
xtabs(~Survived+Embarked+Sex,train_cleaned)
