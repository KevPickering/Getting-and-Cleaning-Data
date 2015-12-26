run_analysis <- {
	##
	## load packages required by the script
	##
	library(dplyr)
	##
	## read in the dimension (descriptive) tables
	##
	activityLabels <- read.csv("activity_labels.txt", header=FALSE, sep="")
	features <- read.csv("features.txt", header=FALSE, sep="")
	##
	## tidy the dimension variables by giving descriptive names
	##
	activityLabels = rename(activityLabels, ActivityId=V1, Activity=V2)
	features <- rename(features, FeatureId=V1, Feature=V2)
	##
	## measurement foreign keys to dimension tables are contained in two
	## separate files to the fact file containing meausurable data. Each row
	## in these 2 files is associated with it's corresponding row in the fact
	## file. So, for each dataset (train and test) we read in these 2 files
	## and column bind with the fact table so we have a relationship in place
	## to link the measurement variables with the descriptive names in the
	## dimension tables.
	##
	## yTrain.txt associates each measurement to an activity
	##
	yTrain <- read.csv("y_train.txt", header=FALSE)
	##
	## tidy this table with more descriptive variable names
	##
	yTrain <- rename(yTrain, ActivityId=V1)
	##
	## subject_txt asscociates each measurement to an individual subject
	##
	subjectTrain <- read.csv("subject_train.txt", header=FALSE)
	##
	## tidy with more descriptive variable names
	##
	subjectTrain <- rename(subjectTrain, SubjectId=V1)
	##
	## read in the recorded measurements for training, using column names derived
	## from the features.txt file and listed in table 'features'
	##
	XTrain <- read.table("X_train.txt", sep="", header=FALSE, col.names=features[["Feature"]])
	##
	## column bind the subject and activity foreign keys to the recorded measures
	##
	XTrain <- cbind(yTrain, XTrain)
	XTrain <- cbind(subjectTrain, XTrain)
	##
	## as part of creating one large dataset, include the descriptive variables
	## for activity from the dimension table
	##
	XTrain <- merge(XTrain, activityLabels, by="ActivityId")
	##
	## label the source of this data so we can differentiate between training and test
	##
	XTrain <- mutate(XTrain, TestOrTrain = "Train")
	##
	## clean up train objects no longer required
	##
	rm(yTrain)
	rm(subjectTrain)
	##
	## repeat the above steps for test data set
	##
	subjectTest <- read.csv("subject_test.txt", header=FALSE)
	subjectTest <- rename(subjectTest, SubjectId=V1)
	
	yTest <- read.csv("y_test.txt", header=FALSE)
	yTest <- rename(yTest, ActivityId=V1)
	
	XTest <- read.table("X_test.txt", sep="", header=FALSE, col.names=features[["Feature"]])
	XTest <- cbind(yTest, XTest)
	XTest <- cbind(subjectTest, XTest)
	XTest <- merge(XTest, activityLabels, by="ActivityId")
	XTest <- mutate(XTest, TestOrTrain = "Test")
	
	rm(yTest)
	rm(subjectTest)
	
	rm(activityLabels)
	rm(features)
	##
	## create one large dataset, combining test and training datasets
	##
	X <- rbind(XTrain, XTest)
	##
	## clean up memory space removing the individual dataset
	##
	rm(XTest)
	rm(XTrain)
	##
	## we only require measurements for mean and standard deviation
	## so trim surplus columns from the combined dataset
	##
	X <- select(X, SubjectId, Activity, contains("mean"), contains("std"), -contains("meanFreq"))
	##
	## for the second independant dataset, set up grouping condition and then apply
	## this to the combined dataset.
	##
	by_SubjectId_Activity <- group_by(X, SubjectId, Activity)
	summaryTable <- by_SubjectId_Activity %>% summarise_each(funs(mean), contains("mean"), contains("std"))
	##
	## write out the summary results to file system
	##
	write.table(summaryTable, file="analysis.txt", row.names=FALSE)
	##
	## explicitly clear out memory
	rm(X)
	rm(by_SubjectId_Activity)
	##
	## return summaryTable
	##
	summaryTable
}