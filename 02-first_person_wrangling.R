# load 00-utils script, which has libraries and functions
source("00-utils.R")

# load data
files_to_load <- dir("data/first_person")

all_first_person_tweets <- data.frame()
for (file in files_to_load) {
  print(file)
  this_file <- read_csv(paste0("data/first_person/", file), 
                        col_types = cols(mentions_user_id = "c"))
  all_first_person_tweets <- bind_rows(all_first_person_tweets, this_file)
}

# eliminate duplicate tweets
all_first_person_tweets <- all_first_person_tweets %>%
  unique() 

# filtered data
filtered_tweets <- all_first_person_tweets %>%
  select(user_id, created_at, text, source, our_location)

# tokens of interest in regex format
pronouns_regex <- c("\\bnós\\b", "\\bnos\\b", "\\bnóis\\b", "\\bnois\\b", 
                    "\\bnóix\\b", "\\bnoix\\b", "\\bnóiz\\b", "\\bnoiz\\b", 
                    "\\bnóz\\b", "\\bnoz\\b", "a gente\\b", "a gnt\\b", 
                    "a gentchy\\b", "\\bagentchy\\b", "a gentchi\\b", 
                    "\\bagentchi\\b", "a gentch\\b", "\\bagentch\\b", 
                    "\\bagente\\b", "\\bagnt\\b")

######## identify what pronouns that are in the tweets
what_pronouns_df <- as.data.frame(sapply(pronouns_regex, grepl, filtered_tweets$text, ignore.case = TRUE))
what_pronouns_df$sum <- rowSums(what_pronouns_df)
tweets_with_pron_info <- bind_cols(filtered_tweets, what_pronouns_df)

tweets_with_pron_info$text <- gsub('\\n', ' <linebreak> ', tweets_with_pron_info$text)
colnames(tweets_with_pron_info) <- gsub('\\\\b', '', colnames(tweets_with_pron_info))
colSums(tweets_with_pron_info[,c(6:25)])
write_tsv(tweets_with_pron_info, "tweets_with_pron_info_first_person.tsv")