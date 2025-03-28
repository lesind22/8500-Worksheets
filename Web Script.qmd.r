Indira Lessington 
Web Script 
Mar. 19th 2025



library(internetarchive)
library(tidyverse)
    ats_query <- c("publisher" = "The Crisis Publishing Company", "year" = "1930")
    ia_search(ats_query, num_results = 12)

    ia_search(c("publisher" = "the crisis publishing company", date = "1930"))

# ATS Query results succesful, now time to retrieve the metadata to create a data frame. 

 library("internetarchive")
 library(tidyverse)
    pub_crisis <- ia_get_items("sim_crisis_1930-07_37_7")
    ia_metadata(pub_crisis)
    ia_files(pub_crisis)
    
# From here we see that a Tibble is produced showing the id, file, as well as it's type. Next I will be creating a 
# a data frame to show The Crisis Magazine Publications from 1930. 

    ia_keyword_search("The Crisis Publishing Company", num_results = 12) %>% 
    ia_get_items() %>% 
    ia_metadata() %>% 
    filter(field == "json") %>% 
    select(value)

# The goal is to download the files from Internet Archive and then compile it all into a data frame. 






    filter(field == "1930") %>% 
    print(data.frame("sim_crisis_1930-07_37_7")
   















    pubcrisis <- ia_get_items("TheCrisisPublishingCompany")
    ia_metadata()
    ia_files()










        ia_keyword_search("sim_crisis_1930-07_37_7", num_results = 12) %>% 
        ia_get_items() %>% 
        ia_metadata() %>% 
    
        
        


# Fix area below too!!!!
library("internetarchive")
        ia_get_items("sim_crisis_1930-12_37_12")
        ia_metadata("sim_crisis_1930-12_37_12")
        ia_files("sim_crisis_1930-12_37_12")


#Fix area below before turning in Web Script!!!!!!
    result <- ia_get_items("sim_crisis_1930-05_37_5")
    result <- ia_get_items("sim_crisis_1930-03_37_3")
    result <- ia_get_items("sim_crisis_1930-01_37_1")
    result <- ia_get_items("sim_crisis_1930-08_37_8")
        ia_metadata()
        ia_files()

   library("internetarchive")
        result <- ia_get_items("sim_crisis_1930-07_37_7")
        result <- ia_get_items("sim_crisis_1930-10_37_10")
        result <- ia_get_items("sim_crisis_1930-02_37_2")
        result <- ia_get_items("sim_crisis_1930-04_37_4")
        result <- ia_get_items("sim_crisis_1930-06_37_6")
        result <- ia_get_items("sim_crisis_1930-09_37_9")
        ia_metadata()
        ia_files()

       