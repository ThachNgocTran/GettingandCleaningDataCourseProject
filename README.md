# GettingandCleaningDataCourseProject
Repo for Getting and Cleaning Data Course Project

The code works as below:

1. Read the "subject_train.txt".
2. Read the "X_train.txt".
3. Read the "y_train.txt".
4. Merge all of these above into one dataset (training only).
Similarly,
5. Read the "subject_test.txt".
6. Read the "X_test.txt".
7. Read the "y_test.txt".
8. Merge all of these above into one dataset (test only).
Now, 
9. Read the features name in "features.txt".
10. Set the column names for both training and testing datasets.
11. Merge the training and testing datasets into one single dataset.

------------------------------------------------------------

12. In column names, we extract names that look like calculating mean() and std() as required ("Extracts only the measurements on the mean and standard deviation for each measurement.")
13. Then we create a list of columns that need extracting, including the first column (subject id), and last column (activity).
14. Do the extraction. We have dataset 2.

------------------------------------------------------------

15. Read the "activity_labels.txt" (pair(number, activity) for each line).
16. In the dataset 2, map the value of activity column from number to factor (first to string, then to factor). We have dataset 3.

------------------------------------------------------------

17. The dataset 3 has column names that look not very friendly (due to having "dot"). We remove the dots in the column names to make it look better.
18. We have dataset 4.

------------------------------------------------------------

19. For each pair(userid, activity), we have multiple records. To calculate the average for each variable for each pair, use "aggregate" function, which is more powerful than "tapply".
20. We have dataset 5. Write this to file "tidydataset.txt".
