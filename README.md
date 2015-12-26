There is one script file called run_Analysis.R

The purpose of the script is to read in and output a summary of a group of text files containing data related to measurements taken from accelerometers from the Samsung Galaxy S smartphone.

A full description of the data is given at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Data can be downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
The data needs to extracted to the same working directory in which the script is executed in order for it to work correctly.
The script makes use of package "dplyr" which must be installed.

A description of all variables used in the script can be found in CodeBook.md
The script itself contains comments to describe each step or block of code.

The output file from this script is named Analysis.txt and is a delimited list with summary averages of each mean and standard deviation variables per user and subject.