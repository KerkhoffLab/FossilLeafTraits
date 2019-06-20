###Royer_tax_full family tally

royer_tax_full
options(max.print=10000) ###so it shows all of the counts instead of the set max of 500

tally<-
  royer_tax_na_omit %>%
  group_by(scrubbed_family) %>%
  tally()
print.data.frame(tally)
#create a new dataframe with data so i can keep it
library(xlsx)
write.csv(tallyliving, file="./data/tally.csv")
