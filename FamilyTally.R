###COUNTS OF FAMILY OBSERVATIONS FOR EACH FAMILY REPRESENTED 

###Separate fossil binomial into genus and species
require(tidyr)
separatedfossil<-extract(all_fossil,c("binomial"), c("Genus", "Species"), "([[:alnum:]]+)_([[:alnum:]]+)")

##Get family information from living data (already there, don't need to separate genus and species)
require(tidyverse)
###LIVING
###Find counts of family observations for each genus represented
options(max.print=10000) ###so it shows all of the counts instead of the set max of 500
tallyliving<-
  final_WLSA_DF %>%
  group_by(scrubbed_family) %>%
  tally()
print.data.frame(tallyliving)
#create a new dataframe with data so i can keep it
library(xlsx)
write.csv(tallyliving, file="./data/livingtally.csv")




#HERES WHERE ITS CHALKED


###IGNORE FOR NOW DID IT MANUALLY

###Finding family information for fossils
require(taxize)
###way #1 i tried
spnames<-list(tallyfossil$Genus)
test<-classification("Acer", db='itis')

###way #2 i tried
tax_name(query=spnames, get="family")
tax_name(query="Sapindus", get="family")
tax_name(query="Populus", get="family")
tax_name(query="Ulmus", get="family")
tax_name(query="Mimosites", get="family")

###trying to fix the names im realizing are f***ed
temp<-gnr_resolve(spnames)
temp

tnrs(query=spnames)
###this way works but only for one obs at a time...
  ##this is probably the most promising ^^^^

###Way #3 i tried
if (requireNamespace("vegan", quietly = TRUE)){
  # use dune dataset
  library("vegan")
  data(dune, package='vegan')
  genera <- c(spnames)
  colnames(dune) <- genera

  # aggregate sample to families
  (agg <- tax_agg(dune, rank = 'family', db = 'ncbi', api_key="1dd395ebd5001a6ff35ccedbfe8ee8fd8d0a"))
  # extract aggregated community data matrix for further usage
  agg$x
  # check which taxa have been aggregated
  agg$by
}
##^^^this doesn't work

###IGNORE FOR NOW DID IT MANUALLY ^^^^ lines 29-67

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

