#First of all we have to prepare our data because there can be NA values,missing data,outliers,and some of the non significant attributes.
#combining both the training and testing dataset for data cleaning and prepartion.

full_data <- rbind(train,test)

#see the structure and summary
str(full_data)
summary(full_data)

#Data type conversion
full_data$Pclass<-as.factor(full_data$Pclass)

#check for the attributes of NA values
#use AMELIA package


install.packages("amelia")
library("amelia")
missmap(full_data,main="missing values")

#Imputing missing values
#Imputing for age:

full_data$Age[is.na(full_data$Age)]<-mean(full_data$Age,na.rm=True)
sum(is.na(full_data$Age))

#Imputing the missing value with the mode

full_data$Embarked[is.na(full_data$Embarked)]<-'S'
sum(is.na(full_data$Embarked))
table(full_data$Embarked,useNA="always")

#Imputing missing values for the Fare
full_data$Fare[is.na(full_data$Fare)]<- mean(full_data$Fare,na.rm=True)
sum(is.na(full_data$Fare))


#percentage of na values in cabin is quite high so it is suitable to drop that attribute
full_data <- full_data[-11]


#again check for the NA values
library("amelia")
missmap(full_data,main="missing values")


#after the cleaning again split the full_data into train and test
train_cleaned<-full_data[1:891,]
test_cleaned<- full_data[892:1309]
