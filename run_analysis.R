##Loading necessary packages
library(dplyr)

##Download zip file
##NOTE: when loading the files, the destfile, exdir, subject_train_path etc. etc. should be changed according to your local device
## in order for the R script to work properly
zipURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
destfile = "C:\\Users\\robin\\Documents\\Coursera\\Module_3\\Course Project\\Dataset.zip"
download.file(zipURL, destfile)
unzip(destfile, exdir = "C:\\Users\\robin\\Documents\\Coursera\\Module_3\\Course Project")

##a.Loading subject_train, X_train and y_train
##b.Giving the columns their names as in features.txt
##c.Adding activity labels to y_train
##d.Merging all three training data sets into one data set

subject_train_path <- "C:\\Users\\robin\\Documents\\Coursera\\Module_3\\Course Project\\UCI HAR Dataset\\train\\subject_train.txt"
subject_train <- read.table(subject_train_path)
names(subject_train) <- "subject_id"

X_train_path <- "C:\\Users\\robin\\Documents\\Coursera\\Module_3\\Course Project\\UCI HAR Dataset\\train\\X_train.txt"
X_train <- read.table(X_train_path)

features_path <- "C:\\Users\\robin\\Documents\\Coursera\\Module_3\\Course Project\\UCI HAR Dataset\\features.txt"
features <- read.table(features_path)
features <- features[,-1]
names(X_train) <- features

y_train_path <- "C:\\Users\\robin\\Documents\\Coursera\\Module_3\\Course Project\\UCI HAR Dataset\\train\\y_train.txt"
y_train <- read.table(y_train_path)
names(y_train) <- "activity_id"

activity_labels_path <- "C:\\Users\\robin\\Documents\\Coursera\\Module_3\\Course Project\\UCI HAR Dataset\\activity_labels.txt"
activity_labels <- read.table(activity_labels_path)
names(activity_labels) <- c("activity_id", "activity_label")

y_train_labeled <- left_join(y_train, activity_labels, 
                         by = "activity_id")

df_train <- cbind(subject_train, y_train_labeled$activity_label, X_train)
names(df_train)[2] <- "activity_label"

##a.Loading subject_test, X_test and y_test
##b.Giving the columns their names as in features.txt
##c.Adding activity labels to y_test
##d.Merging all three test data sets into one clean data set

subject_test_path <- "C:\\Users\\robin\\Documents\\Coursera\\Module_3\\Course Project\\UCI HAR Dataset\\test\\subject_test.txt"
subject_test <- read.table(subject_test_path)
names(subject_test) <- "subject_id"

X_test_path <- "C:\\Users\\robin\\Documents\\Coursera\\Module_3\\Course Project\\UCI HAR Dataset\\test\\X_test.txt"
X_test <- read.table(X_test_path)
names(X_test) <- features #features.txt is already loaded

y_test_path <- "C:\\Users\\robin\\Documents\\Coursera\\Module_3\\Course Project\\UCI HAR Dataset\\test\\y_test.txt"
y_test <- read.table(y_test_path)
names(y_test) <- "activity_id"

y_test_labeled <- left_join(y_test, activity_labels, 
                             by = "activity_id")

df_test <- cbind(subject_test, y_test_labeled$activity_label, X_test)
names(df_test)[2] <- "activity_label"

###################################################################
## 1.Merge the training and the test sets to create one data set ##
###################################################################

df <- rbind(df_train, df_test)

#############################################################################################
## 2.Extract only the measurements on the mean and standard deviation for each measurement ##
#############################################################################################

mean_std_features <- grep("mean\\(\\)|std\\(\\)", features, value = TRUE)
df <- df[,c("subject_id", "activity_label",mean_std_features)]

df <- arrange(df, subject_id)

##############################################################################
## 3. Use descriptive activity names to name the activities in the data set ##
##############################################################################

##I have labeled the activities already in the code above
##See y_train_labeled/y_test_labeled

##################################################################################
## 4. Giving appropriate labels to the data set with descriptive variable names ##
##################################################################################

names(df)[3:68] <- sub("^t", "Time",names(df)[3:68])
names(df)[3:68] <- sub("^f", "Frequency",names(df)[3:68])
names(df)[3:68] <- sub("Acc", "Acceleration", names(df)[3:68])
names(df)[3:68] <- sub("-std\\(\\)-", "Std", names(df)[3:68])
names(df)[3:68] <- sub("-std\\(\\)", "Std", names(df)[3:68])
names(df)[3:68] <- sub("-mean\\(\\)-", "Mean", names(df)[3:68])
names(df)[3:68] <- sub("-mean\\(\\)", "Mean", names(df)[3:68])
names(df)[3:68] <- sub("Gyro", "Gyroscope", names(df)[3:68])
names(df)[3:68] <- sub("Mag", "Magnitude", names(df)[3:68])
names(df)[3:68] <- sub("BodyBody", "Body", names(df)[3:68])

##########################################################################################
## 5. From the data set in step 4, create a second, independent tidy data set with the  ##
## average of each variable for each activity and each subject.                         ##
##########################################################################################

df_summarized <- df %>% group_by(activity_label, subject_id) %>% 
        summarize(across(where(is.numeric), mean))

write.table(df_summarized, file = "tidy_data.txt", row.names = FALSE)
