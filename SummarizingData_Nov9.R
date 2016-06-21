# 9.11.15
# STAT 5430
# summarizing data

# tapply() - apply a function to each group of values of a vector, where the groups are defined by factors
# aggregate() - same as tapply(), but returns a dataframe. Can be used to aggregate several columns at once.
# by() - apply a function to each group of rows of a dataframe, where the groups are defined by factors. Returns a list

# table() - calculate 1, 2 or n-way frequency tables.
# mapply() - use this to vectorize a function that only works with scalar arguments


library(datasets)
Seatbelts <- as.data.frame(Seatbelts)
Seatbelts[1:5,]
?Seatbelts

######
# aggregate()
######

# calculate mean number of drivers killed or injured, before and after law
grp.means <- aggregate(Seatbelts$drivers, 
                       by = list(Seatbelts$law), 
                       mean)
grp.means
class(grp.means)

names(grp.means) <- c("law", "mean.drivers")
grp.means

# check if kms driven is influential
  # first add another variable indicating if km driven is high or low
Seatbelts$km.grp <- factor(ifelse(Seatbelts$kms > 15000, "high", "low"))

  # now use both law and km.grp as grouping variables
grp.means2 <- aggregate(Seatbelts$drivers, 
                        by = list(Seatbelts$law, Seatbelts$km.grp), 
                        mean)
grp.means2

names(grp.means2) <- c("law", "km.grp", "mean.drivers")
grp.means2

# can also use a dataframe as the first argument - then aggregate works on each column
grp.means3 <- aggregate(Seatbelts[,c("drivers", "front", "rear")], 
                        by = list(Seatbelts$law, Seatbelts$km.grp), 
                        mean)
grp.means3

names(grp.means3) <- c("law", "km.grp", "mean.drivers", "mean.front", "mean.rear")
grp.means3


#############
# comparing aggregate(), tapply() and by()
#############

# aggregate(), tapply() and by() can all do the same thing, but return objects of different classes
# you need to use by() if the function you apply does not return a scalar, or the function you want to apply takes a non-vector argument

 # aggregate returns a data.frame
grp.means <- aggregate(Seatbelts$drivers, 
                       by = list(Seatbelts$law), 
                       mean)
grp.means
class(grp.means)

 # tapply returns an array or matrix
?tapply
tapp <- tapply(Seatbelts$drivers, list(Seatbelts$law), mean)
tapp
class(tapp) # array

tapp <- tapply(Seatbelts$drivers, 
               list(Seatbelts$law, Seatbelts$km.grp), 
               mean)
tapp
class(tapp) # matrix

 # by returns as object of class by
byval <- by(Seatbelts$drivers, list(Seatbelts$law), mean)
byval
class(byval) # by

byval.list <- as.list(byval)
byval.list
class(byval.list)
length(byval.list)

  # by can also be used with functions that return more than just a scalar
byval2 <- by(Seatbelts$drivers, list(Seatbelts$law), summary)
byval2
byval2.list <- as.list(byval2)
names(byval2.list) 

  # or with functions that take a dataframe as argument rather than a vector
byval3 <- by(Seatbelts[,c("drivers", "front", "rear")], list(Seatbelts$law), summary)
byval3
as.list(byval3)


# all of them can take more than one grouping factors

aggregate(Seatbelts$drivers, by = list(Seatbelts$law, Seatbelts$km.grp), mean)
tapply(Seatbelts$drivers, list(Seatbelts$law, Seatbelts$km.grp), mean)
by(Seatbelts$drivers, list(Seatbelts$law, Seatbelts$km.grp), mean)


# choose whichever function returns the object that is easiest for you to deal with!


########
# difference between aggregate and apply
########

# apply() will apply a function to every row or column of a matrix (or something that can be coerced to a matrix)
# aggregate applys a function to every variable in a dataframe, for each group of observations

# eg find the average number of passengers killed or injured per month, before and after the seatbelt law changed

# first, add a variable that has total number of passengers
Seatbelts$passengers <- apply(Seatbelts[, c("front", "rear")], 1, sum)
Seatbelts[1:5,]

# now, calculate the mean of passengers for observations grouped by law
pass.mean <- aggregate(Seatbelts$passengers, list(Seatbelts$law), mean)
names(pass.mean) <- c("law", "mean.passengers")


######
# table()
######

table(Seatbelts$law)
table(Seatbelts$law, Seatbelts$km.grp)

# check creation of km.grp
table(Seatbelts$kms, Seatbelts$km.grp)

by(Seatbelts$kms, list(Seatbelts$km.grp), summary)


#####
# fyi, mapply()
#######

# use mapply() if you want to call a function multiple times, using different arguments.
# mapply() allows the arguments to be given as vectors. On the ith function call it will use the ith element of the argument vector/s
# mapply() returns a list, but if possible it will simplify this to a matrix or a vector

# sample of size 10 from a N(11, 2) distribution
rnorm(10, mean = 11, sd = 2) 

# 3 samples of size 10, with different means and the same sd
rnorm(10, mean = c(5, 6, 7), sd = 2) 

 # need to use mapply()!
samp <- mapply(rnorm, mean = c(5, 6, 7), MoreArgs = list(n = 10, sd = 2)) 
samp
class(samp) # matrix

samp <- mapply(rnorm, n = c(10, 5, 10), mean = c(5, 6, 7), sd = c(2, 3, 2))
samp
class(samp) # list



