library(jsonlite)
library(httr)
library(tidyverse)

ia_keyword_search("pub_TheCrisis", num_results = 100) %>%
    ia_get_items() %>%
    ia_metadata() %>% 
    filter(field == "front cover") %>%
    select(value)
