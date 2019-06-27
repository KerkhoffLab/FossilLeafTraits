##01_data_prep is a very important file and all of the data 
###cleaning and fixing and saving occurs in this file


###02_data_observations is literally just graphs and analyses and doesn't do 
###anything for the full model


###03_phylogenetics_test_area is where logistic regression predictions 
###on deciduous vs evergreen for fossils is located on line 252. This is the 
###only important thing in this file

###04_fossil_integration does some weird things i don't understand but I really
###don't think it will ever come up again or be necessary in any way shape or form


###05_pem_predictions is creation of all components required for PEM (Phylogenetic Eigenvector Mapping)
###analysis (i should learn what that is ?)Not sure if it's important for later on ask kerkhoff

###06_function_creation I could not tell you what is happening in this file if my life
###depended on it 
###Okay looked at final script and it's used there but the entire function is put in first so 
###I think this file is unnecessary 


###07_mixed_effects this file does the mixed effects modeling stuff and is necessary for 
###running any analyses that have to do with the model
###okay so im realizing that i fixed this in  model table so im gonna fix this stuff rn
##okay its fixed but theres some weird stuff happening in that code that 
###doesn't need to be there
###nothing here is important except the beginning and the predictions at the end


###08_full_analysis_script is the full script for modeling and predicting LMA and phenology from fossil data
##starts by putting in functions that are needed from 06_function_creation
###then goes throught the mixed effects modeling stuff (has to be edited)
###goes through extant family predictions which i dont quite understand but I dont
###think necessarily needs to be there 
##then there's some plotting
###then theres logisitic regression predicting phenlogoy off of log_lma but its so short?
###is that all???






