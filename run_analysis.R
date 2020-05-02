library(dplyr)

# 1. Merges the training and the test sets to create one data set
trainSet <- read.table("train\\X_train.txt")
testSet <- read.table("test\\X_test.txt")
mergeSet <- rbind(trainSet,testSet)

trainLabel <- read.table("train\\y_train.txt")
testLabel <- read.table("test\\y_test.txt")
mergeLabel <- rbind(trainLabel,testLabel)

subjectTrain <- read.table("train\\subject_train.txt")
subjectTest <-  read.table("test\\subject_test.txt")
mergeSubject <- rbind(subjectTrain,subjectTest)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement
features <- read.table("features.txt") 
ind <- grep("-mean\\(\\)|-std\\(\\)", features$V2)
mergeSet <- mergeSet[,ind]

# 3. Uses descriptive activity names to name the activities in the data set
activityLabels <- read.table("activity_labels.txt")
mergeActvity <- factor(mergeLabel$V1,label=activityLabels$V2)

# 4. Appropriately labels the data set with descriptive variable names
names(mergeSet) <- as.character(features$V2[ind])

# 5. From the data set in step 4, create a second, independent tidy data set
# with the average of each variable for each activity and each subject
avgDataset <- aggregate(x=mergeSet, by=list(mergeSubject$V1,mergeActvity), FUN="mean")
avgDataset <- rename(avgDataset, Subject=Group.1, Activity=Group.2)

# save the tidy data set "avgDataset" to txt
write.table(avgDataset, file = "tidyDataset.txt", row.name=FALSE) 