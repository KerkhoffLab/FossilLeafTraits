###COUNTS OF FAMILY OBSERVATIONS FOR EACH FAMILY REPRESENTED 

###Separate fossil binomial into genus and species
require(tidyr)
separatedfossil<-extract(all_fossil,c("binomial"), c("Genus", "Species"), "([[:alnum:]]+)_([[:alnum:]]+)")

##Get family information from living data (already there, don't need to separate genus and species)
require(tidyverse)
###LIVING
###Find counts of family observations for each genus represented
options(max.print=10000) ###so it shows all of the counts instead of the set max of 500
final_WLSA_DF<-read.csv("./data/processed/finalWSLADF.csv")
tallyliving<-
  final_WLSA_DF %>%
  group_by(scrubbed_family) %>%
  tally()
print.data.frame(tallyliving)
#create a new dataframe with data so i can keep it
library(xlsx)
write.csv(tallyliving, file="./data/livingtally.csv")


###RENAMING LIVING DATASET COLUMN
require(dplyr)
colnames(tallyliving)
names(tallyliving)[names(tallyliving) == "scrubbed_family"]<- "Family"
print.data.frame(tallyliving)
###creates new dataframe with data so I can keep it
library(xlsx)
write.csv(tallyliving, file="./data/livingtally.csv")

####FOSSIL
###Find counts of observations for each family represented
require(tidyverse)
options(max.print=100000) ###so it shows all of the counts instead of the set max of 500
fossiltallyfamily<-read.csv("./data/fossiltallyfamily.csv")
tallyfossil<-
  fossiltallyfamily %>%
  group_by(Family) %>%
  tally()
print.data.frame(tallyfossil)
###creates new dataframe with data so I can keep it
library(xlsx)
write.csv(tallyfossil, file="./data/fossiltally.csv")


###ARE THERE FOSSIL FAMILIES NOT REPRESENTED IN LIVING TAXA?

af<-tallyliving
af
bf<-tallyfossil
bf
library(dataCompareR)
compGenus<-rCompare(af, bf, keys=)
summary(compGenus)

