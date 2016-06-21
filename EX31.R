###############
#### EX.31 ####
###############

### CHEN PENG ###

## 1.
library(datasets)
class(Seatbelts)
# "mts" "ts" 
seatbelts <- as.data.frame(Seatbelts)  #convert to a dataframe
str(seatbelts)

## 2.
library(car)
summary(seatbelts$kms)
# find the value for the four quarters
q1 <- 12680
q2 <- 14990
q3 <- 17200
# use the cut()
seatbelts$kms4 <- cut(seatbelts$kms,breaks = 4, labels=c("First Quartile","Second Quartile","Third Quartile","Fourth Quartile"))
# use the recode()
seatbelts$kms4 <-recode(seatbelts$kms, "lo:q1='First Quartile';q1:q2='Second Quartile';q2:q3='Third Quartile';q3:hi='Fourth Quartile';else='Other'")
# recode() is easire to use

## 3.
seatbelts$kms3<-recode(seatbelts$kms4,"c('First Quartile', 'Second Quartile') = 'The Half'")
table(seatbelts$kms3,seatbelts$kms4)
# check the result

## 4.
seatbelts$PetrolPrice2 <- ifelse(seatbelts$PetrolPrice< 0.1, 0 ,1)
# check the results
a <- seatbelts[which(seatbelts$PetrolPrice<0.1),]
b <- seatbelts[which(seatbelts$PetrolPrice>=0.1),]
a$PetrolPrice2
b$PetrolPrice2
