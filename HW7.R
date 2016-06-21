# Homework Seven


### Problem One ###
## (a)
Bikeshare <- read.csv("~/Dropbox/SAS/2014-1st-quarter-small.csv")
str(Bikeshare)
# the data has 75000 observations of 9 variables, and all the colume are factor, except the class of end.terminal and start.terminal are integer.
## (b)
# Create two objects
Start.terminal <- Bikeshare$Start.terminal
End.terminal <- Bikeshare$End.terminal
## (c)
# Covert the two objects to factors 
Startt.factor<-factor(Start.terminal)
Endt.factor<-factor(End.terminal)
## (d)
levels(Startt.factor)
levels(Endt.factor)
identical(levels(Start.terminal),levels(End.terminal))
# they are different
## (e)
combined.levels <- c(levels(Startt.factor),levels(Endt.factor))
All.terminals <- unique(combined.levels)
Start.terminal <- factor(as.character(Start.terminal), levels = All.terminals)
End.terminal <- factor(as.character(End.terminal), levels = All.terminals)


### Problem Two ###
## 1. 
load("HW7.RData")
## 2.
dim(engelv)
# 1703 6
## 3. 
# Print the first 10 rows of this dataframe 
engelv[1:10,]
## 4.
str(engelv)
# it is not appropriate, because the variable of stratum has no meaning for calculating, we should not use the class integer.
## 5.
# Convert the stratum variable to be a factor 
stratum.factor <-factor(engelv$stratum)
nlevels(stratum.factor)
# There are 18 levels
## 6.
length(stratum.factor[stratum.factor == 11])
# There are 129 observations for stratum 11.
## 7.
# The percentage for all votes returned from stratum 11 that are YES votes 
engelv11 <- engelv[engelv$stratum == 11,]
sum(engelv11$YES)/(sum(engelv11$NO)+sum(engelv11$YES)+sum(engelv11$BLANK))
# The percentage of YES is 33.73%.


### Problem Three ###
## 1.
yob <- read.csv("~/Dropbox/SAS/yob2013.txt",header = FALSE)
names(yob) <- c("name","sex","freq")
## 2.
str(yob)
# The first two variables should be the factor class, and the third one should be integer class.
## 3.
# Sort the dataframe by the name frequency 
yob.order <- yob[order(yob$freq, decreasing = TRUE), ]
yob.order[1:10, ]
## 4.
boy.name <- yob.order$name[which(yob.order$sex == "M")]
boy.name[1]
# The most popular boys' name is Noah
girl.name <- yob.order$name[which(yob.order$sex == "F")]
girl.name[1]
# The most popular girls' name is Sophia
## 5.
yob[yob$name == "Lillian" ,]
# 7017
yob[yob$name == "Millicent" ,]
# 97
# 7114 girls were named Lillian or Millicent 
## 6. 
GirlNames <- yob.order[yob.order$sex == "F",]
BoyNames <- yob.order[yob.order$sex == "M",]		
## 7. 
n0 <- nrow(yob)
n1 <- nrow(GirlNames) + nrow(BoyNames)
isTRUE(n0 == n1)
# TRUE
## 8.
name.intersect <- intersect(GirlNames$name, BoyNames$name)
length(name.intersect)
# 2414 of the listed boys names were also listed as a girls name 
## 9. 
name <- as.factor(yob.order$name[1:20])
name <- data.frame(name)
GirlNames$sex <- NULL
BoyNames$sex <- NULL
a <- merge(name,GirlNames)
b <- merge(name,BoyNames)
names(a) <- c("name","girlfreq")
names(b) <- c("name","boyfreq")
top20 <- merge(a,b)
## 10.
x <- top20$girlfreq < top20$boyfreq
x[x == T] <- "M"
x[x == F] <- "F"
top20$majority.sex <- x

### Problem Four ###
crime <- read.csv("~/Dropbox/SAS/LocalCrimeJurisbyJuris.csv", 
                    skip = 5,
                    header = TRUE,
                    na.strings = "-9",
                    nrow = 28)
