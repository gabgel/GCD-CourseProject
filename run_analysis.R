#read.tables it's going to take some time for X_train and X_test table
# the 2 tables will occupy about 45 Mb of your ram memory
dir<-"./UCI HAR Dataset/"
activity_labels<-read.table(paste(dir,"activity_labels.txt",sep=""))
features<-read.table(paste(dir,"features.txt",sep=""))
features<-read.table(paste(dir,"features.txt",sep=""))
dirTe<-"./UCI HAR Dataset/test/"
dirTr<-"./UCI HAR Dataset/train/"
subj_train<-read.table(paste(dirTr,"subject_train.txt",sep=""))
X_train<-read.table(paste(dirTr,"X_train.txt",sep=""))
y_train<-read.table(paste(dirTr,"y_train.txt",sep=""))
subj_test<-read.table(paste(dirTe,"subject_test.txt",sep=""))
X_test<-read.table(paste(dirTe,"X_test.txt",sep=""))
y_test<-read.table(paste(dirTe,"y_test.txt",sep=""))

#start to merge tables
X<-rbind(X_train,X_test)
subj<-rbind(subj_train,subj_test)

#add column of the subject and train/test
train<-rep(c("train"),1,7352)
test<-rep(c("test"),1,2947)
tt<-c(train,test)
tt<-as.factor(tt)
X<-cbind(X,subj,tt)

#add names to data
f_name<-as.character(features[,2])
names(X)<-c(f_name,"subject","group")

#extract mean and std variables
means<-grep("mean\\(\\)",features[,2])
stds<-grep("std\\(\\)",features[,2])
Xsub<-X[,sort(c(means,stds,563,562))]

#add to the dataset the response variable with activity names 
Y<-rbind(y_train,y_test)
Y$id<-1:nrow(Y)
Ylab<-merge(Y,activity_labels,by.x="V1",by.y="V1")
Ylab<-Ylab[order(Ylab$id),]
Ylab<-Ylab[,"V2"]
data<-cbind(Xsub,Ylab)
names(data)<-c(names(Xsub),"activity")

###Create the tidy dataset
n<-length(stdIdx)+length(meansIdx)
data$subAct<-as.character(paste(data$subject,data$activity,sep="_"))
fac<-unique(data$subAct)
tdata<-data.frame(matrix(nrow=length(fac),ncol=n))
j=1
for (i in fac){
    tdata[j,1:n]<-apply(data[data$subAct==i,1:n],2,mean)
    tdata$subAct[j]<-as.character(i)
    j=j+1
}
names(tdata)<-c(names(Xsub[,1:66]),"subAct")

#writing dataset in a txt file in wd
write.table(tdata,file = "./tidyData.txt",row.names= F)
