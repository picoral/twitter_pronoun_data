# load libraries
library(rtweet)
library(skimr)
library(tidyverse)
library(tidytext)

# transforma listas (colunas) em caracteres/string
set_lists_to_chars <- function(x) {
  if (class(x) == 'list') {
    y <- paste(unlist(x[1]), sep = '', collapse = ', ')
  } else {
    y <- x
  }
  return(y)
}

df_with_lists_to_csv <- function(my_df) {
  new_df <- data.frame(lapply(my_df, set_lists_to_chars),
                       stringsAsFactors = F)
  return(new_df)
}

get_and_save_tweets <- function(search_string, 
                                geolocation_string,
                                n, location_name_string) {
  # get data
  tweets_df <- search_tweets(
    search_string, 
    n = n, 
    include_rts = FALSE, lang = "pt",
    geocode = geolocation_string,
    retryonratelimit = TRUE,
    type = "mixed"
  )
  
  # add location info so we don't lose it when combining everything together
  tweets_df$our_location <- location_name_string
  
  # flatten lists so data can be saved to disk
  pron_to_save <- df_with_lists_to_csv(tweets_df)
  
  # remove punctuation and diacritics from filename to ensure it can be saved
  # to disk across different platforms
  new_filename <- paste0(location_name_string, '_', Sys.time() ,".csv")
  new_filename <- gsub(":|\\s", "_", new_filename)
  new_filename <- gsub("ã", "a", new_filename)
  new_filename <- gsub("ó", "o", new_filename)
  
  # save file to disk
  write_csv(pron_to_save, new_filename)
  
  return(tweets_df)
}
