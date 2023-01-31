library(tidyverse)# Data Processing
library(cluster)# Clustering
library(factoextra)# Cluster Visualization
library(gridExtra)# Cluster Visualization
#SGN


##############################################################################################
###### Build an analytical model to create clusters of airline travellers ####################
##############################################################################################

#---------------------Step1: Loading the Data in R-----------------------------
Path<-setwd("C:/Users/dhars/Desktop/DS Projects/Clustering-main")
mall_customers<-read.csv("Mall_Customers.csv",header = TRUE,as.is = TRUE,na.strings = c(""))

#------------Basic exploration od data------
str(mall_customers)
dim(mall_customers)
summary(mall_customers)

#checking for missing values
as.data.frame(colSums(is.na(mall_customers)))
mall_customers$Gender<-as.factor(mall_customers$Gender)
##checking for outliers
library(graphics)
mall_customers1<-subset(mall_customers,select = -c(CustomerID))
boxplot(mall_customers1)
boxplot(mall_customers$Annual.Income..k..)

summary(mall_customers$Annual.Income..k..)
bench<-78+1.5*IQR(mall_customers$Annual.Income..k..)

#132.75 ------ values above 132.75 are outliers

mall_customers$Annual.Income..k..<-ifelse(mall_customers$Annual.Income..k..>132,132,mall_customers$Annual.Income..k..)
boxplot(mall_customers$Annual.Income..k..)
boxplot(mall_customers1)

#Normalizing the Data for clustering 
library(caret)
preproc<-preProcess(mall_customers1)
mall_customersNorm<-predict(preproc,mall_customers1)
summary(mall_customersNorm)

#Hierarchical Clustering
distan<-dist(mall_customersNorm, method = "euclidean")
Clustermall_customers<-hclust(distan, method = "ward.D")
plot(Clustermall_customers)#Cluster Dendogram

#Assigning points to the clusters
mallCluster<-cutree(Clustermall_customers, k = 5)# 5 Clusters
table(mallCluster)

mallCluster1<-cutree(Clustermall_customers, k = 4)# 4 Clusters
table(mallCluster1)

##-----Selecting 5 clusters
#Computing the average values of the cluster groups
MeanComp<-function(var, clustergrp, meas){
  #var: Numeric Variable
  #clustergrp: Cluster Model created form Heirarchical Method
  #meas: Summary Measure - Mean
  z<-tapply(var, clustergrp, meas)#
  print(z)
}
Income_mean<-MeanComp(mall_customers1$Annual.Income..k.., mallCluster, mean)
Age_mean<-MeanComp(mall_customers1$Age, mallCluster, mean)
spending_mean<-MeanComp(mall_customers1$Spending.Score..1.100., mallCluster, mean)

df<-as.data.frame(cbind(Income_mean,Age_mean,spending_mean))

#Appending the Clusters Assignment
mall_cust_Hei<-data.frame(mall_customers1,mallCluster)#mall-customerCluster-->Heirarchical Cluster
write.csv(mall_cust_Hei,"mall_customers_Hierarchical.csv", row.names = FALSE)

write.csv(df,"properties_of_each_cluster.csv", row.names = FALSE)


