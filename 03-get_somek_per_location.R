library(tidyverse)

data_foder <- "data/merged_by_type/"
dir(data_foder)

first_person_tweets <- read_tsv(paste0(data_foder, 
                                       "tweets_with_pron_info_first_person.tsv")
                                )

second_person_tweets <- read_tsv(paste0(data_foder, 
                                       "tweets_with_pron_info_second_person.tsv")
)

# get summary
first_person_tweets %>%
  group_by(our_location) %>%
  count()

second_person_tweets %>%
  group_by(our_location) %>%
  count()

# get random tweets
set.seed(42)

selected_locations_first <- c("Porto Alegre",
                              "Rio de Janeiro")

rio_poa_first <- first_person_tweets %>% 
  filter(our_location %in% selected_locations_first) %>%
  group_by(our_location) %>% 
  sample_n(1500)

jp_first <- first_person_tweets %>% 
  filter(our_location == "João Pessoa")

first_batch_first_person <- bind_rows(rio_poa_first,
                                      jp_first)

# get summary
first_batch_first_person %>%
  group_by(our_location) %>%
  count()

colnames(first_batch_first_person)

first_batch_first_person_long <- first_batch_first_person %>%
  pivot_longer(names_to = "pronoun",
               cols = c(-user_id, -created_at, -text, -source, -our_location, -sum)) %>%
  filter(value == 1) %>%
  select(-value)

write_tsv(first_batch_first_person_long, "first_batch_first_person_long.tsv")

# get random tweets second person
rio_second <- second_person_tweets %>% 
  filter(our_location == "Rio de Janeiro") %>% 
  sample_n(1500)

first_batch_second_person <- rio_second

first_batch_second_person_long <- first_batch_second_person %>%
  pivot_longer(names_to = "pronoun",
               cols = c(-user_id, -created_at, -text, -source, -our_location, -sum)) %>%
  filter(value == 1) %>%
  select(-value)
  
  
write_tsv(first_batch_second_person_long, "first_batch_second_person_long.tsv")  

