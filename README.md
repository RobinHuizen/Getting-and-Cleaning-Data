# Description of run_analysis.R

**NOTE:** When loading the files, the file paths should be changed according to your local device.

## Training data processing:
- a. Loading `subject_train`, `X_train` and `y_train`
- b. Naming columns using `features.txt`
- c. Adding activity labels
- d. Merging the training datasets

## Test data processing:
- Same steps repeated as above but then for `subject_test`, `X_test` and `y_test`

## 5 Steps to Tidy Dataset

1. **Merge** training and test sets  
   _Functions used: `base::rbind()`_

2. **Extract** measurements on mean and std  
   _Functions used: `base::grep()`_

3. **Use** descriptive activity names  
   _Functions used: `dplyr::left_join()`_

4. **Label** dataset with descriptive variable names  
   _Functions used: `base::sub()`_

5. **Create** a second tidy data set with the average of each variable for each activity and each subject  
   _Functions used: `dplyr::group_by()`, `dplyr::summarize()` and `dplyr:across()`_
