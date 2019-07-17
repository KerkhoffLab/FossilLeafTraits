###final_WSLA_DF
final_WSLA_DF<-readRDS("03_final_WSLA_DF", file = "./data/processed/03_finalWSLADF.rds")
###Changing column names so they match up between files
colnames(final_WSLA_DF)[colnames(final_WSLA_DF)=="n"]<-"count"


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
final_WSLA_DF$log_SLA<-log(as.numeric(final_WSLA_DF$SLA))
final_WSLA_DF<-final_WSLA_DF[-c(1, 5, 6, 7, 9)]

final_WSLA_DF<-na.omit(final_WSLA_DF)


mod1<-glmer(Phenology2~log_LMA+(1+log_LMA|superorder/order/scrubbed_family), family="binomial", data=final_WSLA_DF)
mod2<-glmer(Phenology2~log_LMA+(1+log_LMA|order/scrubbed_family), family="binomial", data=final_WSLA_DF)
mod3<-glmer(Phenology2~log_LMA+(1+log_LMA|scrubbed_family), family="binomial", data=final_WSLA_DF)

mod4<-glmer(Phenology2~log_LMA+(0+log_LMA|superorder/order/scrubbed_family), family="binomial", data=final_WSLA_DF)
mod5<-glmer(Phenology2~log_LMA+(0+log_LMA|order/scrubbed_family), family="binomial", data=final_WSLA_DF)
mod6<-glmer(Phenology2~log_LMA+(0+log_LMA|scrubbed_family), family="binomial", data=final_WSLA_DF)

mod7<-glmer(Phenology2~log_LMA+(1|superorder/order/scrubbed_family), family="binomial", data=final_WSLA_DF)
mod8<-glmer(Phenology2~log_LMA+(1|order/scrubbed_family), family="binomial", data=final_WSLA_DF)
mod9<-glmer(Phenology2~log_LMA+(1|scrubbed_family), family="binomial", data=final_WSLA_DF)

mod10<-glmer(Phenology2~log_LMA+(1|scrubbed_family)+(1|order)+(1|superorder), family="binomial", data=final_WSLA_DF)
mod11<-glmer(Phenology2~log_LMA+(0+log_LMA|scrubbed_family)+(0+log_LMA|order)+(0+log_LMA|superorder), family="binomial", data=final_WSLA_DF)
mod12<-glmer(Phenology2~log_LMA+(1+log_LMA|scrubbed_family)+(1+log_LMA|order)+(1+log_LMA|superorder), family="binomial", data=final_WSLA_DF)


###NEW


###log_LMA+log_SLA+(log_SLA)

mog1<-glmer(Phenology2~log_LMA+log_SLA+(1+log_SLA|superorder/order/scrubbed_family), family="binomial", data=final_WSLA_DF)
mog2<-glmer(Phenology2~log_LMA+log_SLA+(1+log_SLA|order/scrubbed_family), family="binomial", data=final_WSLA_DF)
mog3<-glmer(Phenology2~log_LMA+log_SLA+(1+log_SLA|scrubbed_family), family="binomial", data=final_WSLA_DF)

mog4<-glmer(Phenology2~log_LMA+log_SLA+(0+log_SLA|superorder/order/scrubbed_family), family="binomial", data=final_WSLA_DF)
mog5<-glmer(Phenology2~log_LMA+log_SLA+(0+log_SLA|order/scrubbed_family), family="binomial", data=final_WSLA_DF)
mog6<-glmer(Phenology2~log_LMA+log_SLA+(0+log_SLA|scrubbed_family), family="binomial", data=final_WSLA_DF)

mog7<-glmer(Phenology2~log_LMA+log_SLA+(1|superorder/order/scrubbed_family), family="binomial", data=final_WSLA_DF)
mog8<-glmer(Phenology2~log_LMA+log_SLA+(1|order/scrubbed_family), family="binomial", data=final_WSLA_DF)
mog9<-glmer(Phenology2~log_LMA+log_SLA+(1|scrubbed_family), family="binomial", data=final_WSLA_DF)

mog10<-glmer(Phenology2~log_LMA+log_SLA+(1|scrubbed_family)+(1|order)+(1|superorder), family="binomial", data=final_WSLA_DF)
mog11<-glmer(Phenology2~log_LMA+log_SLA+(0+log_SLA|scrubbed_family)+(0+log_SLA|order)+(0+log_SLA|superorder), family="binomial", data=final_WSLA_DF)
mog12<-glmer(Phenology2~log_LMA+log_SLA+(1+log_SLA|scrubbed_family)+(1+log_SLA|order)+(1+log_SLA|superorder), family="binomial", data=final_WSLA_DF)


mog10<-glmer(Phenology2~log_LMA+log_SLA +(log_LMA|superorder), 
             family="binomial", data=final_WSLA_DF)



ggplot(final_WSLA_DF, aes(x=log_LMA, y=Phenology2, color = superorder )) + geom_point() + 
  stat_smooth(method="glm", method.args=list(family="binomial"), se=TRUE)


final_WSLA_DF %>% 
ggplot(aes( x = superorder, y = log_SLA)) +
  geom_boxplot()

###log_LMA+log_SLA
mog13<-glmer(Phenology2~log_LMA+log_SLA+(1+log_LMA|superorder/order/scrubbed_family), family="binomial", data=final_WSLA_DF)
mog14<-glmer(Phenology2~log_LMA+log_SLA+(1+log_LMA|order/scrubbed_family), family="binomial", data=final_WSLA_DF)
mog15<-glmer(Phenology2~log_LMA+log_SLA+(1+log_LMA|scrubbed_family), family="binomial", data=final_WSLA_DF)

mog16<-glmer(Phenology2~log_LMA+log_SLA+(0+log_LMA|superorder/order/scrubbed_family), family="binomial", data=final_WSLA_DF)
mog17<-glmer(Phenology2~log_LMA+log_SLA+(0+log_LMA|order/scrubbed_family), family="binomial", data=final_WSLA_DF)
mog18<-glmer(Phenology2~log_LMA+log_SLA+(0+log_LMA|scrubbed_family), family="binomial", data=final_WSLA_DF)

mog19<-glmer(Phenology2~log_LMA+log_SLA+(0+log_LMA|scrubbed_family)+(0+log_LMA|order)+(0+log_LMA|superorder), family="binomial", data=final_WSLA_DF)
mog20<-glmer(Phenology2~log_LMA+log_SLA+(1+log_LMA|scrubbed_family)+(1+log_LMA|order)+(1+log_LMA|superorder), family="binomial", data=final_WSLA_DF)

