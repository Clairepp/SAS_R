# 10.21.15
# STAT 5430
# Vectors

# c() - concatenate numbers or vectors to make a vector
# seq() - creates a regular sequence
# rep() - create a vector by repeating a vector or each element of a vector a number of times.

# as.numeric() - convert to a numeric vector
# as.character() - convert to character vector

# class() - returns the class of the vector
# length() - returns the number of elements in a vector
# names() - returns the names of the vector elements. Can also be used to assign or change names.

# sum(), max(), min(), median(), etc
# table() - create a frequency table

# which() - returns the indexes of the elements of a vector that meet a condition
# is.na() - returns a logical vector, TRUE if a value is NA and false otherwise

# unique() - return a vector of the unique values
# intersect() - returns the "intersection" of the elements of two vectors
# union() - returns the "union" of the elements of two vectors
# setdiff() - returns the elements of the first vector not in the second

#########
# create a vector
##########

# all elements in a vector should be of the same type, 
# i.e. you can't mix numeric and character

# use c() to concatenate vectors

ages1 <- c(19, 25, 19) # numeric
ages2 <- c(20, 21)
ages <- c(ages1, ages2)

id <- c("A1007", "B7739", "B2821", "A8823", "A0501") # character

drink <- c(FALSE, TRUE, FALSE, FALSE, TRUE) # logical

# use seq() to create a regular sequence

?seq

1:10 
seq(from = 1, to = 10, by = 1)

5:-5
seq(from = 5, to = -5, by = -1)

seq(from = 0, to = 100, by = 3.5)

# use rep() to create a longer vector by repeating elements of a shorter vector
# the each = argument says how many times to repeat each element of the shorter vector before going to the next value
# the times = argument says how many times to repeat the entire shorter vector

?rep

rep(1:3, each = 2)  
# 每个重复两遍
rep(1:3, times = 2)
# 整个重复两遍
#############
# convert the type of a vector
#############

# use the as.xxxx() functions to convert from some mode to mode xxxxx

as.character(ages) # numeric to character
as.character(drink) # logical to character
as.numeric(drink) # logical to numeric
as.numeric(id) # character to numeric

id_num <- gsub("[A-Z]", "", id) # replace all uppercase letters with a blank string ""
id_num
as.numeric(id_num) # now can convert to numeric, since only contains digits

###########
# vector attributes
############

# vectors have a class, a mode, a length, and names

length(ages) # returns the number of elements in a vector
names(ages) # currently has no names

names(ages) <- id # assign the values of id to the names of the vector ages
ages

############
# statistics and arithmetic
############

# the +, -, *, / operators operate element-wise on vectors of the same length
# if one vector is shorter than the other its elements are repeated until its the same length

help("+")

c(1,2) + c(4,5)
c(1,2) - c(4,5)
c(1,2) * c(4,5)
c(1,2) / c(4,5)
c(1,2) ^ c(4,5)
c(12,7) %% c(10,4) # modulo part
c(12,7) %/% c(10,4) # integer division

c(1,2) + c(1,2,3) # equivalent to c(1,2,1) + c(1,2,3)
c(1,2) ^ 2 # equivalent to c(1,2) ^ c(2,2)


# summary statistics
# just some examples:

mean(ages)
sd(ages)
summary(ages)
max(ages)
min(ages)
sum(ages)

# take care!!
# the above functions will return a missing value if any elements of the vector are missing
# all missing values in R are denoted NA

vec <- c(1:3, 8, NA, 2, NA, NA, 51)
vec
is.na(vec) # use this to find which elements are missing
sum(is.na(vec)) # count the number of missing values

mean(vec)
mean(vec, na.rm = TRUE) # mean of the non-missing values
sd(vec, na.rm = TRUE) # sd of non-missing values
sum(vec, na.rm = TRUE) # sum of non-missing values


# frequency table

table(drink) 

drink.tab <- table(drink)
class(drink.tab)
names(drink.tab)
as.numeric(drink.tab)

# can also make 2-way frequency tables

table(drink, ages)

#############
# indexing and filtering vectors 
#############

help("[")

# the elements of a vector are numbered from 1 to the length of the vector
# if you want to extract or keep only some elements of a vector, put the indices of 
#   the elements you want to keep within square brackets after the vector name
# if you preceed these indices with a minus sign, those elements are removed

ages <- c(19, 25, 19, 20, 21) 
id <- c("A1007", "B7739", "B2821", "A8823", "A0501") 
drink <- c(FALSE, TRUE, FALSE, FALSE, TRUE) 

ages[1] # first element
ages[length(ages)] # last element
id[1:3] 
drink[c(1,2,4)] 
ages[-c(1,2,4)] 
drink[seq(2, length(drink), by = 2)] 

# if a vector has names, you can access elements based on their names

ages[c("B2821", "A0501")]

# A very useful way to index vectors is to use logical indexing
# the syntax is vec[logical.vec], where logical.vec is a logical vector the same length as vec
# this returns all the elements of vec for which logical.vec is TRUE

ages[c(TRUE, FALSE, FALSE, FALSE, TRUE)]
ages[drink]

# the power of logical indexing comes because it allows you to select elements of a
#  vector that meet some condition

ages >= 21
ages[ages >= 21] # only keep elements of ages greater than or equal to 21
id[ages < 21] # ids of people aged under 21

# other relational operators are <=, >, <, ==, !=
help("<")

random.numbers <- runif(100) # generate 100 random numbers from a U(0,1) distribution
random.numbers.90 <- random.numbers[random.numbers > 0.9]
random.numbers.90
length(random.numbers[random.numbers < 0.1]) # how many elements are less than 0.1?

# also, %in%
ages %in% c(20, 21)
ages[ages %in% c(20, 21)] # return elements of ages in the set {20, 21}

# if you want to know *which* elements satisfy a condition, i.e. the index of the
#  elements that satisfy a condition, use which()

which(ages >= 21) # elements 2 and 5 are >= 21
which(drink == FALSE) # elements 1, 3, and 4 are FALSE
which(id %in% c("B7739", "C1999"))

#############
# set operations
#############

# you can also treat two vectors like two sets of elements, and perform set operations

vec1 <- 1:5
vec2 <- c(4,1, -7, 21)

intersect(vec1, vec2)
union(vec1, vec2)
setdiff(vec1, vec2)
setdiff(vec2, vec1)

# return the unique values
unique(ages)

# logical indicator of which elements are duplicated
duplicated(ages)

ages[!duplicated(ages)] # same as unique(ages)


