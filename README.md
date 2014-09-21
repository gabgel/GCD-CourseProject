#Getting and Cleaning Data - Project

##Introduction
The goal of the analysis is to prepare a tidy dataset that can be used for further analysis

##Objective
You should create one R script called run_analysis.R that does the following. 

- Merges the training and the test sets to create one data set
- Extracts only the measurements on the mean and standard deviation for each measurement
- Uses descriptive activity names to name the activities in the data set
- Appropriately labels the data set with descriptive variable names 
- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

##Data source
For information about the structure of the raw data source, features description and how the script work, please refer to the CodeBook

##Script
The script run_analysis.R will load the data into R, perform the transformation to create a tidy dataset and save it in a file called tidyData.txt in the current working directory.
Please refer to the file run_analysis.R in the repo to see the code.