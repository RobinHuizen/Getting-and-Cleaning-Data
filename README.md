# Description of run_analysis.R

**NOTE:** When loading the files, the file paths should be changed according to your local device...

## Training data processing:
- a. Loading `subject_train`, `X_train` and `y_train`
- b. Naming columns using `features.txt`
- c. Adding activity labels
- d. Merging the training datasets

## Test data processing:
- Same steps repeated as above...

## 5 Steps to Tidy Dataset

1. **Merge** training and test sets  
   _Function used: `base::rbind()`_

2. **Extract** measurements on mean and std  
   _Function used: `base::grep()`_

3. **Use descriptive activity names**  
   _Function used: `dplyr::left_join()`_

4. **Label dataset with descriptive variable names**  
   _Function used: `base::sub()`_
_by(), _`dplyr::summarize()`_ and _`dplyr:across()`_
