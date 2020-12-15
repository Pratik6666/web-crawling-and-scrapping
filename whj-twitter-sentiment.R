## white hat Jr twitter analysis

## twitter data collection 
api_key <- '2XPwF9LPm0UcmnlOGK8bGUJMp'
api_secret <- 'nex8iTWDTymhWnnfEz3d06YEK1HCVzzhHzn0rCAtjSRKcA1kLK'
access_token <- "457209160-sa84TyS1ajYUWzSaZLh9vYTx0268AkYbiY4cdGsm"
access_secret <- "5yMBglBzJjXhbyL0mZ6bSgqKYm0JjY6MGcLD6NVIHK7jG"

## install relevant package
install.packages("twitteR")
library(twitteR)

setup_twitter_oauth(api_key, api_secret, access_token, access_secret)

## getting tweets and storing
tweet_data_whj <- searchTwitter('@whitehatjunior', n = 1000, lang = 'en')
tweet_data_whj <- twListToDF(tweet_data_whj)
whj_tweet_analysis <- data.frame(sentiment(tweet_data_whj$text))
summary(whj_tweet_analysis$sentiment)

## filter by favorited
whj_liked_tweet <- tweet_data_whj %>% 
  filter(favoriteCount == 164 ) 

## getting trends across location
trend_loc <- availableTrendLocations()
trend_loc %>% 
  filter(country == "United States")

trend_data_kol <- getTrends(23424977)

##usertimeline 
whj_self_data <- getUser('whitehatjunior')
whj_self_tweets <- (userTimeline(whj_self_data, n=2))


###############################################################################
## analysing the tweets for whitehatjr in details

install.packages("tm")
library(tm)

tweet_content <- iconv(tweet_data_whj$text)
tweet_content <- Corpus(VectorSource(tweet_content))
inspect(tweet_content[1:5])

tweet_data_whj[2,1]























