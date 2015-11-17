## Title: Getting and Cleaning Data Project - R script
## Author: Linh Vu
## The following script will download, store, clean and process data to obtain a tiny dataset
## that reports the average of all mean and standard deviation for each measurements, grouped
## by the subject and activity performed.
## For more detailed explanation of the script, please see "README.md". For information about
## variables, please see "CodeBook.md".
## The final processed tiny dataset was written into "tidydata.txt".

## 0-a. Prepare working environment, loading needed data and libraries
        ## Set working environment and load libraries
        setwd("./"); library(dplyr)
        ## Create data folder if it does not exist
        if (!file.exists("data")) {dir.create("data")}
        ## Download file from url
        fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        ## Unzip file to folder
        unzip(download.file(fileUrl, destfile = "./data/data.zip", method="curl"), exdir = "./data/")
        ## Read data tables into appropriate data frames and assign appropriate column names to activity and subject columns
        measurements_test <- read.table ("./data/UCI HAR Dataset/test/X_test.txt")
        activity_test <- read.table ("./data/UCI HAR Dataset/test/Y_test.txt", header = FALSE, col.names = "activityID")
        subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", header = FALSE, col.names = "subjectID")
        measurements_train <- read.table ("./data/UCI HAR Dataset/train/X_train.txt")
        activity_train <- read.table ("./data/UCI HAR Dataset/train/Y_train.txt", header = FALSE, col.names = "activityID")
        subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", header = FALSE, col.names = "subjectID")
        
## 0-b. Assign appropriate, valid column names before merging:
        ## Read all measurement labels into R
        labels <- read.table("./data/UCI HAR Dataset/features.txt")
        ## Get rid of miscellaneous characters in labels to make valid column names
        labels <- make.names(as.list(as.character(labels$V2)), unique = TRUE, allow_ = TRUE)
        ## Add column names to all measurements
        colnames(measurements_test) <- labels; colnames(measurements_train) <- labels

## 1. Merges the training and the test sets to create one data set:
        ## Combine subject, activity, and measurements for test subset
        test <- cbind(subject_test, activity_test, measurements_test)
        ## Combine subject, activity, and measurements for train subset
        train <- cbind(subject_train, activity_train, measurements_train)
        ## Combine test and train subsets into one dataframe
        data <- rbind(test, train)

## 2. Extracts only the measurements on the mean and standard deviation 
## for each measurement. 
        data %>% select(subjectID, activityID, matches('mean|std')) -> data

## 3. Uses descriptive activity names to name the activities in the data set:
        data$activityID[data$activityID == "1"] <- "walking"
        data$activityID[data$activityID == "2"] <- "walking upstairs"
        data$activityID[data$activityID == "3"] <- "walking downstairs"
        data$activityID[data$activityID == "4"] <- "sitting"
        data$activityID[data$activityID == "5"] <- "standing"
        data$activityID[data$activityID == "6"] <- "laying"
 
## 4. Appropriately labels the data set with descriptive variable names. 
        colnames(data) <- gsub("mean", "Mean", colnames(data))
        colnames(data) <- gsub("std", "Std", colnames(data))
        colnames(data) <- gsub("BodyBody", "Body", colnames(data))
        colnames(data) <- gsub("\\.", "", colnames(data))
           
## 5. From the data set in step 4, creates a second, independent tidy data 
## set with the average of each variable for each activity and each subject    
        data %>% 
                ## Group data by subjects and activities
                group_by(subjectID, activityID) %>%
                ## Taking the mean of each measurement based on grouped data
                summarize_each(funs(mean)) %>% 
                ## Sort data by subject and activity
                arrange(subjectID, activityID) %>%
                ## Write output into file
                write.table("./tidydata.txt", row.names=FALSE)
