Title: "Getting and Cleaning Data Project - CodeBook"<br>
Author: "Linh Vu"<br>
Date: "11/16/2015"<br>

---

## Project Description
The purpose of this project is to prepare tidy dataset that can be used for later analysis.

## Original Data
The original data was collected from the Human Activity Recognition database, built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone (Samsung Galaxy S II).

Data was captured using the phone's embedded inertial sensors (accelerometer and gyroscope) as 3-axial raw signals, then processed using various signal processing techniques into measurement vectors consisting of 561 features. For more detailed description of the original data set, see "features_info.txt" in the sourced zipped data file below:
- [Source data (zipped file)] (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
- [Description of original dataset] (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
- [Video of experiment](http://www.youtube.com/watch?v=XOEN9W05_4A)


## Creating the tidy data file
### Obtaining raw dataset
1. Download the data from: [source] (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
2. Unzip the data file
3. Read the following data tables into R environment using the command read.table():

Information  | Test subset      | Train subset
-------------|------------------|----------------
Subject ID   | `subject_test`   | `subject_train`
Activity ID  | `Y_test`         | `Y_train`
Measurements | `X_test`         | `X_train`

### Cleaning of the raw data
1. The subject ID, activity ID, and measurements data tables were merged together using cbind() to make the test subset (2947 observations of 563 variables) as well as the train subset (7352 observations of 563 variables). The training and test subsets were combined using rbind() into one single data frame (10299 observations of 563 variables).
2. Only the measurements of the mean and standard deviation were extracted for each measurement. This was achieved using the select(data, matches('expression')) command in the dplyr package.
        - 'mean|std' which selected 86 features of mean and standard deviation from the original dataset
        - subj variable for subject identifiers
        - act variable for activity identifiers
This makes up the 88 variables of the processed raw data set.

### Adding description to the data
Descriptive activity names ("walking", "walking upstairs", "walking downstairs", "sitting", "landing", "laying") were used to replace numerical values in the activity variable, following the "activity_labels.txt" file included with the original zipped dataset.

### Tidy data set
The tidy data set generated ("tidydata.txt") contains the average of all feature mean and standard deviation values from the raw data set.
Original variable names were obtained from the file "features.txt", following naming rules as described in more details in the file "features_info.txt". Both files were included with the original zipped dataset.
Variable names were further modified in the following manner to increase readability using camelCase:
 1. Replaced 'mean' with 'Mean'
 2. Replaced 'std' with 'Std'
 3. Replaced 'BodyBody' with 'Body'
 4. Removed '.' in all column names

#### Sample of tidy data variables compared to original variable names

 Original data                  | Tidy data 
 -------------------------------|---------------------
 `subjectID`                    | `subjectID`
 `activityID`                   | `activityID`
 `tBodyAcc-mean()-X`            | `tBodyAccMeanX`
 `tBodyAcc-mean()-Y`            | `tBodyAccMeanY`
 `tBodyAcc-mean()-Z`            | `tBodyAccMeanZ`
 `tBodyAcc-std()-X`             | `tBodyAccStdX`
 `tBodyAcc-std()-Y`             | `tBodyAccStdY`
 `tBodyAcc-std()-Z`             | `tBodyAccStdZ`
 `fBodyBodyAccJerkMag-mean()`   | `fBodyAccJerkMagMean`
 `fBodyBodyAccJerkMag-std()`    | `fBodyAccJerkMagStd`

For more detailed descriptions of the script used, please see "README.md" file.

## Description of the variables in the "tinydata.txt"" file
 - Dimensions of the dataset: 180 rows, 88 columns
 - As stated above,the file contains the average of all feature mean and standard deviation values of the raw dataset
 - Variables present in the dataset are included below
 
### "subjectID" 
- Unique ID of subjects who performed the experiment
- Integers [1-30], representing 30 subjects

### "activityID"
- Description of activity performed during experiment
- Factors with 6 levels, including "walking", "walking upstairs", "walking downstairs", "sitting", "landing", "laying"

### Mean and standard deviation measurement variables
These are 86 numerical variables reporting the averaged mean and standard deviation of each measurement variable for each subject and each activity.

Naming - Each variable name has 5 levels of descriptor:

1. Prefix 't' to denote time domain signals or 'f' to denote frequency domain signals.
2. 'Body' or 'Gravity' acceleration signal was separated using a low pass Butterworth filter.
3. 'Acc' reports linear acceleration signals; 'ang' reports angular velocity derived; 'Jerk' for jerk signals; 'Gyro' for gyroscope signals.
4. 'Mean' for mean value and 'Std' for standard deviation, estimated from recorded signals.
5. 'X', 'Y', or 'Z' is used to denote 3-axial signals in the X, Y and Z directions.
Please see files "features.txt" and "features_info.txt" for more detailed description of each variable.

Characteristics - measurement variables:

1. Features are normalized and bounded within [-1,1]. 
2. The units used for the accelerations (total and body) (indicated with 'Acc' in variable name) are 'g's (gravity of earth -> 9.80665 m/seg2). 
3. The gyroscope units (indicated with 'Gyr' in variable name) are rad/seg. 

## Sources
[Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
