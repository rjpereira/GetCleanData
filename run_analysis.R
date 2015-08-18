# Full code to Peer project of Getting and Cleaning Data

# The program will execute in current working directory
# Download the zip_file....
if(!file.exists('peer_exercise.zip')){
    fileURL <- download.file('http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip',
                             destfile='peer_exercise.zip')
}

# ... and expand it
unzip('peer_exercise.zip')

# Change directory to dataset
setwd('UCI HAR Dataset')

# Load the labels for each of the activity types, which apply to both test and train datasets
measure.labels.names <- read.table('activity_labels.txt',header=F,col.names = c('id','name'))

# As normally I would like to work with separate tidy datasets of test & train, I tidy them up separately
# and only append them at the end.
# For that I define a function which tidies them by filename

join.tables <- function (subject.file,data.file,measure.labels.file) {

    # Read data
    data <- read.table(data.file, header=F)

    # Read activity codes, and perform code to name lookup using previously loaded dataset (left join)
    measures.activity <- read.table(measure.labels.file,header=F,col.names='id')
    measures.activity <- merge(x = measures.activity, y = measure.labels.names, by = 'id', all.x = TRUE)

    # Compose now the tidy dataset by:
    #  1. Loading the subject of each measurement
    #  2. Append the activity name he carried out
    #  3. Append the mean and stddev of the measurement records
    df          <- read.table(subject.file,header=F,col.names='subject')
    df$activity <- measures.activity$name
    df$mean     <- rowMeans(data)
    df$sd       <- apply(data,1, sd)

    # Return tidy dataframe
    df
}

# Now we load the 2 sets of data : test and train
test  <- join.tables('test/subject_test.txt','test/X_test.txt','test/y_test.txt')
train <- join.tables('train/subject_train.txt','train/X_train.txt','train/y_train.txt')

# We joined them together as originally asked
tidy.data <- rbind(test,train)

# Return to initial working directory
setwd('..')

# To perform exercise 5 ("pivoting"), I'm using reshape
library(reshape2)

# First define my dimension variables and my measurement variable of interest
data.melt <- melt(tidy.data,id=c('subject','activity'),measure.vars=c('mean'))

# And now calculate the "mean of mean", for each subject and activity type
tidy.data.2 <- dcast(data.melt, subject+activity ~ variable,mean)

# We're good to save it :
write.table(tidy.data.2,'tidy.data.2.txt',quote=F,row.names=FALSE)
