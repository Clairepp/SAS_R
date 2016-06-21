# 30.10.15
# STAT 5430 - dataframes
# Author: Amber Tomas

# data.frame() - create a dataframe
# str() - look at the structure of an object
# order() - return the indexes of elements of a vector ordered from smallest to largest
# subset() - convenience function to extract columns/rows from a dataframe

####
# dataframes
####

# a dataframe is a list with the special property that the length of every object must be the same
# use data.frame() to make a dataframe from a set of objects

my.df <- data.frame(v1 = c(1,3,4), 
                    v2 = c("a", "b", "a"),
                    v3 = c(6.2, 5.1, 9.8))
class(my.df)
my.df
str(my.df)

# notice that v2 was automatically converted to a factor (since these are more efficient to store)
# if you don't want this to happen, use the option stringsAsFactors = FALSE

my.df <- data.frame(v1 = c(1,3,4), 
                    v2 = c("a", "b", "a"),
                    v3 = c(6.2, 5.1, 9.8),
                    stringsAsFactors = FALSE)
str(my.df)

# you can treat and index dataframes like a list

names(my.df)
length(my.df)

my.df$v1[c(1,3)]
my.df["v1"]
my.df[["v1"]]

sapply(my.df[c("v1", "v3")], sum)

# but also index them like a matrix

my.df[1, c(1,3)]
my.df[c(1,3), "v1"]
my.df[, c("v1", "v3")]
my.df[my.df$v3 > 6, "v1"]

dim(my.df)
nrow(my.df)
ncol(my.df)

# you can also convert a list or a matrix or vector to a dataframe

my.list <- list(v1 = c(1, 3, 4), 
                v2 = factor(c("a", "b", "a")))
as.data.frame(my.list)

my.mat <- matrix(1:10, ncol = 2)
df.mat <- as.data.frame(my.mat)
df.mat
names(df.mat) <- c("var1", "var2")
df.mat

as.data.frame(1:10)

##############
# adding and removing variables
###############

# you can use indexing as above to specify which rows and/or columns to keep
# like usual, you can use names, indices, or logical vectors to do this

# you can add additional variables using either the data.frame() function
# or directly:

data.frame(my.df, v4 = 1:-1)

my.df$v4 <- 1:-1
my.df

# another way to select only some rows and/or columns is to use the subset() function
?subset

subset(my.df, 
       select = c(v1, v3),
       subset = v4 >= 0)

# equivalent to
my.df[my.df$v4 >= 0, c("v1", "v3")]

# subset is particular handy for "dropping" variables
subset(my.df,
       select = -c(v1, v2),
       subset = v4 <= 0)

# equivalent to
my.df[my.df$v4 <= 0, setdiff(names(my.df), c("v1", "v2"))]

###############
# sorting dataframes
###############

# unfortunately there is no simple "sort" function
# to sort a dataframe by the values of a variable we have to use indexing

# first, understand what is happening when we sort a vector like this:
vec <- c(3, 1, 8, 5)
order(vec)
vec[order(vec)]
vec[order(vec, decreasing = TRUE)]

# note that order can take as input more than one argument -- it sorts on the first
#  argument, breaking ties based on subsequent arguments

# suppose we wanted to sort my.df based on the values of v2
order(my.df$v2)
my.df[order(my.df$v2), ]

# or in descending order of v1, breaking ties based on v3
my.df[order(my.df$v1, my.df$v3, decreasing = TRUE), ]


