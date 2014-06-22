###Code Book

1. Variable name : url ;
   Variable value : "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" ;
   Description : The url of zipped files

2. Variable name : td ;
   Variable value : “C:\\Users\\..\\AppData\\Local\\Temp\\...” ;
   Description : Temporary directory

3. Variable name : tf ;
   Variable value : “C:\\Users\\..\\AppData\\Local\\Temp\\....zip” ;
   Description : Unzipped file folder

4. Variable name : activity ;
   Variable value : 'data.frame':    6 obs. of 2 variables: 
$ V562: int  1 2 3 4 5 6
$ V564: chr  "WALKING" "WALKING_UPSTAIRS" "WALKING_DOWNSTAIRS" "SITTING" ... ;
   Description : Activity data set 

5. Variable name : features ;
   Variable value : data.frame':    561 obs. of  3 variables:
 $ V1: int  1 2 3 4 5 6 7 8 9 10 ...
 $ V2: chr  "tBodyAcc-mean()-X" "tBodyAcc-mean()-Y" "tBodyAcc-mean()-Z" "tBodyAcc-std()-X" ...
 $ V3: chr  "the mean of body acceleration on the X axis " "the mean of body acceleration on the Y axis " "the mean of body acceleration on the Z axis " "the standard deviation of body acceleration on the X axis " ... ;
   Description : Features data set. Column three is the descriptive label for task 3

6. Variable name : testSub ;
   Variable value: 'data.frame':   2947 obs. of  1 variable:
 $ V563: int  2 2 2 2 2 2 2 2 2 2 ... ;
   Description : Data set contains the subject of each test data

7. Variable name : test ;
   Variable value : 'data.frame':	2947 obs. of  561 variables:
 $ V1  : num  0.257 0.286 0.275 0.27 0.275 ...
 $ V2  : num  -0.0233 -0.0132 -0.0261 -0.0326 -0.0278 ;
   Description : Data set contains all test data

8. Variable name : testLabel ;
   Variable value: 'data.frame':   2947 obs. of  1 variable:
 $ V562: int  5 5 5 5 5 5 5 5 5 5 ... ;
   Description : Data set contains the label for each test data

9. Variable name: trainSub ;
   Variable value: data.frame':	7352 obs. of  1 variable:
 $ V563: int  1 1 1 1 1 1 1 1 1 1 ... ;
   Description: Data set contains the subject of each train data

10. Variable name: train ;
    Variable value: 'data.frame':	7352 obs. of  561 variables:
 $ V1  : num  0.289 0.278 0.28 0.279 0.277 ...
 $ V2  : num  -0.0203 -0.0164 -0.0195 -0.0262 -0.0166 ... ;
    Description: Data set contains all train data

11. Variable name: trainLabel ;
    Variable value: 'data.frame':   7352 obs. of  1 variable:
 $ V562: int  5 5 5 5 5 5 5 5 5 5 ... ;
    Description: Data set contains the label for each train data

12. Variable name: trainT ;
    Variable value: 'data.frame':   7352 obs. of  563 variables: ;
    Description: Data set contains 561-features in train, train label in trainLabel and train subject in trainSub 

13. Variable name: testT ;
    Variable value: 'data.frame':	2947 obs. of  563 variables: ;
    Description: Data set contains 561-features in test, train label in testLabel and test subject in testSub

14. Variable name: total ;
    Variable value: 'data.frame':   10299 obs. of  563 variables: ;
    Description: Data set contain testT and train T

15. Variable name: MeanStd ;
    Variable value: An integer vector  [1:66] 1 2 3 4 5 6 41 42 43 44 ... ;
    Description: An indicator of mean-std feature variables

16. Variable name: MeanStdls ;
    Variable value: A numeric vector [1:68] 1 2 3 4 5 6 41 42 43 44 ...562 563 ;
    Description: Numbers in MeanStd vector with 562 and 563

17. Variable name: totalMeanStdls ;
    Variable value: 'data.frame':	10299 obs. of  68 variables: ;
    Description: Subsetted total data set only with mean-std, activity and subject variables

18. Variable name: MeanStdV ;
    Variable value: A character vector [1:66] "V1" "V2" "V3" "V4" "V5"...

19. Variable name: df ;
    Variable value: 'data.frame':   180 obs. of  68 variables: ;
    Description: The number of rows 180 is equal to 30 subjects times with 6 activities. 68 columns are all mean-std variables. Values are the average of each variable each activity for each subject. 

20. Variable name: dfmelt ;
    Variable value: 'data.frame':   11880 obs. of  7 variables: $activity, $subject, $ variable,$value,$var1,$stat,$xyz ;
    Description: Melted data set after column splitting 

21. Variable name: dfmelt2 ;
    Variable value: 'data.frame':   11880 obs. of  9 variables:$ variable, $subject, $value,$var1,$stat, $xyz, $signal,$var ;
    Description: Melted data set after column splitting 


