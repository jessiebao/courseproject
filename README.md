courseproject
=============

First, download zipped files. 
The data has been downloaded to a temporary file, and the full path is contained in tf. You'll notice 
I've also explicitly created a temporary directory(td), which I'll use for extracting the data from the
archive. To get the name of the file which the data are to be read from, I created a function extract,
which can cache file names into fname, extract the data from this file name into td, explicitly save 
file path to fpath and also format fpath by replacing any "\\" with "/" so that the file path is readable.
Next, using the extract(file_number) and read.table() functions, load the unzipped data into r and save them as activity,
features, testSub, test, testLabel,trainSUb, train, and trainLabel. How can I obtain their file numbers? I check them 
from the filelist, which lists all files in tf and their corresponding file numbers.

TASK1:  Merges the training and the test sets to create one data set, total
==
I have created a total data set, and the data set is saved in total. You' ll notice that this total data set has
563 variables including 561 features variable, activity/label and subject. I think this variable names should be unique,
so I change column names of testSub, testLabel, trainSub and trainLabel, before columns binding. 

TASK2: Extracts only the measurements on the mean and standard deviation for each measurement. 
==
I have created a totalMeanStdls data set, by subsetting the total data set created in Task 1 by using mean-std integer vector MeanStdls.
Then, the 563 variable columns in total data set are dropped dramatically to 68 mean-std, activity (V562) and subject (V563) columns. 
Because all feature variables in the total data set are symolized, like "V1", "V2", to get the column variables' descriptive information, I 
refer back to the second column in features data set, and search for mathes to "mean()" or "std()" characters within 
each element of 2nd column in features. Then it returned a vector (MeanStd) of the indices of the elements of 2nd columns 
in features, that is, the column names of total data set, that yielded a match. 
 
TASK3: Uses descriptive activity names to name the activities in the data set
==
I have replaced the integers signifying the activity in totalMeanStdls data set with the corresponding activity characters. 
Activity data set lists all activity codes (it column names was V1, but now V562), and the corresponding activity name( was V2, now V564).
When the activity code (V562) in totalMeanStdls matches to that in activity, replace the activity code (V562) 
in totalMeanStdls, like "1", with the activity name, like "WALKING". 


TASK4: Appropriately labels the data set with descriptive variable names
==
I have added another columns V3 to features data set to clearly explain the variable names in column V2. Then label all
the mean-std variables of totalMeanStdls data set at the same time using the label() function in Hmisc library. I have created
a function called describe, which can explain variable names in detail. For example, describe(col) function names the col of "fBodyAccJerk-X" 
as "jerk signal of body acceleration on the X axis after transform". 


TASK 5: Creates a second, independent tidy data set
==
I have created a data set df which obtains the average for each variable for each subject of each activity. 
I think the column names of tidy data cannot be "V1" etc. So I name column names with descriptive names, 
like "tBodyAcc-Mean()-X". But, the column names contain many information together, like whether after tranform, 
indicating by "t","f", for statistic "mean" or "std", and on which axis "X","Y", or "Z". So I melted df as dfmelt,
and then split one column name into four column variables. 

So finally, I have created a tidy data set, which seven variables--"activity","subject","signal","var","xyz","stat","value".
