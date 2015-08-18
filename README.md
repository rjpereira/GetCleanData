# GetCleanData
Peer Assessment of Course Getting and Cleaning Data

Find in this repository the following files:

* run_analysis.R - The full script addressing the exercise points. The file is fully documented, please refer to it for a step by step explanation of the logic of the script.
* CodeBook.md - The CodeBook for the exercise describing the data format of the datasets produced
* tidy.data.2.txt - The data submitted to the exercise page

The script downloads the data from the web site and expands it on the current working directory.

I decided to tidy up separately the train and test data, only appending it at the end. For this reason the tidy up logic is coded on a function invoked twice for each set of files.

The clean up process creates the dataframe starting by the subject variable.

It then left joins the measurement code, with its name (label), to append a column to the tidy dataframe named "activity".
Lastly we calculate row means and standard deviation from data and append each of this 2 measurements to the tidy dataframe.

This process is repeated for train and test data.

At last the two are appended as asked on the exercise.

To calculate means per user/activity type I use the handy reshape2 library, to define my measurement variable and my 2 dimension variables. dcast() than simply calculates the mean requested on exercise 5, with the help of the formula.

The final dataframe is then saved to file.
