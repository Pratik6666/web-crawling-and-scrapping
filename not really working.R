# //*[@id="mainContent"]/div[1]/ol/li[2]/dl/dd[3]/span

install.packages("data.table")
install.packages("XML")
library(data.table)

pages <- c(1:3)
urls <- rbindlist(lapply(pages, function(x){
  url <- paste("https://www.r-users.com/jobs/page/",x,"/", sep = "")
  data.frame(url)
}), fill = T)

url_fun <- function(x){
  url <- paste("https://www.r-users.com/jobs/page/",x,"/", sep = "")
}
## preparing list of urls based on the number of pages. using a data frame to store
url_list <- data.frame(url_fun(pages))
## funtion to store locations
jobloc_fun <- function(url.list, num.of.pages) {
  doc1 <- htmlParse(url.list[1,num.of.pages])
  locations <- getNodeSet(doc1, '//*[@id="mainContent"]/div[2]/ol/li/dl/dd[3]/span')
}
## preparing list of locations based on the number of pages. using a data frame to store
url_list[2,]
test_html <- htmlParse(url_list[2,])
getNodeSet(test_html, '//*[@id="mainContent"]/div[2]/ol/li/dl/dd[3]/span')
