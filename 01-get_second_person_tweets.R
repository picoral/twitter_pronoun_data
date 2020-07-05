# load 00-utils script, which has libraries and functions
source("00-utils.R")

# site com geolocations: https://www.latlong.net/place/sao-paulo-city-s-o-paulo-brazil-3675.html
geocode_jp <- "-7.115250,-34.861050,10mi"
geocode_recife <- "-8.052240,-34.928612,10mi"
geocode_salvador <- "-12.977749,-38.501629,20mi"
geocode_rio <- "-22.906847,-43.172897,12mi"
geocode_sp <- "-23.550520,-46.633308,15mi"
geocode_floripa <- "-27.613035,-48.435082,20mi"
geocode_poa <- "-30.034647,-51.217659,10mi"

# search string, we don't want retweets because the location messes up, the user
# is not the original author
search_string_2nd_person <- 'tu OR você OR voce OR cê OR ce OR c OR vc OR ocê OR oce OR "o senhor" OR "a senhora" OR "o snr" OR "a snra" OR "o sr" OR "a sra" OR "a senhorita" -filter:retweets'

# set our n (number of tweets retrieve) to a really high number to try to get
# all of the tweets
n = 1000000

# get and save tweets for each region
pron_jp_2nd_person <- get_and_save_tweets(search_string_2nd_person,
                                          geocode_jp,
                                          n, "João Pessoa")

pron_recife_2nd_person <- get_and_save_tweets(search_string_2nd_person,
                                              geocode_recife,
                                              n, "Recife")

pron_salvador_2nd_person <- get_and_save_tweets(search_string_2nd_person,
                                                geocode_salvador,
                                                n, "Salvador")

pron_rio_2nd_person <- get_and_save_tweets(search_string_2nd_person,
                                           geocode_rio,
                                           n, "Rio de Janeiro")

pron_sp_2nd_person <- get_and_save_tweets(search_string_2nd_person,
                                          geocode_sp,
                                          n, "São Paulo")

pron_floripa_2nd_person <- get_and_save_tweets(search_string_2nd_person,
                                               geocode_floripa,
                                               n, "Florianópolis")

pron_poa_2nd_person <- get_and_save_tweets(search_string_2nd_person,
                                           geocode_poa,
                                           n, "Porto Alegre")
