setwd("~/Desktop/Zillow Kaggle")
train = read.csv("train_2016_v2.csv", header = TRUE)
properties = read.csv("properties_2016.csv", header = TRUE)
hist(train$logerror)
train.abbrev = train[train$logerror < quantile(train$logerror, 0.98), ]
train.abbrev = train.abbrev[train.abbrev$logerror > quantile(train.abbrev$logerror, 0.02), ]
hist(train.abbrev$logerror)
overvalue = train[with(train,order(-logerror)),][1:30,]
undervalue = train[with(train,order(logerror)),][1:30,]
medianvalue = train[with(train,order(logerror)),][50000:51000,]
write.csv(overvalue, "~/Desktop/Zillow Kaggle/DukeML-Kaggle/overvalue_top30.csv")
write.csv(undervalue, "~/Desktop/Zillow Kaggle/DukeML-Kaggle/undervalue_top30.csv")
write.csv(medianvalue, "~/Desktop/Zillow Kaggle/DukeML-Kaggle/medianvalue_1000.csv")
