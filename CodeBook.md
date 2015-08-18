# Code Book

The provide R script downloads the original dataset from web and expands it in current directory, as part of its execution.

It produces a final dataset called tidy.data.2.txt, as a space separated text file, with a header row.
The data set is composed of 3 columns:

* subject - identified of the subject using the measuring device
* activity - the name of the activity he peformed
* mean - The mean value of the sensor for the individual and activity type of the row. This represents the mean of all 
the measurements of that activity type that were present on the original data file.

Available on the script, but not exported, you can also access tidy.data data frame which contains the mean and 
standard deviation of each measurement of each individual during a particular activity type.

For more explanations about the steps and transformations used in the script, please refer to comments on the source file.

For more information refer to file "UCI HAR Dataset/README.txt" of the raw data zip file.
