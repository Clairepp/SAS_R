# 27.10.15
# STAT 5430 - lists
# Author: Amber Tomas

# list() - create a list
# lapply() - apply a function to every element of a list - return a list
# sapply() - apply a function to every element of a list - return a vector where possible


###########
# creating a list
###########

# lists can be used to store any number of objects
# each element of a list contains an object
# the objects stored in a list don't have to be of the same class

vec1 <- 1:10
mat <- diag(rep(5, 4))
vec2 <- c("Bears", "Gorillas")

# create a list with 3 objects

mylist <- list(vec1, mat, vec2)
mylist
names(mylist) # NULL

# create a list with 3 named objects

mylist <- list(first = vec1, second = mat, third = vec2)
mylist
names(mylist)

# create an empty list

myemptylist <- vector("list", length = 2)
myemptylist

# list attributes

names(mylist)
length(mylist)

#############
# indexing lists
#############

# the object in the ith element of the list is returned using [[i]] syntax
# a list that contains the ith element of the list is returned using [i] syntax

mylist[[2]]
class(mylist[[2]])

mylist[2]
class(mylist[2])

mylist[c(2,1)]

# you can also use names to refer to elements of the list

names(mylist)
mylist[["second"]]
mylist["second"]
mylist[c("second", "first")]

 # or alternatively if you want to return the object in one element of the list

mylist$second
mylist$third

# and you can use logical vectors too

mylist[c(TRUE, TRUE, FALSE)]

# to remove an element from the list, set it to NULL

mylist["third"] <- NULL
mylist

 # note that this is *not* the same as
mylist[["third"]] <- NULL

# you can assign objects to particular elements in the list

myemptylist[[1]] <- vec2
myemptylist

# and replace several elements with a new list of the same length

myemptylist[c(1,2)] <- list(vec1, vec2)
myemptylist

###########
# converting a list to a vector
###########

# sometimes you might have a list where every element is a vector of the
#  same class and length, and you want to combine them into a matrix or vector

# use the unlist() function

mylist2 <- list(v1 = 1:5, v2 = 3:7, v3 = seq(from = 10, to = 12, length = 5))
mylist2

unlist(mylist2)
matrix(unlist(mylist2), ncol = 3)

#############
# applying a function to several elements of a list
#############

# if you want to "do the same thing" to several elements of the list, 
#  use lapply() to "apply" a function to every element of a list

# calculate the mean of every element of mylist2

lapply(mylist2, mean)

# in this case we might have preferred the results in vector form
# rather than use unlist() we can use sapply() instead

sapply(mylist2, mean)

# but sometimes we need the results as a list

summary.list <- lapply(mylist2[1:2], summary)
summary.list

