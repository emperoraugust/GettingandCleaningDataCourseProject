########################## run_analysis.R ######################################


## Name Project: Getting and Cleaning Data Project
## Author:       Giacinto Maggiore
## Date:         14/03/2016


## Description:  The script performs the analysis of the data registered from
#                the accelerometers of the Samsung Galaxy S smartphone, for 
#                producing tidy data. 
## Dataset url:  https://d396qusza40orc.cloudfront.net/
#                getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  


################################################################################





# First of all  you must set the working directory in which you want to store 
# data and the results. 

########################### Libraries #########################################

library(httr)       #to use GET
library(dplyr)
library(plyr)





##----- If the dataset is not in the directory "./Data", the script download it


mainDirectory<-getwd()
subDir<-"Data"
dataSetName<-"UCIHARdataSet.zip"
zipFileDest<-file.path(mainDirectory,subDir,dataSetName)
if(!dir.exists(file.path(mainDirectory, subDir))){ 
      dir.create(file.path(mainDirectory, subDir))
}
if(!file.exists(zipFileDest)){
      dataUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
      message("Wait the download of UCIHARDataset.zip (61 Mb) is completed")
      message("A message will advise you")
      GET(dataUrl, user_agent("Mozilla/5.0"), write_disk(zipFileDest))   #GET, unlike download.file, permits to use an user agent
      message("Download Complete")
      message("Wait that the file will be unzipped (62 Mb -> 269 Mb)")
      unzip(zipFileDest,overwrite=TRUE,exdir=subDir)   #unzip the dataset
      message("Unzip completed")
}

##----- Merge the training and the test sets to create one data set
filePath<-"Data/UCI HAR Dataset/"

# Load the train set
trainingData<-tbl_df(read.table(file.path(filePath,"train","X_train.txt")))
trainingLabels<-tbl_df(read.table(file.path(filePath,"train","Y_train.txt")))
subjectTrain<-tbl_df(read.table(file.path(filePath,"train","subject_train.txt")))

# Load the test set
testData<-tbl_df(read.table(file.path(filePath,"test","X_test.txt")))
testLabels<-tbl_df(read.table(file.path(filePath,"test","Y_test.txt")))
subjectTest<-tbl_df(read.table(file.path(filePath,"test","subject_test.txt")))


# Load the features
features <- tbl_df(read.table(file.path(filePath, "features.txt"),colClasses = "character"))
colnames(features)<- c("featureNumber", "featureName")




#------     SECTION 1. Merge the training and test sets 
allSubject <- rbind(subjectTest, subjectTrain)
colnames(allSubject)<-"subject"    #Set the name of the column 
allData<- rbind(testData,trainingData)
#Set the name of the columns that represents features in allData 
colnames(allData) <- features$featureName  
allLabels<-rbind(testLabels,trainingLabels)
colnames(allLabels)<-"activityNumber"   

#Merge data
mergedData<-cbind(allSubject,allLabels)
mergedData<-cbind(data,allData)
mergedData<-tbl_df(mergedData) 



#------    SECTION 2. Extract the measurements on the mean and standard
#                     deviation for each measurement

#First choose only the features that contanin mean() and std()
featuresMeanStd<-grep("mean\\(\\)|std\\(\\)",features$featureName,value=TRUE)  
featuresMeanStd <- union(c("subject","activityNumber"), featuresMeanStd)

#select only the the measurements on the mean and standard deviation
mergedData<- tbl_df(subset(mergedData,select=featuresMeanStd))  





#-------    SECTION 3. Use descriptive activity names to name the activities 
#                      in the data set

# Load the activity labels
activityLabels<-tbl_df(read.table(file.path(filePath,"activity_labels.txt")))
colnames(activityLabels)<-c("activityNumber","activityName")
mergedData<-tbl_df(merge(activityLabels,mergedData,by.x="activityNumber")) #Add Activity Names
mergedData<-select(mergedData,-activityNumber)




#--------   SECTION 4. Label the data set with descriptive variable names

# This section substitute the terms contained in the columns of mergedData with 
# other more readble terms 
names(mergedData)<-gsub("^t", "time", names(mergedData))
names(mergedData)<-gsub("^f", "frequency", names(mergedData))
names(mergedData)<-gsub("Acc", "Accelerometer", names(mergedData))
names(mergedData)<-gsub("Gyro", "Gyroscope", names(mergedData))
names(mergedData)<-gsub("Mag", "Magnitude", names(mergedData))
names(mergedData)<-gsub("std()", "SD", names(mergedData))
names(mergedData)<-gsub("mean()", "MEAN", names(mergedData))
names(mergedData)<-gsub("BodyBody", "Body", names(mergedData))



#-------- SECTION 5. Create a tidy data set with the average of each variable
#                    for each activity and each subject.

secondData <- ddply(mergedData, .(subject, activityName), function(x) colMeans(x[, 3:66])) #library(plyr)
write.table(secondData, "secondData.txt", row.name=FALSE)
