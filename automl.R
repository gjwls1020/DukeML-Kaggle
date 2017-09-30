library(data.table)
library(h2o) #install.packages("h2o", type="source", repos="https://h2o-release.s3.amazonaws.com/h2o/master/3978/R")

data_path <- Sys.getenv("~/Desktop/Zillow Kaggle/")

properties_file <- file.path("~/Desktop/Zillow Kaggle/properties_2016.csv")
train_file <- file.path("~/Desktop/Zillow Kaggle/train_2016_v2.csv")
properties <- fread(properties_file, header=TRUE, stringsAsFactors=FALSE,
                    colClasses = list(character = 50))
train      <- fread(train_file)

properties_train = merge(properties, train, by="parcelid",all.y=TRUE)

h2o.init(nthreads = -1)

Xnames <- names(properties_train)[which(names(properties_train)!="logerror")]
Y <- "logerror"

dx_train <- as.h2o(properties_train)
dx_predict <- as.h2o(properties)

md <- h2o.automl(x = Xnames, y = Y,
                 stopping_metric="MAE",
                 training_frame = dx_train,
                 leaderboard_frame = dx_train)


properties_target<- h2o.predict(md@leader, dx_predict)
predictions <- round(as.vector(properties_target$predict), 4)

result <- data.frame(cbind(properties$parcelid, predictions, predictions * .99, 
                           predictions * .98, predictions * .97, predictions * .96, 
                           predictions * .95))

colnames(result)<-c("parcelid","201610","201611","201612","201710","201711","201712")
options(scipen = 999)
write.csv(result, file = "submission_automl.csv", row.names = FALSE )