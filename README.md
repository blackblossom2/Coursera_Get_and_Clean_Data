# Coursera_Get_and_Clean_Data
This repo includes the R script, README.md, CodeBook.md, and tidydata.txt output for Coursera's Getting and Cleaning Data Project. <br> 

Title: "Getting and Cleaning Data Project - Readme"<br>
Author: "Linh Vu"<br>
Date: "11/16/2015"<br>

---
## Files included in this repo:
1. run_analysis.R
2. tidydata.txt
3. CodeBook.md
4. README.md

## run_analysis.R
When sourced, the script would show instructions for downloading, storing, and processing data. It would execute all functions needed to create a tidy data text file that meets the principles of tidydata (Wickham, 2014):
1. Each variable forms a column.
2. Each observation forms a row.
3. Each type of observational unit forms a table.

The independent measurements used to organize tidy data here are the "subjectID" and "activityID" variables. This results in a wide form of tidy data, which serves to report the average of each variable for each activity and each subject.

### Step-by-step execution of script:
0-a. Preparing working environment:
- When sourced, the script starts out by preparing the working environment
- set.wd() sets the working directory
- library() loads needed data and libraries
- if (!file.exists("data")) {dir.create("data")} creates a data folder if it does not exist already
- download.file() and unzip() download and unzip data into above data folder. 
- read.table () reads data into R data frames with appropriate column names using "colnames = " argument.
0-b. Assign appropriate, valid column names before merging:
- labels are read from "features.txt" file using read.table() command
- make.names() command removes invalid characters from labels
- colnames() calls up appropriate column names for re-naming with valid labels
1. Merging data into one main data frames:
- cbind() combines subjectID, activityID, and measurements for the test subset.
- cbind() combines subjectID, activityID, and measurements for the train subset.
- rbind () combines test and train subsets into one data frame.
2. select() command and matches() argument from dplyr package allow R to select only the measurements on the mean and standard deviation for each measurement.
3. Descriptive activity names are used to name the activities in the data set. The corresponding activity names are substituted for the activity numberical code, following "activity_labels.txt" file.
4. Descriptive variable names are used for the data frame. Names follow rules as described in "Codebook.md", "features.txt", and "features_info.txt". Variable names are editted further to increase readibility using the gsub() command:
- "mean" is replaced by "Mean"
- "std" is replaced by "Std"
- "BodyBody" is replaced by "Body"
- "." are removed from all column names to follow camelCase naming convention.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject, using dplyr package chaining: 
- Data is first called and then grouped by subjectID and activityID using group_by()
- Mean is calculated for all variables for each subject and activity as grouped, using summarize() command and funs(mean) as an argument
- Summarized data is sorted again to facilitate viewing using arrange()
- Output is written to disk as "tidydata.txt" using write.table() function with "row.names=FALSE"" as an argument.
 
## Tidy data:
The file is the final output generated using the "run_analysis.R" script. 
It can be read into R with the following command:
        data <- read.table(file_path, header=TRUE)
        View(data)
        
## Supporting files:
1. "CodeBook.md": describes the variables, the data, and  transformations were performed to clean up the data.
2. "README.md" (this file): explains how files in this repo are connected and how the script is designed.


## References:
Hadley Wickham. Tidy data. The Journal of Statistical Software, 14(5), 2014. URL http://vita.had.co.nz/papers/tidy-data.html.
