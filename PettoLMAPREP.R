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
###In order to run this model, we must first fix the royer_tax_full 
###data set so it does not contain NA values, all "Unknown" values 
###show up as blanks, and occurence data is shown alongside each observation. 
###Then, all families with an occurence count of less than 3 are omitted. 

royer_tax_full <- readRDS("./data/processed/07_lm4_royer")
royer_tax_na_omit<-na.omit(royer_tax_full)  

### Replacing "Unknown" with ""
royer_tax_na_omit$scrubbed_family[royer_tax_na_omit$scrubbed_family=="Unknown"] <- ""


tally<-tally(royer_tax_na_omit$scrubbed_family)
##Making the data able to be analyzed for slopes
###Adding occurence counts to dataset
royer_tax_count<-royer_tax_na_omit%>%
  group_by(scrubbed_family)%>%
  mutate(count=n())
royer_tax_count

###Removing observations of singular families n<3 and empty families
royer_tax_new<-subset(royer_tax_count, count>3 & scrubbed_family!="")

write.csv(royer_tax_new, file="./data/processed/royer_tax_new.csv")


###Moving forward, we must create the fossil data set made up of 3 different data sets,
###and get rid of NA values, separate scrubbed_genus and species from within binomial, 
###and create the log version of log pet leaf area. 

florissant_fossil_int <- readRDS("./data/processed/04_florissant_fossil_clean.rds")
renova_fossil_int <- readRDS("./data/processed/04_renova_fossil_clean.rds")
bridgecreek_fossil_int <- readRDS("./data/processed/04_bridgecreek_fossil_clean.rds")

fossil_comb <- rbind(florissant_fossil_int,renova_fossil_int,bridgecreek_fossil_int)
fossil_gen <- fossil_comb$Genus
fossil_gen <- unique(fossil_gen)
fossil_gen_df <- as.data.frame(fossil_gen)
fossil_tax <- BIEN_taxonomy_genus(fossil_gen)
fossil_tax <- fossil_tax[-c(1,7:9)]
fossil_tax <- unique(fossil_tax)

all_fossil <- rbind(florissant_fossil_int, renova_fossil_int, bridgecreek_fossil_int)
all_fossil$binomial <- paste(all_fossil$Genus, all_fossil$species)
all_fossil$binomial <- str_replace_all(all_fossil$binomial,"\\s+","_")
all_fossil <- all_fossil[-c(1,2)]

all_fossil_LMEpred <- all_fossil %>%
  separate(binomial,
           c("scrubbed_genus", "species"))
all_fossil_royer_pred <- left_join(all_fossil_LMEpred, fossil_tax, by = "scrubbed_genus")

all_fossil_royer_pred <- na.omit(all_fossil_royer_pred)
all_fossil_royer_pred <- unique(all_fossil_royer_pred)


colnames(all_fossil_royer_pred)[colnames(all_fossil_royer_pred)=="PW^2/A"] <- "pet_leafarea"
colnames(all_fossil_royer_pred)[colnames(all_fossil_royer_pred)=="LMA (g/m^2)"] <- "LMA"

all_fossil_royer_pred$log_pet_leafarea<-log(all_fossil_royer_pred$pet_leafarea)

write.csv(all_fossil_royer_pred, file="./data/processed/all_fossil_royer_pred.csv")

