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
    filter(field == "txt") %>% 
    select(value)

# The goal is to download the files from Internet Archive and then compile it all into a data frame. 

library(dplyr)
    dir <- tempdir()
    ia_search(ats_query, <- c("publisher" = "The Crisis Publishing Company", "year" = "1930")) %>% 
    ia_get_items() %>% 
    ia_files() %>% 
    filter(type == "pdf") %>% 
    group_by(id) %>% 
    slice(1) %>% 
    ia_download(dir = dir, overwrite = FALSE) %>% 
    glimpse()

# Here I wanted to put all of the items into one data frame. (Consultation of Copilot after
# the exhaustion of trial and error)
    library(tidyverse)
    identifiers <- c("sim_crisis_1930-01_37_1", 
        "sim_crisis_1930-08_37_8",  
        "sim_crisis_1930-02_37_2", 
        "sim_crisis_1930-03_37_3",
        "sim_crisis_1930-05_37_5",
        "sim_crisis_1930-11_37_11",
        "sim_crisis_1930-07_37_7",
        "sim_crisis_1930-10_37_10",
        "sim_crisis_1930-12_37_12",
        "sim_crisis_1930-04_37_4",
        "sim_crisis_1930-06_37_6",
        "sim_crisis_1930-09_37_9"

    )
        metadata_list <- list ()
            for (id in identifiers) {
                item <- ia_get_items(item)
                metadata_list[[id]] <- metadata
            }
    metadata_df <- bind_rows(metadata_list, .id = "identifier")
    print(metadata_df)

# It appears that the dataframe is empty so it is my job to create a function for 
# all 12 of these files to be transfered to it. 

library(internetarchive)
library(tidyverse)

identifiers <- c(
  "sim_crisis_1930-01_37_1", 
  "sim_crisis_1930-08_37_8",  
  "sim_crisis_1930-02_37_2", 
  "sim_crisis_1930-03_37_3",
  "sim_crisis_1930-05_37_5",
  "sim_crisis_1930-11_37_11",
  "sim_crisis_1930-07_37_7",
  "sim_crisis_1930-10_37_10",
  "sim_crisis_1930-12_37_12",
  "sim_crisis_1930-04_37_4",
  "sim_crisis_1930-06_37_6",
  "sim_crisis_1930-09_37_9"
)

metadata_list <- list()

for (id in identifiers) {
  item <- ia_get_items(id)
  metadata <- ia_metadata(item) 
  metadata_list[[id]] <- metadata 
}
    metadata_df <- bind_rows(metadata_list, .id = "identifier")
    print(metadata_df)

# Now the data frame is created, now I want to expand the data frame to include more columns.
# Which also calls for another "for" statement

identifiers <- c(
  "sim_crisis_1930-01_37_1", 
  "sim_crisis_1930-08_37_8",  
  "sim_crisis_1930-02_37_2", 
  "sim_crisis_1930-03_37_3",
  "sim_crisis_1930-05_37_5",
  "sim_crisis_1930-11_37_11",
  "sim_crisis_1930-07_37_7",
  "sim_crisis_1930-10_37_10",
  "sim_crisis_1930-12_37_12",
  "sim_crisis_1930-04_37_4",
  "sim_crisis_1930-06_37_6",
  "sim_crisis_1930-09_37_9"
)

    metadata_list <- list()

    for (id in identifiers) {
        item <- ia_get_items(id)
        metadata <- ia_metadata(item)
    }

        metadata_list[[id]] <- tibble(
            identifier = id,
            title = metadata$TheCrisisMagazine %||%
            creator = metadata$TheCrisisPublishingCompany %||% 
            date = metadata$1930 %||%
            language = metadata$english %||%
        )
    metadata_df <- bind_rows(metadata_list)
    print(metadata_df)

# In this last section of the script I will be downloading pdf files of the 12 Crisis Magazine that were retrieved. 

    

        











   























       

   
        

       