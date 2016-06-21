#### HOMEWORK 9 ####

### Problem One ###
library(datasets)
library(car)
## 1.
# Read the data and manipulate the data
survey2010 <- read.csv("~/Dropbox/SAS/2010_Satisfaction_Survey.csv", na.strings="-9",as.is=TRUE)
survey2010[survey2010 == "N/A"] <- NA
survey2010[survey2010 == "999"] <- NA

## 2. 
## (a)
# Create a new variable called Age.R 
survey2010$Age.R <- ifelse(survey2010$Age == "R",1,0)
## (b)
# Replace all the values of Age equal to R with missing values. 
survey2010$Age[survey2010$Age == "R"] <- NA
## (c)
# Make sure Age is numeric.
survey2010$Age <- as.numeric(survey2010$Age)

## 3. 
## (a) 
# Create a new variable called Age.grp4 
survey2010$Age.grp4 <- recode(survey2010$Age, "lo:21 = 'Group 1'; 
                                          21:40 = 'Group 2';
                                          41:65 = 'Group 3';
                                          66:hi = 'Group 4'")
## (b)
table(survey2010$Age.grp4)
# Group 1 Group 2 Group 3 Group 4 
#     8      57     113      16 

## 4.
# Make a boxplot that shows how the response to overall satisfaction (Sat10) varies between respondents in the 4 age groups (there should be 4 boxes). 
boxplot(survey2010$Sat10~survey2010$Age.grp4,
        main = "The Response to Overall satisfaction varies between respondents in the 4 age groups",
        names = c("Group 1", "Group 2","Group 3","Group 4"),
        lab = 1)

## 5.
# There were four interviewers: Arthur, Alfred, Liz and Sam. 
table(survey2010$Interviewer)
survey2010$Interviewer[survey2010$Interviewer == "Alf"] <- c("Alfred") 
table(survey2010$Interviewer)

## 6.
## (a).
# Make a barplot with one bar for each of the questions 
surveydata <- survey2010[,10:18] 
for (i in 1:9){
  surveydata[,i] <- as.numeric(surveydata[,i])
}

mean.sta <- apply(surveydata,2,mean,na.rm = TRUE)
barplot(mean.sta,
		    main = "The Mean Response to Eeach of These Questions ",
		    ylab = "Mean",
		    xlab = "Questions")

## (b).
# Make a barplot with one bar for each of the questions for female and male
Sex <- survey2010$Sex
surveydata <- cbind(surveydata,Sex)
mean.stafm <- aggregate(surveydata[,1:9] ,list(surveydata$Sex),mean,na.rm = TRUE)
mean.stafm <- as.matrix(mean.stafm)
barplot(mean.stafm[,2:10],
		main = "The Mean Response for Male and Female",
		ylab = "Mean",
		xlab = "Questions",
		col = ifelse(mean.stafm[,1] == "F" ,"black", "grey"))

legend("topright", 
       legend = c("Female", "Male"),
       lty = c(1, 1),
       col = c("grey","black"))

### Problem Two ###
## 1.
# import and combine the data
Baseball_12112015_AL <- read.csv("~/Dropbox/SAS/Baseball_12112015_AL.csv")
Baseball_12112015_NL <- read.csv("~/Dropbox/SAS/Baseball_12112015_NL.csv")
baseball <- rbind(Baseball_12112015_AL, Baseball_12112015_NL)

# add the new variable League 
League <- rep(c("AL","NL"),each = 15)
baseball$League <- League
# Only keep the needed variables
baseball <- baseball[,c(1,4,11,13,14)]

## 2.
# Recode the values of DIV 
summary(baseball$League)
baseball$DIV <- recode(baseball$DIV,"'W' = 'West';'E'='East';'C' = 'Central'")

## 3.
## (a)
# Add an additional two columns to the baseball data that contain the number of road wins and the number of road losses.
baseball$ROAD <- as.character(baseball$ROAD)
road.win.loss <- matrix(as.numeric(unlist(strsplit(baseball$ROAD, "-"))),
                        byrow = TRUE,
                        ncol = 2,
                        dimnames = list(NULL, c("Road.wins", "Road.losses")))
baseball$Road.wins<- road.win.loss[,1]
baseball$Road.losses<- road.win.loss[,2]

## (b)
# Add an additional variable called Road.PCT that gives the winning percent of games played on the road for each team. 
baseball$Road.PCT <- baseball$Road.wins/(baseball$Road.wins+baseball$Road.losses)

## (c)
# Make a scatter plot of PCT against Road.PCT 
attach(baseball)
plot(PCT~Road.PCT,
     col = ifelse(League == "AL","red","blue"),
     main = "The Percentage of Road Win and Overall Win",
     xlab = "Road Win %",
     ylab = "Overall Win %"
     )
abline(a = 0,b = 1)

text(x = 0.51, y = 0.41, "road win % > overall win %")

legend("topright", 
       legend = c("AL", "NL"),
       lty = c(1, 1),
       col = c(2,1))


