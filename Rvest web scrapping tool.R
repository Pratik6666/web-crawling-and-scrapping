### learning rvest

install.packages("rvest")
library(xml2)
install.packages("xml12")
library(rvest)

## 

reddit_webpg <- read_html("https://www.reddit.com/r/politics/comments/a1j9xs/partisan_election_officials_are_inherently_unfair/")
reddit_webpg %>% 
  html_node("title") %>% 
  html_text()

reddit_webpg %>% 
  html_nodes("p._1qeIAgB0cPwnLhDF9XSiJM") %>% 
  html_text()

## reading the data from reddit politics - collecting leading headlines along with time
reddit_politics_new_webpg <- read_html("https://www.reddit.com/r/politics/new/")

time <- data.frame (reddit_politics_new_webpg %>% 
  html_nodes("a._3jOxDPIQ0KaOWpzvSQo-1s") %>% 
  html_text())
url <- reddit_politics_new_webpg %>% 
  html_nodes("a._3jOxDPIQ0KaOWpzvSQo-1s") %>% 
  html_attr("href")

time_tag <- data.frame(time, url)
names(time_tag) <- c("Time", "URL")

##creating a 2 dimensional table to store the comments by mapping it to headline ###
titles <- c()
comments <- c()

for (i in 1:dim(time_tag)[1]) {
   
  comment <- read_html(time_tag$URL[i]) %>% 
    html_nodes("p._1qeIAgB0cPwnLhDF9XSiJM") %>% 
    html_text()
  comments <- append(comments, comment)
  
  
  title <- read_html(time_tag$URL[i]) %>% 
    html_node("title") %>% 
    html_text()
   titles <- append(titles, rep(title, length(comment)))
   
  remove(comment, title)  
}

reddit_data <- data.frame(Headline = titles, Comments = comments)


##################################removing disclaimer comments ############################
disclaimer <- c("As a reminder, this subreddit is for civil discussion.", 
"In general, be courteous to others. Debate/discuss/argue the merits of ideas, don't attack people. Personal insults, shill or troll accusations, hate speech, any advocating or wishing death/physical harm, and other rule violations can result in a permanent ban.",
"If you see comments in violation of our rules, please report them.", 
"For those who have questions regarding any media outlets being posted on this subreddit, please click here to review our details as to our approved domains list and outlet criteria.", "I am a bot, and this action was performed automatically. Please contact the moderators of this subreddit if you have any questions or concerns.")

for (i in 1:dim(reddit_data)[1]){
  for (j in 1:length(disclaimer)){
     ifelse (reddit_data[i,2] == disclaimer[j], (reddit_data <- reddit_data[-i,]), NA)
  }
}

## using subset function
reddit_data <- subset(reddit_data, !(Comments %in% c(disclaimer)))

############################# sentiment r using keyword #####################

install.packages("sentimentr")
library(sentimentr)

sentiment_data <- sentiment(reddit_data$Comments)
emotion_data <- emotion(reddit_data$Comments)
summary(sentiment_data)
###############################rough work##############################
reddit <- reddit_data
reddit[,2]
remove(reddit)
write.csv(reddit_data, file = "Reddit_Politics.csv", sep = ",")
