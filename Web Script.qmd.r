Indira Lessington 
Web Script 
Mar. 19th 2025



library("internetarchive")

    ats_query <- c("publisher" = "The Crisis Publishing Company", "year" = "1930")
    ia_search(ats_query, num_results = 12)

    ia_search(c("publisher" = "the crisis publishing company", date = "1930"))
    
# 14 AND REMAINDER OF SCRIPT WORK THROUGH ERRORS
 library("internetarchive")
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

       