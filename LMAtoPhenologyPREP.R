require(BIEN)
require(plyr)
require(tidyr) 
require(dplyr)
require(mosaic)
require(stringr)
require(lme4)
require(magrittr)
require(data.table)
require(knitr)
require(kableExtra)
require(merTools)
require(boot)
###In order to run this model, we must first load royer_fossil_data_int 
###and WSLA_final_DF. royer_fossil_data_int is our fossil dataset and 
###WSLA_final_DF is our living dataset that will be used to create the 
###prediction model. We must then eliminate unnecessary columns from each 
###dataset and add a tally to the fossil set. 

###final_WSLA_DF
final_WSLA_DF<-readRDS("03_final_WSLA_DF", file = "./data/processed/03_finalWSLADF.rds")
###Changing column names so they match up between files
colnames(final_WSLA_DF)[colnames(final_WSLA_DF)=="n"]<-"count"
###Removing columns that are irrelevant
final_WSLA_DF<-final_WSLA_DF[-c(2)]


###Final fixes for final_WSLA_DF before model creation

###assigns values to evergreen and deciduous and eliminates those without phenology 
final_WSLA_DF$Phenology<-as.factor(final_WSLA_DF$Phenology)
final_WSLA_DF$Phenology2<-ifelse(final_WSLA_DF$Phenology == "EV", 1, 0)
indx <- which(final_WSLA_DF$Phenology == "D_EV")
final_WSLA_DF$Phenology2[indx] <- NA

###Now we are going to add phenology and LMA back in so we have to match order and super order back up
species_df<-read.csv("./data/processed/species_df.csv")
final_WSLA_DF$binomial <- gsub("_", " ", final_WSLA_DF$binomial)
final_WSLA_DF<-left_join(species_df, final_WSLA_DF, by="binomial")
final_WSLA_DF$log_LMA<-log(final_WSLA_DF$LMA)
final_WSLA_DF<-final_WSLA_DF[-c(1, 5, 6, 8)]
final_WSLA_DF<-na.omit(final_WSLA_DF)
 
saveRDS(final_WSLA_DF, file="./data/processed/final_WSLA_DF.rds")

###FOSSIL
###Moving forward, we must import the fossil data set with predicted log_lma values 
###and eliminate columns that we do not need for the prediction model. 

fossilpredictionsfinal<-read.csv("./data/processed/fossilpredictionsfinal.csv")
fossilpredictionsfinal<-fossilpredictionsfinal[c(5, 6, 8)]
colnames(fossilpredictionsfinal)[colnames(fossilpredictionsfinal)=="fit"]<- "log_LMA"

saveRDS(fossilpredictionsfinal, file="./data/processed/fossilpredictionsfinal.rds")
