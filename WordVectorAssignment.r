library(wordVectors)
library(tidyverse)

if (!file.exists("rec.txt")) prep_word2vec(origin = "TheCrisisMagazine", destination = "TheCrisisMagazine.txt", lowercase = T, bundle_ngrams = 1)


if (!file.exists("rec.bin")) {
    model <- train_word2vec("TheCrisisMagazine.txt", "rec.bin", vectors = 150, threads = 2, window = 12, iter = 5, negative_samples = 0)
} else {
    model <- read.vectors("rec.bin")
}

## Similarity searches

model %>% closest_to("death")
model %>% closest_to("young")
model %>% closest_to("education")
model %>% closest_to(c("education", "young"), n = 25) 

model %>% closest_to("South")
model %>% closest_to("occupation")
model %>% closest_to("college")
model %>% closest_to(c("college", "occupation"), n = 25)


# 20 most common words with education and young
# 20 most common words with college and occupation
education <- model[[c("education", "young"), average = F]]
educationyoung <- model[1:3000, ] %>% cosineSimilarity(education)
educationyoung <- educationyoung[
    rank(-educationyoung[, 1]) < 20 |
        rank(-educationyoung[, 2]) < 20,
]
plot(educationyoung, type = "n")
text(educationyoung, labels = rownames(educationyoung))

college <- model[[c("college", "occupation"), average = F]]
collegeoccupation <- model[1:3000, ] %>% cosineSimilarity(college)
collegeoccupation <- collegeoccupation[
    rank(-collegeoccupation[, 1]) < 20 |
        rank(-collegeoccupation[, 2]) < 20,
]
plot(collegeoccupation, type = "n")
text(collegeoccupation, labels = rownames(collegeoccupation))



# get 50 most common words to a group of terms - map those in space
# I also decided to compare the other graph using the other model created above
education <- model[[c("death", "young", "education", "women"), average = F]]
common_similiarities_education <- model[1:3000, ] %>% cosineSimilarity(education)
common_similiarities_education[20:30, ]

high_similarities_to_women_education <- common_similiarities_education[rank(-apply(common_similiarities_education, 1, max)) < 75, ]
high_similarities_to_women_education %>%
    prcomp() %>%
    biplot(main = "Fifty words in a \n projection of women and education.")




occupation <- model[[c("South", "college", "occupation", "women"), average = F]]
common_similarities_occupation <- model[1:3000, ] %>% cosineSimilarity(occupation)
common_similarities_occupation[20:30, ]


high_similarities_to_women_occupation <- common_similarities_occupation[rank(-apply(common_similarities_occupation, 1, max)) < 75, ]
high_similarities_to_women_occupation %>%
    prcomp() %>%
    biplot(main = "Fifty words in a /n projection of women and occupation")



# Using calculations to find words that are more used with women vs men etc.
# THIS SECTION SHOULD USE CLOSEST_TO NOT NEAREST_TO


library(dplyr)
library(wordVectors)

closest_to_word <- function(word) {
  model %>%
    closest_to(model[[word]]) %>%
    round(3)
}

closest_to_word("women")
closest_to_word("men")
closest_to_word("girls" - "boys")
closest_to_word(c("she", "her", "women", "woman") - c("he", "his", "man", "men"))


wowords <- model[[c("female", "females", "women", "woman", "feminine", "she", "woman's")]] %>%
  reject(model[[c("male", "males", "men", "man", "masculine", "he", "men's")]])


model %>% closest_to(wowords, 100)


gender_vector <- model[[c("feminine", "feminity", "woman", "women")]] -
  model[[c("masculine", "masculinity", "men", "man")]]


gender_vectors <- data.frame(word = rownames(model))
gender_vectors$gender_score <- cosineSimilarity(model, gender_vector) %>% as.vector()

library(ggplot2)
gender_vectors %>%
  filter(abs(gender_score) > 0.33) %>%
  ggplot(aes(y = gender_score, x = reorder(word, gender_score), fill = gender_score < 0)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  scale_fill_discrete("Indicative of gender", labels = c("Feminine", "Masculine")) +
  labs(title = "The words showing the strongest skew along the gender binary")





## Clustering

library(dplyr)

if (!file.exists("rec.txt")) prep_word2vec(origin = "TheCrisisMagazine", destination = "TheCrisisMagazine.txt", lowercase = T, bundle_ngrams = 1)


if (!file.exists("rec.bin")) {
    model <- train_word2vec("TheCrisisMagazine.txt", "rec.bin", vectors = 150, threads = 2, window = 12, iter = 5, negative_samples = 0)
} else {
    model <- read.vectors("rec.bin")
}
set.seed(10)
centers <- 150
clustering <- kmeans(model, centers = centers, iter.max = 40)

sapply(sample(1:centers, 10), function(n) {
    names(clustering$cluster[clustering$cluster == n][1:10])
})




## Dendograms
library(wordVectors)
library(ggplot2)

education_young <- c("death", "professor", "occupation", "graduates")

term_set <- lapply(
  education_young,
  function(term) { 
    closest_words <- model %>% closest_to(model[[term]], 20)  
    closest_words$word 
  }
) %>% unlist() 
subset <- model[[term_set, average = FALSE]]  
subset %>%
  cosineDist(subset) %>%  
  as.dist() %>%           
  hclust() %>%            
  plot(main = "Dendrogram of Selected Terms")







# The overall word vector script analyzes about 45 The Crisis Magazine .txt files downloaded into a folder and then imported into VSCode to run the code. 
# From the first-word similarity model, I can infer that the word "christian" (no capitalization in output, not the computer's responsibility to recognize whether or not it is supposed to be) became more associated with the word "young". 
# I did not find this shocking because, in the early 1920s, there was an initiative to drive younger people to Christianity, which checks out when evaluating the output. 
# Also during this era, AME (African Methodist Episcopal) churches and other denominations appealed to the younger crowds as stated, and it is critical to note that these marketing strategies geared towards advertisements of 
# churches and HBCUs (Historically Black Colleges and Universities) founded post-Civil War mission aligned with different Black church denominations. 
# There is no better way to market to young individuals than to advertise, and this is seen constantly through all .txt files.
# In the common word sections, I noticed the words "vocational," "training," "hygiene," "instruction," and "industrial" are clustered when plotted on the graph. 
#I believe that this is critical to mention because "vocational," "training," and "hygiene" are gender-related to women, which I think was quite thought-provoking.
# Regarding "instruction" and "industrial," the words are more gender-related to men. 
# Overall, the results of this group of words show that, computationally, some words lean towards one side of the gender spectrum than the other. 
# Also, during the early 1900s, women were not professors. Still, they are associated with some form of teaching, hence the use of "vocational." 
# It is interesting to see the comparison between them all because now 2025, if The Crisis magazine was published in 2025, I believe the gender spectrum would result differently. 
# The results were mapped in space, and it was intriguing. "Churches," "children," and "tuberculosis" being clustered together put many things into perspective. I noticed that church aid became frequent and also that the tuberculosis epidemic ran rampant throughout the US from 1827 to 1920, and children were heavily affected. 
# I found this profound because I noticed that when the epidemic started, most of the .txt files ranged from 1927 to 1930, and The Crisis Magazine was the advocate for pre-screening and testing sites. 
# Furthermore, the other visualization generated compared "women" and education" and noticed that they're far apart in space; in reality, it makes perfect sense for the historical period. In the clustering section, the goal was to analyze the patterns of certain words and see if there are any similarities among magazine buyers' behavior. 
# In theory, I wanted to analyze the magazine's influence in Northern or Southern states. 
# I tried to analyze the relationship with the selected words in the dendrogram section, but my VSCode is not on my side.
# Nonetheless, the word vector analysis offers a different lens into what the magazine stood for and, alongside that, the gender-binary specifics of certain words, which is genuinely intriguing, and it is a technique I want to perfect to use. 
