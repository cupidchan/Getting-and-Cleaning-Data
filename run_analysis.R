# 1) Merges the training and the test sets to create one data set.
# Read the source files
train <- read.table(".\\train\\X_train.txt", header=FALSE)
test <- read.table(".\\test\\X_test.txt", header=FALSE)
subjectTrain <- read.table(".\\train\\subject_train.txt", header=FALSE)
subjectTest <- read.table(".\\test\\subject_test.txt", header=FALSE)
# combine all source files into one data set
merged <- cbind(rbind(train, test), rbind(subjectTrain, subjectTest))
# give the column name for subject. it helps to prevent duplicate column name error in the next section
colnames(merged)[ncol(merged)] <- "subject"

# 2) Extracts only the measurements on the mean and standard deviation for each measurement. 
features <-  read.table(".\\features.txt", header=FALSE)
meanAndStdCol <- filter(features, grepl ("-(mean|std)\\(", V2))
# because feautures do not include "subject", adding this to preserve this ID column
meanAndStdCol <- rbind(meanAndStdCol,data.frame(V1=c(ncol(merged)),V2=c("subject")))
# extract only the required columns
meanAndStd <- select(merged, meanAndStdCol$V1)
# Give the right label to the column names
names(meanAndStd) <- meanAndStdCol$V2

# 3) Uses descriptive activity names to name the activities in the data set
# read in corresponding activities for both training and test data set
# read the activity files 
trainActivtiy <- read.table(".\\train\\y_train.txt", header=FALSE)
testActivity <- read.table(".\\test\\y_test.txt", header=FALSE)
# combine both training and test activities
activity <- rbind(trainActivtiy, testActivity)
# assign an index to the row, which will be used for sorting the right position after merge
activityWithIndex <- cbind(c(1:nrow(activity)), activity)
# give the column name "index"
colnames(activityWithIndex)[1] <- "index"
# read in the activity label from file
activityLabel <- read.table(".\\activity_labels.txt", header=FALSE)
activityWithIndex <- activityWithIndex %>% merge(activityLabel, by = "V1") %>% arrange(index)
# combine the actvity label with the data set
meanAndStd <- cbind(meanAndStd, activityWithIndex$V2)
# give a meaningful name for activity label column
colnames(meanAndStd)[ncol(meanAndStd)] <- "activity"

# 4) Appropriately labels the data set with descriptive variable names. 
names(meanAndStd) <- gsub("\\(|\\)", "",names(meanAndStd))
names(meanAndStd) <- gsub("-std", " StdDev",names(meanAndStd))
names(meanAndStd) <- gsub("-mean", " Mean",names(meanAndStd))
names(meanAndStd) <- gsub("tBodyAcc", "Body Acc (time)",names(meanAndStd))
names(meanAndStd) <- gsub("tGravityAcc", "Gravity Acc (time)",names(meanAndStd))
names(meanAndStd) <- gsub("tBodyAccJerk", "Body Acc Jerk (time)",names(meanAndStd))
names(meanAndStd) <- gsub("tBodyGyro", "body Gyron (time)",names(meanAndStd))
names(meanAndStd) <- gsub("tBodyGyroJerk", "Body Gyro Jerk (time)",names(meanAndStd))
names(meanAndStd) <- gsub("tBodyAccMag", "Body Acc Mag (time)",names(meanAndStd))
names(meanAndStd) <- gsub("tGravityAccMag", "Gravity Acc Mag (time)",names(meanAndStd))
names(meanAndStd) <- gsub("tBodyAccJerkMag", "Body Acc Jerk Mag (time)",names(meanAndStd))
names(meanAndStd) <- gsub("tBodyGyroMag", "Body Gyro Mag (time)",names(meanAndStd))
names(meanAndStd) <- gsub("tBodyGyroJerkMag", "Body Gyro Jerk Mag (time)",names(meanAndStd))
names(meanAndStd) <- gsub("fBodyAcc", "Body Acc (freq)",names(meanAndStd))
names(meanAndStd) <- gsub("fBodyAccJerk", "Body Acc Jerk (freq)",names(meanAndStd))
names(meanAndStd) <- gsub("fBodyGyro", "Body Gyro (freq)",names(meanAndStd))
names(meanAndStd) <- gsub("fBodyAccMag", "Body Acc Mag (freq)",names(meanAndStd))
names(meanAndStd) <- gsub("fBodyAccJerkMag", "Body Acc Jerk Mag (freq)",names(meanAndStd))
names(meanAndStd) <- gsub("fBodyGyroMag", "Body Gyro Mag (freq)",names(meanAndStd))
names(meanAndStd) <- gsub("fBodyGyroJerkMag", "Body Gyro Jerk Mag (freq)",names(meanAndStd))

# 5) From the data set in step 4, creates a second, independent tidy data set with the 
#    average of each variable for each activity and each subject.
#    This will be uploaded as a txt file created with write.table() using row.name=FALSE 
#    Each variable you measure should be in one column, 
#    Each different observation of that variable should be in a different row
activityGroup <- group_by(meanAndStd, activity, subject)
tidyData <- summarise_each(activityGroup, funs(mean))

# Write the tidy data to a file
write.table(tidyData, file="tidyData.txt", row.name=FALSE)