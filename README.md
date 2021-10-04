# Human-Activity-Recognition-Using-Smartphones-Dataset---Tidy-Data-Project

README - HUMAN ACTIVITY RECOGNITION USING SMARTPHONES DATASET

Problem Summary:
There is strong interest from companies like Fitbit, Nike, and Jawbone Up in wearable computing and they are developing advanced algorithms to attract new users. For proof of this capability, data has been collected from the accelerometers and gyrocopes of a Samsung Galaxy S smartphone. Steps are taken to process the collected data. A portion of the collected data is made accessible in a tidy data format by subject id and activity name.

Repository Contents:
Human Activity Recognition database has been built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.

File Name			              Description

activity_labels			        Links the class labels (integers) with their descriptive activity name.

CODE BOOK – HUMAN 	        Notes on study design, data dictionary and dataset
ACTIVITY RECOGNITION	      contents and structure. 
USING SMARTPHONES 
DATASET

features			              List of all features variables.

features_info			          Shows information about the variables used on the feature vector.

README.md			              Documentation explaining the project and how to use files 
                            contained in the repository.

subject_test			          Each row identifies the subject who performed the activity for test 
                            window sample. Its range is from 1 to 30.

subject_train			          Each row identifies the subject who performed the activity for train 
                            window sample. Its range is from 1 to 30.

X_test				              Test set.

X_train				              Training set. 

y_test				              Test labels.

y_train				              Train labels.

The Process (Instruction List):

To build a data frame table that contains mean values grouped first by subject identifier and then by activity label from the raw data files as listed in the repository contents, steps must be completed as described below. The script or code generates a text data file that meets the principles of tidy data:

1.	Read in test and train data sets and their corresponding data sets for activity label numbers and subject identifiers. Also read in the data sets for feature variable names and descriptive activity labels.

The code is the following:

X_test <- read.table("E:\\Drive E\\Coursera\\Getting and Cleaning Data\\Week 4\\Getting and Cleaning Data Course Project\\UCI HAR Dataset\\test\\X_test.txt", header=FALSE, fill=TRUE)

y_test <- read.table("E:\\Drive E\\Coursera\\Getting and Cleaning Data\\Week 4\\Getting and Cleaning Data Course Project\\UCI HAR Dataset\\test\\y_test.txt", header=FALSE)
subject_test <- read.table("E:\\Drive E\\Coursera\\Getting and Cleaning Data\\Week 4\\Getting and Cleaning Data Course Project\\UCI HAR Dataset\\test\\subject_test.txt", header=FALSE)

subject_train <- read.table("E:\\Drive E\\Coursera\\Getting and Cleaning Data\\Week 4\\Getting and Cleaning Data Course Project\\UCI HAR Dataset\\train\\subject_train.txt", header=FALSE)

X_train <- read.table("E:\\Drive E\\Coursera\\Getting and Cleaning Data\\Week 4\\Getting and Cleaning Data Course Project\\UCI HAR Dataset\\train\\X_train.txt", header=FALSE, fill=TRUE)

y_train <- read.table("E:\\Drive E\\Coursera\\Getting and Cleaning Data\\Week 4\\Getting and Cleaning Data Course Project\\UCI HAR Dataset\\train\\y_train.txt", header=FALSE)
features <- read.table("E:\\Drive E\\Coursera\\Getting and Cleaning Data\\Week 4\\Getting and Cleaning Data Course Project\\UCI HAR Dataset\\features.txt", header=FALSE, stringsAsFactors=FALSE)

activity <- read.table("E:\\Drive E\\Coursera\\Getting and Cleaning Data\\Week 4\\Getting and Cleaning Data Course Project\\UCI HAR Dataset\\activity_labels.txt", header=FALSE, stringsAsFactors=FALSE)

2.	Combine by binding data set rows for each of the following: the test and train data sets, the test and train activity numbers and the test and train subject identifiers.

The code is the following:

## Combine by binding data set rows using rbind( )  

X_bind <- rbind(X_test, X_train)

y_bind <- rbind(y_test, y_train)

subject_bind <- rbind(subject_test, subject_train)

3.	Make the variable names of the features dataset as column headers for the combined test/train data set.

The code is the following:

## make a vector from 2nd column of the features data frame

avector <- as.vector(features[ , 2])  

## use make.names( ) function to create syntactically valid and unique names out of the character vector.

avector2 <- make.names(avector, unique = TRUE)

## assign features variable names to the combined test/train data set

colnames(X_bind) <- avector2  

4.	Modify test/train data set from step 3 to only include feature variables with mean and standard deviation values.

The code is the following:

## use grep( ) function to create a vector of column names with only mean and standard deviation

selectVector <- grep("mean|std", names(X_bind), ignore.case=FALSE)

## subset combined test/train data set for variable names with only mean and standard deviation. 

X_bind1 <- X_bind[ , selectVector]

## create a vector with TRUE or FALSE values based on variable names with "meanFreq" in test/train data set

selectVectorF <- !grepl("meanFreq", names(X_bind1), ignore.case=FALSE)

## confirm quantity of respective TRUE and FALSE values. 66 TRUE and 13 FALSE
## FALSE indicates "meanFreq" is in variable name and TRUE indicates "meanFreq" is 
## not in the variable name. 

table(selectVectorF)

## subset combined test/train data set for variable names with only TRUE values in the 
## vector indicated "meanFreq" is not in the variable name. 

X_bind2 <- X_bind1[ , selectVectorF]

5.	Complete the data set in step 4 by adding columns from combined test/train activity labels and test/train subject identifiers.

The code is the following:

## Combine by binding data set columns of the test/train data set and the activity label number data set. 

pre_tidy1 <- cbind(y_bind, X_bind2)

## Combine by binding data set columns for the data set in the previous step with the subject identifier data set. 

pre_tidy2 <- cbind(subject_bind, pre_tidy1)

6.	For more descriptive activity names to the data set, merge the activity labels data set with the data set from step 5. 

The code is the following:

## Merge the data set from the previous step with descriptive activity label data set using ## a key column of activity label number shared by both data sets.  

merged_Data = merge(pre_tidy2, activity, by.x=2, by.y=1, all=TRUE)

## warning message: column name ‘V1’ is duplicated in the result

7.	Remove unneeded activity label number column from the data set. Also, reorder columns, subject identifier column is first, followed by descriptive activity label and then the rest of the feature variables. 

The code is the following:

## Subset columns using a vector identifying specific columns in a specific order. 
## Column 1 has activity label numbers that will be discarded since it is not selected. 
## Column 2 has subject identifier. Column 69 has activity label names. Columns 3:68 ## has feature variables. 

pre_tidy3 <- merged_Data[ , c(2, 69, 3:68)]

8.	Updated column names of the data set to be more descriptive and remove repetitive typo. Added periods to separate descriptive tokens in the feature column names. Removed extra periods and made all variable or column names lowercase. The result is the first tidy data set.   

The code is the following:

## special characters of (, ), _ and – removed with make.names() command in step 3.

## Updated column or variable names in the data set.

colnames(pre_tidy3)[1] <- "subject.id"

colnames(pre_tidy3)[2] <- "activity.label"

## Used tolower( ) function to make all column or variable names have lowercase 
## letters.
 
colnames(pre_tidy3) <- tolower(names(pre_tidy3))

## Used sub( ) command to update column or variable names from a vector of column ## names taken from data set using names( ) function. The metacharacter of ^ 
## represents start of a line of text and + or plus sign means at least one of the item. The ## escape character of \\ ensures the dot or period is not recognized as a 
## metacharacter. Used colnames( ) function to apply updated vector of names to the 
## data set. 

freq <- sub("^f+", "freq.", names(pre_tidy3))

time <- sub("^t+", "time.", freq)

body <- sub("body+", "body.", time)

body2 <- sub("body.body+", "body.", body)

gravity <- sub("gravity+", "gravity.", body2)

jerk <- sub("jerk+", ".jerk", gravity)

mag <- sub("mag+", ".mag", jerk)

periods <- sub("\\.\\.", "", mag)

colnames(pre_tidy3) <- periods

## renamed dataset to tidy1 to recognize it as first tidy set. 

tidy1 <- pre_tidy3

## Need to install and load dplyr package in order to use tbl_df function. 

install.packages("dplyr")

library(dplyr)

tidy1 <- tbl_df(tidy1) ## convert the data frame to a data frame table. 

9.	Created a 2nd tidy data step by grouping by subject id and activity label and finding the average for each feature variable in the data set.   

The code is the following:

## Need to install and load dplyr package in order to use %>% and summarise_each( ) functions. 

## Create 2nd tidy data set with summary data grouped by subject identifier and 
## descriptive activity label. The summary data is an average using the mean( ) function. 

tidy2 <- group_by(tidy1, subject.id, activity.label) %>% summarise_each(funs(mean), "time.body.acc.mean.x" : "freq.body.gyro.jerk.mag.std")

10.	Created a text file named tidy2RM.txt from the tidy2 data set. 

The code is the following:

## Use write.table( ) function to produce a text file that is saved locally named 
## tidy2RM.txt. A character vector of row names is not written. Column names are 
## included but not in quotes. Values are in a single space-delimited text file. 

write.table(tidy2, file="E:\\Drive E\\Coursera\\Getting and Cleaning Data\\Week 4\\Getting and Cleaning Data Course Project\\UCI HAR Dataset\\tidy2RM.txt", row.names=FALSE, col.names=TRUE, sep=" ", quote=FALSE)

11.	Read in the saved tidy2RM.txt file and viewed it in R in a spreadsheet-style format. 

tidy_data <- read.table("E:\\Drive E\\Coursera\\Getting and Cleaning Data\\Week 4\\Getting and Cleaning Data Course Project\\UCI HAR Dataset\\tidy2RM.txt", header = TRUE)

## Used to view entire data frame table Invoke a spreadsheet-style data viewer on a 
## matrix-like R object.

View(tidy_data) 

Conclusion
The resulting final data set of tidy2 or tidy2RM.txt file meets the principles of tidy data:
1.	Each variable forms a column with headings so you can differentiate between columns. There are no duplicate columns. 
2.	Each observation forms a row. There is only one observation for each subject.id and activity.label pair. 
3.	Each type of observational unit forms a table. Each table/file stores data about one kind of observation or there is one table for each kind of variable.
4.	If you have multiple tables, they should include a column (subject.id) in the table that allows them to be linked.






