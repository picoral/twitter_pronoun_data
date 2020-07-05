# load 00-utils script, which has libraries and functions
source("00-utils.R")

# load data
files_to_load <- dir("data/second_person")

all_second_person_tweets <- data.frame()
for (file in files_to_load) {
  print(file)
  this_file <- read_csv(paste0("data/second_person/", file), 
                        col_types = cols(mentions_user_id = "c"))
  all_second_person_tweets <- bind_rows(all_second_person_tweets, this_file)
}

# eliminate duplicate tweets
all_second_person_tweets <- all_second_person_tweets %>%
  unique() 

# filtered data
filtered_tweets <- all_second_person_tweets %>%
  select(user_id, created_at, text, source, our_location)


# tokens of interest in regex format
pronouns_regex <- c("\\btu\\b", "\\bvocê\\b", "\\bvoce\\b", "\\bcê\\b", 
                    "\\bce\\b", "\\bc\\b", "\\bvc\\b", "\\bocê\\b", "\\boce\\b", 
                    "\\bo senhor\\b", "\\ba senhora\\b", "\\bo snr\\b", 
                    "\\ba snra\\b", "\\bo sr\\b", "\\ba sra\\b", 
                    "\\ba senhorita\\b")

######## identify what pronounces are in the tweets
what_pronouns_df <- as.data.frame(sapply(pronouns_regex, grepl, filtered_tweets$text, ignore.case = TRUE))
what_pronouns_df$sum <- rowSums(what_pronouns_df)
tweets_with_pron_info <- bind_cols(filtered_tweets, what_pronouns_df)

tweets_with_pron_info$text <- gsub('\\n', ' <linebreak> ', tweets_with_pron_info$text)
colnames(tweets_with_pron_info) <- gsub('\\\\b', '', colnames(tweets_with_pron_info))
colSums(tweets_with_pron_info[,c(6:21)])
write_tsv(tweets_with_pron_info, "tweets_with_pron_info_second_person.tsv")
