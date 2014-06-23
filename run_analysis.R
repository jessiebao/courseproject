# get the file url
url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
# create a temporary directory
td = tempdir()

# create the placeholder file
tf = tempfile(tmpdir=td, fileext=".zip")
# download into the placeholder file
download.file(url, tf)

# The data has now been downloaded to a temporary file,
# and the full path is contained in tf. You'll notice 
# I've also explicitly created a temporary directory(td), 
# which I'll use for extracting the data from the archive. 

# list all file names in zipped file
unzip(tf, list=TRUE)
# create a function to extract file and load into r
extract<-function(x){
    fname = unzip(tf, list=TRUE)$Name[x]
    # unzip the file to the temporary directory
    unzip(tf, files=fname, exdir=td, overwrite=TRUE)
    # fpath is the full path to the extracted file
    fpath = file.path(td, fname)
    # format fpath
    fpath=chartr("\\","/",fpath)
    # read the train data file in table format and create a data frame train from it
}

activity<-read.table(extract(1), header=F, sep="", row.names=NULL, stringsAsFactors=FALSE)
features<-read.table(extract(2), header=F, sep="", row.names=NULL, stringsAsFactors=FALSE)
testSub<-read.table(extract(16), header=F, sep="", row.names=NULL, stringsAsFactors=FALSE)
test<-read.table(extract(17), header=F, sep="", row.names=NULL, stringsAsFactors=FALSE)
testLabel<-read.table(extract(18), header=F, sep="", row.names=NULL, stringsAsFactors=FALSE)
trainSub<-read.table(extract(30), header=F, sep="", row.names=NULL, stringsAsFactors=FALSE)
train<-read.table(extract(31), header=F, sep="", row.names=NULL, stringsAsFactors=FALSE)
trainLabel<-read.table(extract(32), header=F, sep="", row.names=NULL, stringsAsFactors=FALSE)

# change column names of trainLabel data
colnames(trainLabel)<-"V562"
# change column names of trainSub data
colnames(trainSub)<-"V563"
# create total train data trainT with 561-features in train, train lable in trainLabel and train subject in trainSub
trainT<-cbind(train,trainLabel, trainSub)

# do the same thing for test data
# change column names of testLabel data
colnames(testLabel)<-"V562"
# change column names of testSub data
colnames(testSub)<-"V563"
# create total train data testT with 561-features in test, test lable in testLabel and testsubject in testSub
testT<-cbind(test,testLabel, testSub)

## TASK 1: Merges the training and the test sets to create one data set, total
total<-rbind(trainT, testT)


## TASK2: Extracts only the measurements on the mean and standard deviation for each measurement. 
# I think the mean and standard deviation for each measurement mean the variables with "mean" or "std" characters
# among 561 feature variables. I don't consider the additional angle() variables which contain "Mean". 
# First, create an integer vector MeanStd. MeanStd as an indicator of variables with "mean" or "std"
MeanStd<-grep("mean\\()|std\\()",features[,"V2"])

# Second, I want to include the label variable (V562) and subject variable (V563) here.
# Create another integer vector by attaching 562, 563 to the MeanStd vector
MeanStdls<-c(MeanStd,562,563)
# Third, subset total data set to contain only the measurements on the mean and std variables with its label and subject. 
totalMeanStdls<-total[,MeanStdls]

## TASK3: Uses descriptive activity names to name the activities in the data set
# I understand here the data set means the one created in the second task.
# First, rename the columns of activity data set
colnames(activity)<-c("V562","V564")
# Second, merge totalMeanStdls and activity into totalMeanStdlsD, 
# the variable V564 describes the activity names
totalMeanStdls$V562[grep(1,totalMeanStdls$V562)] = activity[which(activity$V562==1),]$V564
totalMeanStdls$V562[grep(2,totalMeanStdls$V562)] = activity[which(activity$V562==2),]$V564
totalMeanStdls$V562[grep(3,totalMeanStdls$V562)] = activity[which(activity$V562==3),]$V564
totalMeanStdls$V562[grep(4,totalMeanStdls$V562)] = activity[which(activity$V562==4),]$V564
totalMeanStdls$V562[grep(5,totalMeanStdls$V562)] = activity[which(activity$V562==5),]$V564
totalMeanStdls$V562[grep(6,totalMeanStdls$V562)] = activity[which(activity$V562==6),]$V564

## TASK4: Appropriately labels the data set with descriptive variable names. 
# label function in Hmisc can label all variables at once
# load Hmisc library
library(Hmisc)
# create a function describe to explain the feature variables in detail
describe<-function(col){
    a<-substring(col, 1, 1) 
    name<-""
    if(a=="f"){name<-"after transform"}
    if(grepl("X",col)){
        name<-paste("on the X axis",name)
    }else if(grepl("Y",col)){
        name<-paste("on the Y axis",name)
    }else if(grepl("Z",col)){
        name<-paste("on the Z axis",name)
    }
    if(grepl("BodyAcc",col)){
        name<-paste("body acceleration",name)
    }else if(grepl("GravityAcc",col)){
        name<-paste("gravity acceleration",name)
    }else if(grepl("BodyGyro",col)){
        name<-paste("angular velocity",name)
    }
    if(grepl("Jerk",col)){
        name<-paste("jerk signal of",name)}
    if(grepl("mean",col)){
        name<-paste("the mean of",name)
    }else if(grepl("std",col)){
        name<-paste("the std of",name)
    }
    name
}
# add column V3 to features by applying function "describe" to each item in features 
features$V3<-sapply(features$V2,describe)
# add V to each integer in MeanStd vector to get the mean-std variable names, like 32 to V32
MeanStdV<-paste0("V",MeanStd)
# label the variables of totalMeanStdls data set with the descriptive labels
label(totalMeanStdls[,MeanStdV], self=F)<-c(features$V3[MeanStd])
# label other three variables
label(totalMeanStdls[,"V563"])<-"subject"
label(totalMeanStdls[,"V562"])<-"activity"
str(totalMeanStdls)

## TASK 5: Creates a second, independent tidy data set
## with the average of each variable for each activity and each subject. 
# get the mean of mean-std variables based on two factors--activity(V562) and subject(V563)
df<-aggregate(x=totalMeanStdls[,MeanStdV],by=list("activity"=totalMeanStdls$V562,"subject"=totalMeanStdls$V563), FUN="mean")
# set the column names like V1 as simplified descriptive names "tBodyAcc-mean()-X"
colnames(df)[3:68]<-features$V2[MeanStd]

library(reshape2)
# melt df data set
dfmelt<-melt(df,id=c("activity","subject"),measure.vars=features$V2[MeanStd])
# split column variables
dfmelt<- cbind(dfmelt, colsplit(dfmelt$variable, "-", names = c("var1","stat","xyz")))
# separate the first and second character with "."
dfmelt$var1<-gsub("([t|f])([a-zA-Z])", "\\1\\.\\2", dfmelt$var1)
# split column variables
dfmelt2<- cbind(dfmelt, colsplit(dfmelt$var1,pattern="\\.",names = c("signal","var")))
# remove the parentethes of mean() or std()
dfmelt2$stat<-sub("\\()","",dfmelt2$stat)
# create tidy name set
tidy<-dfmelt2[,c("activity","subject","signal","var","xyz","stat","value")]
# save tidy data set as txt
write.table(tidy,"tidy.txt",row.names=F)
