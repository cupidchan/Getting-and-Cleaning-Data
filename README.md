# Getting-and-Cleaning-Data

The script “run_analysis.R” utilizes a data set collected from the accelerometers from the Samsung Galaxy S smartphone by merging the training and the test sets to create one data set. It includes only the measurements on the mean and standard deviation for each measurement. It changes the activity ID to descriptive activity names to name the activities in the data set. It also labels the data set with descriptive variable names, followed by creating a second, independent tidy data set with the average of each variable for each activity and each subject. 

The final result is saved in a file called “tidayData.txt” and the detailed description of each variable is listed in **Cookbook.md** in this repo.

In order to run this script, you need to set the working directory to be the root of the data set and have the following files and folder structure under it:

* 'features_info.txt': Shows information about the variables used on the feature vector.
* 'features.txt': List of all features.
* 'activity_labels.txt': Links the class labels with their activity name.
* 'train/X_train.txt': Training set.
* 'train/y_train.txt': Training labels.
* 'test/X_test.txt': Test set.
* 'test/y_test.txt': Test labels.
* 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
* 'test/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
