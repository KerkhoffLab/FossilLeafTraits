###We now need to add order and superorder information to final_WSLA_
## Look up superorder and order with BIEN (literally do not run this code its saved as a csv)

species_df <- data.frame(binomial = unique(final_WSLA_DF$binomial))
species_df$binomial <- gsub("_", " ", species_df$binomial)
species_df$binomial <- as.character(species_df$binomial)
species_df$order <- NA
species_df$superoder <- NA

species_df2 <- species_df

for (i in 1091:length(species_df$binomial)){
  
  cat(paste("Extracting species", i, "\n"))
  tmp <- BIEN_taxonomy_species(species_df$binomial[i])
  
  if (length(tmp)!=0){
    
    species_df$order[i] <- unique(tmp$order)
    species_df$superoder[i] <- unique(tmp$superorder)
    
  }else{
    
    species_df$order[i] <- NA
    species_df$superoder[i] <- NA
    
  }
  
  
}

species_df$order <- unlist(species_df$order)
species_df$superoder <- unlist(species_df$superoder)
names(species_df)[3] <- "superorder"

write.csv(species_df, file="./data/processed/species_df.csv")