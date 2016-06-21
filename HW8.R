# Homework Eight

### Problem One
## 1.
library(XML)
library(RCurl)
rank1.url <- getURL("http://www.webometrics.info/en/Americas/USA1")
rank1 <- readHTMLTable(rank1.url) 
rank1 <- data.frame(rank1)
rank2.url <- getURL("http://www.shanghairanking.com/World-University-Rankings-2015/USA.html")
rank2 <- readHTMLTable(rank2.url)
rank2 <- data.frame(rank2)

## 2.
rank.url <- getURL("https://en.wikipedia.org/wiki/Forbes_Magazine%27s_List_of_America%27s_Best_Colleges")
rank <- readHTMLTable(rank.url)
rank2015 <- data.frame(rank[3])

## 3. 
## (1).
rank1.name <- rank1$NULL.University 
rank2.name <- rank2$UniversityRanking.Institution
rank.name <- rank2015$NULL.Name 
name1 <- intersect(rank1.name,rank2.name)
namethree <- intersect(name1,rank.name)
# the colleges in the three datasets

## (2)
nameforbes <- setdiff(rank.name,name1)
# the colleges only in the forbes dataset

## 4.
names(rank1) <- c("countryrank1","worldrank1","collegename")
names(rank2) <- c("countryrank2","collegename","worldrank2")
names(rank2015) <- c("rankforbes","collegename")
rank.us1 <- rank1[,c(1,3)]
rank.us2 <- rank2[,1:2]
# only keep the useful variables
temp <- merge(rank2015,rank.us1,all.x=TRUE)
rank.all <- merge(temp,rank.us2,all.x = TRUE)
# merge the data

## 5.
rank.all$rankforbes<- as.numeric(rank.all$rankforbes)
rank.all$countryrank1<- as.numeric(rank.all$countryrank1)
rank.all$countryrank2<- as.numeric(rank.all$countryrank2)
# convert the factor class to numeric class
maxrank <- apply(rank.all[,2:4],1,max)
rank.all$maxrank <-maxrank 
# get the maximum rank among the three ranks
rank.all <- rank.all[order(rank.all$maxrank),]
# order the maximum ranks

### Problem Two
## 1.
Economic_raw <- read.csv("~/Dropbox/SAS/us_foreign_assistance.csv",
							skip = 6,
                    		header = TRUE)
# read the data
                    		
## 2.
 na.to.zero <- function(u){
     u[is.na(u)] <- 0
     return(u)
  }
  # test
  vec <- c(4, 6, NA, 2)
  na.to.zero(vec)

Economic_raw <- lapply(Economic_raw, na.to.zero)

## 3.
## a.
Economic_raw <- as.data.frame(Economic_raw)
str(Economic_raw)
total <- apply(Economic_raw[3:69],1,sum)
Economic_raw$total <- total
Economic <- Economic_raw[,c(1,2,70)]
# get the total amount and the keep the useful variables

## b.
program.amount <- aggregate(Economic[3],list(Economic$Program.Name),sum)
# get the total amount for each program

## c.
total.order <- program.amount[order(program.amount$total, decreasing = TRUE),]
# order the total amount

## 4.
## a.
country.amount <- aggregate(Economic_raw[3:69],list(Economic$Country.Name),sum)
# get the amount for each country in every year

## b.
amount5160 <- apply(country.amount[,7:16],1,sum)
amount6170 <- apply(country.amount[,17:26],1,sum)
amount7180 <- apply(country.amount[,27:36],1,sum)
amount8190 <- apply(country.amount[,37:46],1,sum)
amount9100 <- apply(country.amount[,47:56],1,sum)
# get the total amount in each decade
country.amount1 <- cbind(country.amount,amount5160,amount6170,amount7180,amount8190,amount9100)

## c.
country.amounttotal <- country.amount1[,c(1,69,70,71,72,73)]
# keep the six columes




