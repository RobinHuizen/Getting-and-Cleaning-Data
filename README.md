# Description of run_analysis.R
NOTE: when loading the files, the destfile, exdir, subject_train_path etc. etc. should be changed according to your local device in order for the R script to work properly
For example: destfile = "C:\\Users\\robin\\Documents\\Coursera\\Module_3\\Course Project\\Dataset.zip" should be change to destfile = "C:\\Users\\yourname\\Documents\\yourpath\\Dataset.zip".

First the code will do the following,
##a.Loading subject_train, X_train and y_train
##b.Giving the columns their names as in features.txt
##c.Adding activity labels to y_train
##d.Merging all three training data sets into one data set

The same will be repeated for the test data sets,
##a.Loading subject_test, X_test and y_test
##b.Giving the columns their names as in features.txt
##c.Adding activity labels to y_test
##d.Merging all three test data sets into one clean data set

Then I follow the 5 step process to create the tidy data set that was requested,
1.Merge the training and the test sets to create one data set
Essential functions that were used: base::rbind()
2.Extract only the measurements on the mean and standard deviation for each measurement
Essential functions that were used: base::grep()
3. Use descriptive activity names to name the activities in the data set (NOTE: this was already done in ##c. Adding activity labels to y_train/y_test)
Essential functions that were used: dplyr::left_join()
4. Giving appropriate labels to the data set with descriptive variable names
Essential functions that were used: base::sub()
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Essential functions that were used: dplyr::group_by(), dplyr::summarize() adn dplyr:across()
