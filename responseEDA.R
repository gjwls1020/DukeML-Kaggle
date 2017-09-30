setwd("~/Desktop/Zillow Kaggle")
train = read.csv("train_2016_v2.csv", header = TRUE)
hist(train$logerror)
remove_quantiles = function(v, lowerbound, upperbound){
  return (v[quantile(v,lowerbound) <= v && v <= quantile(v,upperbound)]) 
}