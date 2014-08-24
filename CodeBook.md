CodeBook.md for run_analysis.R

Feature Selection 
=================

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

time_bodyAcc-XYZ
time_gravityAcc-XYZ
time_bodyAccJerk-XYZ
time_bodyGyro-XYZ
time_bodyGyroJerk-XYZ
time_bodyAccMag
time_gravityAccMag
time_bodyAccJerkMag
time_bodyGyroMag
time_bodyGyroJerkMag
frequency_bodyAcc-XYZ
frequency_bodyAccJerk-XYZ
frequency_bodyGyro-XYZ
frequency_bodyAccMag
frequency_bodyAccJerkMag
frequency_bodyGyroMag
frequency_bodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
time_bodyAccMean
time_bodyAccJerkMean
time_bodyGyroMean
time_bodyGyroJerkMean


Transformations Conducted
=========================

1. The logic followed included prepping each of the datasets (train and test) by reading the appropriate files into dataframes and assigning subjects, variable names and an index.
2. The two dataframes where then merged into a single dataframe.
3. The variables referring to means and standard deviation values were extracted into a vector (varlist) to be used in subsetting the merged dataframe into a reduced form containing only means and standard deviations
4. Mean means and standard deviations were calculated using sapply for column means within a nested loop which created subsets for each individual and activity.
5. As each set of means for each activity was calculated, it was inserted into the tidy dataset, tidy_2.
6. The index of tidy_2 was corrected.
7. The tidy_2 dataframe was output to "tidy_means_stds.txt" using write.table.


