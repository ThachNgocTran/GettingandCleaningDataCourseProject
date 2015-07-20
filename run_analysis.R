if (!file.exists("test") | !file.exists("train")){
    stop("Folders test and train not found")
}

# READ THE TRAIN DATASET
# read subject id
md1train = read.table("train/subject_train.txt", colClasses="numeric")

# read measurement
# sep = "" : match any white space
md2train = read.table("train/X_train.txt", header=FALSE, sep="", colClasses="numeric")

# read activity
md3train = read.table("train/y_train.txt", colClasses="numeric")

# merge the train
mdtrain = data.frame(md1train, md2train, md3train)


# READ THE TEST DATASET
# read subject id
md1test = read.table("test/subject_test.txt", colClasses="numeric")

# read measurement
# sep = "" : match any white space
md2test = read.table("test/X_test.txt", header=FALSE, sep="", colClasses="numeric")

# read activity
md3test = read.table("test/y_test.txt", colClasses="numeric")

# merge the test
mdtest = data.frame(md1test, md2test, md3test)

# MERGE INTO ONE UNIFIED DATASET
# read feature
feature = read.table("features.txt", sep=" ", colClasses=c("integer", "character"))

# create columns name for final dataset
columnnames = c("subjectid", make.names(feature[,2]), "activity")

names(mdtrain) <- columnnames
names(mdtest) <- columnnames

## QUESTION 1
# create the final dataset
md1 = rbind(mdtrain, mdtest)

#dim(md)
# [1] 10299   563

##################################################################################################

meancolumns = grep("mean\\(\\)", feature[,2])
stdcolumns = grep("std\\(\\)", feature[,2])

# find the variables that are either "mean" or "std"
meanandstdcolumns = c(meancolumns, stdcolumns)

# "md1" dataset has the first column being "subjectid", so we add 1.
meanandstdcolumns = meanandstdcolumns + 1L

# final columns to extract
finalcolumns = sort(c(1L, meanandstdcolumns, 563L))

## QUESTION 2
# Extracts only the measurements on the mean and standard deviation
md2 = md1[, finalcolumns]

# dim(md2)
#[1] 10299    68

##################################################################################################

# read the activity names
actLabels = read.table("activity_labels.txt", sep="", colClasses=c("integer", "character"))
md3 <- md2

# convert from number to character
library(plyr)
md3$activity = mapvalues(md3$activity, from=actLabels[,1], to=actLabels[,2])

## QUESTION 3
# convert from character to factor
md3$activity = as.factor(md3$activity)

##################################################################################################

md4 <- md3

## QUESTION 4
# remove "." in variable names so that it looks better (more descriptive)
names(md4) <- gsub("\\.","", names(md4))

##################################################################################################

md5 <- md4
## QUESTION 5
# for records corresponding to each pair(subjectid, activity), we do the mean
md5 = aggregate(md5[,!names(md5) %in% c("subjectid", "activity")], by=list(subjectid = md5$subjectid, activity = md5$activity), FUN=mean)

# write output
write.table(md5, "tidydataset.txt", row.names = FALSE)
