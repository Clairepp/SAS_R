# 11.11.15
# STAT 5430
# recoding 

# cut() - group a numeric variable into labeled intervals
# recode() - group values together into a factor
# ifelse() - conditionally replace elements of a vector with elements from another vector

 # use the infert dataset from the datasets package
library(datasets)
help(package = "datasets")
?infert

str(infert)
infert[1:5,]

######
# recoding values
######

# the simplest case of recoding is if we want to replace every x in a vector with a y, say
# e.g. replace 0s in case with "control"; replace 1s in case with "case"

infert2 <- infert # make a copy

# we already know how to do this with indexing:
infert2$case[infert$case == 0] <- "control"
infert2$case[infert$case == 1] <- "case"

infer2$case[infert$case == 999] <- NA 

# an alternative is to use the recode() function 
# it's in the car package
# similar to PROC FORMAT in SAS. 
# Specify "range = 'value'". 
# Can use : to specify a continuous range from one value to another

library(car)
infert2$case <- recode(infert$case, "0 = 'control'; 1 = 'case'")



# in general, using indexing is usually best if there are only one or two values you want to replace
# recode is good to use if there are several different values you want to recode, or of you want to group numeric values


####
# grouping numeric variables into factors
####

# group numeric age into a factor with 3 age groups
summary(infert$age)

# cut()
# "cuts" the number line at the breaks to create groups
# must specify all the interval endpoints, not just the central ones

summary(infert$age.grp)

infert2$age.grp <- cut(infert$age, breaks = c(20, 30, 40, 50))
table(infert2$age.grp)
class(infert2$age.grp)

infert2$age.grp <- cut(infert$age, breaks = c(20, 30, 40, 50), 
                      labels = c("21-30", "31-40", "41-50"))
table(infert2$age.grp)

by(infert$age, list(infert2$age.grp), summary) # check



# recode()
# use a colon to specify numeric ranges
infert2$age.grp2 <- recode(infert$age, "21:30 = '21-30'; 
                                      31:40 = '31-40'; 
                                      41:50 = '41-50'")

class(infert2$age.grp2)
table(infert2$age.grp2)
table(infert$age.grp, infert2$age.grp2)

 # can also use the special values lo, hi, else to specify ranges
infert2$age.grp2 <- recode(infert$age, "lo:30 = '21-30'; 
                                    31:40 = '31-40'; 
                                    41:hi = '41-50'; 
                                    else = 'other'")


#####
# grouping levels of a factor
#####

levels(infert$education)
table(infert$education)

# group first two levels into one: 0-11yrs
# use recode()

infert2$ed2 <- recode(infert$education, "'0-5yrs' = '0-11yrs'; 
                                      '6-11yrs' = '0-11yrs'")
levels(infert2$ed2)
table(infert2$ed2, infert$education)

infert2$ed2 <- recode(infert$education, "c('0-5yrs', '6-11yrs') = '0-11yrs'")

# change levels directly
# use levels() to access the levels of a factor, then assign the levels new values
# if two levels have the same value, they will be grouped into one level

infert2$ed3 <- infert$education
levels(infert2$ed3)
levels(infert2$ed3)[1:2] <- "0-11yrs" # assumes that the variables are in a given order
levels(infert2$ed3)
table(infert2$ed3, infert$education)

levels(infert2$ed3)[levels(infert$ed3) %in% c("0-5yrs", "6-11yrs")] <- "0-11yrs" # uses column names rather than position - less likely to cause mistakes, and easier to understand!



#####
# conditionally assign one of two values to elements of a vector
######

?ifelse

# replace ages less than 40 with 1, ages greater than 40 with 0
age.lt40 <- ifelse(infert$age < 40, 1, 0) 
by(infert$age, list(age.lt40), summary)

 # equivalent (more efficient, less elegant)
age.lt40 <- infert$age
age.lt40[infert$age < 40] <- 1
age.lt40[(!infert$age < 40)] <- 0

# replace ages greater than or equal to 40 with "40+". Don't change other elements 
age.40 <- ifelse(infert$age >= 40, "40+", infert$age) 
table(age.40)

 # equivalent (more efficient)
age.40 <- infert$age
age.40[age.40 >= 40] <- "40+" 



# what happens with ifelse if there are NA values??






#####
# conditional execution
#####

if(!is.factor(infert$stratum)){
  infert$stratum <- as.factor(infert$stratum)
} else cat("stratum is a factor")



if(!is.factor(infert$stratum)){
  warning("Converting stratum to factor")
  infert$stratum <- as.factor(infert$stratum)
} else cat("stratum is a factor")

if(!is.null(X)){
   y <- length(X)
} else{
  y <- NA
}


