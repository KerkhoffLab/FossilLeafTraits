##Model testing

model1<-lmer(log_lma~log_pet_leafarea + (1+log_pet_leafarea|superorder/order/scrubbed_family), data=royer_tax_new)
model2<-lmer(log_lma~log_pet_leafarea+(1+log_pet_leafarea|order/scrubbed_family), data=royer_tax_new)
model3<-lmer(log_lma~log_pet_leafarea + (1+log_pet_leafarea|scrubbed_family), data=royer_tax_new)
model4<-lmer(log_lma~log_pet_leafarea + (1|superorder/order/scrubbed_family), data=royer_tax_new)
model5<-lmer(log_lma~log_pet_leafarea + (1|order/scrubbed_family), data=royer_tax_new)
model6<-lmer(log_lma~log_pet_leafarea + (1|scrubbed_family), data=royer_tax_new)

anova(model1, model2, model3, model4, model5, model6)

model7<-lmer(log_lma~log_pet_leafarea + (1+log_pet_leafarea|))

summary(model3)
