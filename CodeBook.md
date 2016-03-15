---
title: "CodeBook"
author: "Giacinto Maggiore"
date: "03/15/2016"
---

## CodeBook

The code book describes the variables, the data, and any transformations that you performed to clean up the data

### Data source and references 
- Data source: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
- Description of the dataset: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

###Origin of the raw dataset

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

You can find more information in the README of the raw dataset.

##Description of the raw dataset

- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features. 
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

The signals that were enstimeted are: 
- tBodyAcc-XYZ
- tGravityAcc-XYZ
- tBodyAccJerk-XYZ
- tBodyGyro-XYZ
- tBodyGyroJerk-XYZ
- tBodyAccMag
- tGravityAccMag
- tBodyAccJerkMag
- tBodyGyroMag
- tBodyGyroJerkMag
- fBodyAcc-XYZ
- fBodyAccJerk-XYZ
- fBodyGyro-XYZ
- fBodyAccMag
- fBodyAccJerkMag
- fBodyGyroMag
- fBodyGyroJerkMag

Description of the terms:
- t refers to the time domain
- f refers to the frequency domain
- Body refers to the Body of the subject
- Gravity refers to the Earth gravity
- Acc refers to the acceleration
- Gyro refers to the Gyroscope
- Mag refers to the magnitude
- XYZ refers to the fact that the measurements are on the three dimensions.

The set of variables that were estimated from these signals are: 
- mean(): Mean value
- std(): Standard deviation
- mad(): Median absolute deviation 
- max(): Largest value in array
- min(): Smallest value in array
- sma(): Signal magnitude area
- energy(): Energy measure. Sum of the squares divided by the number of values. 
- iqr(): Interquartile range 
- entropy(): Signal entropy
- arCoeff(): Autoregression coefficients with Burg order equal to 4
- correlation(): Correlation coefficient between two signals
- maxInds(): Index of the frequency component with largest magnitude
- meanFreq(): Weighted average of the frequency components to obtain a mean frequency
- skewness(): Skewness of the frequency domain signal 
- kurtosis(): Kurtosis of the frequency domain signal 
- bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
- angle(): Angle between some vectors.


You can also consult the readme of the data set to futher information.

## Transformation details
There are five steps. 
1. Merge the tranining and test sets. Making use of the feature.txt, the names of the columns of the new data.frame are setted.
2. Only the measurements of the mean and the standard deviation of all the signals are extracted from the data.
3. The number codes of the activities are substituted by the correspondent names.
4. The names of the variables of the data are changed with more descriptive names.
5. Create an indipendent tidy dataset with the average of each variable for each activity and each subject. 

## The tidy data set (steps 1-4)
The tidy data is a table, whose variables are
- subject: index of the subject considered
- activityName: name of the activity made by the subject
- The variables MEAN and SD of all the signals considered in the raw dataset, in which all the names are now descriptive.
