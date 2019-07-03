##Model testing
require(lme4)
require(dplyr)


royer_tax_full <- readRDS("./data/processed/07_lm4_royer")
royer_tax_na_omit<-na.omit(royer_tax_full)  
royer_tax_na_omit$scrubbed_family[royer_tax_na_omit$scrubbed_family=="Unknown"] <- ""

royer_tax_count<-royer_tax_na_omit%>%
  group_by(scrubbed_family)%>%
  mutate(count=n())
royer_tax_count

royer_tax_new<-subset(royer_tax_count, count>3 & scrubbed_family!="")


model1<-lmer(log_lma~log_pet_leafarea + (1+log_pet_leafarea|superorder/order/scrubbed_family), data=royer_tax_new)
model2<-lmer(log_lma~log_pet_leafarea+(1+log_pet_leafarea|order/scrubbed_family), data=royer_tax_new)
model3<-lmer(log_lma~log_pet_leafarea + (1+log_pet_leafarea|scrubbed_family), data=royer_tax_new)
model4<-lmer(log_lma~log_pet_leafarea + (1|superorder/order/scrubbed_family), data=royer_tax_new)
model5<-lmer(log_lma~log_pet_leafarea + (1|order/scrubbed_family), data=royer_tax_new)
model6<-lmer(log_lma~log_pet_leafarea + (1|scrubbed_family), data=royer_tax_new)

modcompare<-anova(model1, model2, model3, model4, model5, model6)
modcompare$logLik

model7<-lmer(log_lma~log_pet_leafarea + (1+log_pet_leafarea|))

summary(model3)




model1<-lmer(log_lma~log_pet_leafarea + (1+log_pet_leafarea|superorder/order/scrubbed_family), data=royer_tax_new)
model2<-lmer(log_lma~log_pet_leafarea+(1+log_pet_leafarea|order/scrubbed_family), data=royer_tax_new)
model3<-lmer(log_lma~log_pet_leafarea + (1+log_pet_leafarea|scrubbed_family), data=royer_tax_new)
model4<-lmer(log_lma~log_pet_leafarea + (1|superorder/order/scrubbed_family), data=royer_tax_new)
model5<-lmer(log_lma~log_pet_leafarea + (1|order/scrubbed_family), data=royer_tax_new)
model6<-lmer(log_lma~log_pet_leafarea + (1|scrubbed_family), data=royer_tax_new)

modcompare<-anova(model1, model2, model3, model4, model5, model6)



library(data.table)

DT<-as.data.table(modcompare, keep.rownames = TRUE)
DT<-DT[,rank:=rank(AIC, ties.method = "first")]
DT<-DT[order(DT$rank)]

print(DT, row.names=FALSE)
dt<-subset(DT, select=c("rank", "rn", "Df", "AIC", "BIC", "logLik", "deviance", "Chisq", "Pr(>Chisq)" ))
table<-kable(dt, align='c')%>%
  kable_styling(bootstrap_options="striped", full_width=F)
table


###what mdoel table used to be
