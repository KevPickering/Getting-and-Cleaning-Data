## Data supplied in text files
* activity_labels.txt: 6 observations, 2 variables. Variables renamed in the script to ActivityId and Activity. They supply descriptive names to the activities measured.
* features.txt: 531 observations, 2 variables. Variables renamed in the script to FeatureId and Feature. They supply variable names to the variables in the (fact) measure tables.

* subject_train.txt: 7352 observations, 1 variable. Variable renamed SubjectId in the script. Each row corresponds to it's equivalent row in the train dataset fact table, to associate a measured observation with the subject individual.
* y_train.txt: 7352 observation, 1 variable. Variable renamed ActivityId in the script. Each row corresponds to it's equivalent row in the train dataset fact table, to associate a measured observation with the activity and used to link to the activity_labels.txt data.
* X_train: 7352 observations, 531 variables. Variables renamed in the script so V1 = row 1 of features.txt, V2 = row 2 of features.txt etc. Contains all recorded measurements of activity for an individual subject for thr training data set.

* subject_test.txt: 2947 observations, 1 variable. Variable renamed SubjectId in the script. Each row corresponds to it's equivalent row in the test dataset fact table, to associate a measured observation with the subject individual.
* y_test .txt: 2947 observation, 1 variable. Variable renamed ActivityId in the script. Each row corresponds to it's equivalent row in the test dataset fact table, to associate a measured observation with the activity and used to link to the activity_labels.txt data.
* X_test: 2947 observations, 531 variables. Variables renamed in the script so V1 = row 1 of features.txt, V2 = row 2 of features.txt etc. Contains all recorded measurements of activity for an individual subject for thr test data set.

## Variables:
* activityLabels: data frame of data read in from activity_labels.txt file
* features: data frame of data read in from features.txt file
* subjectTrain: data frame of data read in from subject_train.txt file
* yTrain: data frame of data read in from y_train.txt file
* XTrain: table of data read in from X_train.txt file
* subjectTest: data frame of data read in from subject_test.txt file
* yTest: data frame of data read in from y_test.txt file
* XTest: table of data read in from X_test.txt file
* X: combined table of XTrain and XTest
* by_SubjectId_Activity: grouping information to be applied to combined data set to obtain summary variables
* summaryTable: table to be stored to file system containing summary of combined dataset (X) using grouping (by_SubjectId_Activity)

## Transformations:
* None of the text files have variable names, so descriptive names were applied. The large number of variables in the fact tables have their descriptive names derived from the values in features.txt file.
* There is no immediate link in the recorded (fact) measures to the descriptive (dimension) activity table. The link was provided in each data set by adding to the fact table, data from the subject_test and subject_train tables by column binding.
* Before the two fact tables are concatenated together by row binding, an extra column is applied so we can identify the source of each observation in the combined fact table (this variable called TestOrTrain)
