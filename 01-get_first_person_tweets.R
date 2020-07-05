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
search_string_1st_person <- 'nós OR nos OR nóis OR nois OR nóix OR noix OR nóiz OR noiz OR nóz OR noz OR "a gente" OR "a gnt" OR "a gentchy" OR agentchy OR "a gentchi" OR agentchi OR "a gentch" OR agentch OR agente OR agnt OR "a\'ente" -filter:retweets'

# set our n (number of tweets retrieve) to a really high number to try to get
# all of the tweets
n = 1000000

# get and save tweets for each region
pron_jp_1st_person <- get_and_save_tweets(search_string_1st_person,
                                          geocode_jp,
                                           n, "João Pessoa")

pron_recife_1st_person <- get_and_save_tweets(search_string_1st_person,
                                              geocode_recife,
                                              n, "Recife")

pron_salvador_1st_person <- get_and_save_tweets(search_string_1st_person,
                                                geocode_salvador,
                                                n, "Salvador")

pron_rio_1st_person <- get_and_save_tweets(search_string_1st_person,
                                           geocode_rio,
                                           n, "Rio de Janeiro")

pron_sp_1st_person <- get_and_save_tweets(search_string_1st_person,
                                          geocode_sp,
                                          n, "São Paulo")

pron_floripa_1st_person <- get_and_save_tweets(search_string_1st_person,
                                               geocode_floripa,
                                               n, "Florianópolis")

pron_poa_1st_person <- get_and_save_tweets(search_string_1st_person,
                                           geocode_poa,
                                            n, "Porto Alegre")

