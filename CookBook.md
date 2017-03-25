# CookBook

## Input Data
The input UCI dataset is extracted directly into `./UCI HAR Dataset/`.

## Output Data
The output dataset is stored in `./UCI HAR Dataset/tidy_data.txt`, which contains 35 observations of 81 variables. The first two variables are suject number(1-30) and activity names. The other variables are extracted from `features.txt` which has the mean or std in their original names.

## Transformation Steps
1. Read data from all txt files.
2. Merge the training and test set, applying the feature name.
3. Merge the training and test labels, replace numbers with activity names.
4. Merge the training and test subjects.
5. Merge all the data.
6. Extract the mean and std to create a new dataset.
7. Create a tidy set with the means grouped by activity/subject.
8. Save the result
