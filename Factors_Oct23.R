# 23.10.15
# STAT 5430
# factors


# factor() - create a factor
# levels() - access the levels of a factor
# nlevels() - count the number of levels

# table() - frequency table of a factor
# cut() - create a factor by grouping values of a numeric vector 


library(stringr) 
# If that didn't work 


AFL <- read.csv("J:\\private\\Teaching\\STAT3430\\Datasets\\AFLData02_08.csv",
                header = TRUE)

AFL[1:10,]
str(AFL)

Home <- AFL$Home # create a factor from the column of AFL called Home
Away <- AFL$Away

# look at first 10 elements
Home[1:10] 

# look at elements where Away team was St K
Away[Away == "St K "]

# look at Away teams where Home team was Adel or West C
Away[Home %in% c("Adel ", "West C ")]


############
# levels and labels
############


# how many levels does the factor have?
nlevels(Home) 
nlevels(Away)

# what are the levels (labels)?
levels(Home) 
levels(Away)

# the values of a factor are stored internally as numbers:
# 1 corresponds to the first level, 2 to the second level, and so on
# every level has a "label", which is what you usually see when looking at 
#   the factor, and what is used for specifying logical conditions


# convert a factor to character - get labels
# look at first 10 elements
as.character(Home[1:10]) 

# convert a factor to numeric - get level codes
# look at first 10 values
as.numeric(Home[1:10]) 

### WARNING!!!! ####
trick.factor <- factor(c(2000, 2001, 2002, 2003, 2000, 2001, 2000))
trick.factor
as.numeric(trick.factor)


##########
# specifying the levels
##########

resp <- c("dog", "cat", "cat", "dog") # character vector

# when you make a factor the default set of levels is all the distinct values, in alphabetical order
resp.fac <- factor(resp) 
resp.fac

# if you want to use some other set of levels, 
#  specify it using the levels= option to factor()
resp.fac <- factor(resp, levels = c("cat", "dog", "pig")) 
resp.fac

# careful if you want to extend the factor
resp.fac <- c(resp.fac, "pig")
resp.fac <- factor(c(as.character(resp.fac), "pig"))
resp.fac

############
# changing the levels
###########

# reassign levels
levels(Home) 
levels(Away)

levels(Home) <- str_trim(levels(Home)) # assign to levels a character vector returned from str_trim - original levels but with blank space trimmed. Groups values with the same levels together.
levels(Away) <- str_trim(levels(Away))

# Example of grouping by changing levels
tf <- factor(letters[1:5])
tf
levels(tf)[1] <- "b"
tf

# the above is different (and preferred) to
tf <- factor(letters[1:5])
tf[tf == "a"] <- "b"
tf


# since the same set of teams is playing at Home as Away,
#  we should make sure Home has the same levels as Away

levels(Home)
levels(Away)
levels(Home) <- levels(Away) # this is not correct!

# here's why:
tf1 <- factor(c("a","b","b","c"), levels = c("c", "b", "a"))
tf1

tf2 <- factor(c("a","a","b","c"), levels = c("a", "b", "c"))
tf2

levels(tf1) <- levels(tf2)
tf1

# this is how to do it -- 
#  make a new factor and specify the levels you want
Home <- factor(as.character(Home), levels = levels(Away))

# Note: the reorder() function can be used to re-order levels, 
#  but this is not appropriate if you want to make a lot of changes to the order

##############
# creating a factor with the cut() function
##############

# Attendance at games 
Attend <- AFL$Attend

# group attendance into 4 groups of around the same size:
#  low, small, medium, large

# first need to find the "break-points" i.e. where we want to cut
#  the number line to define our groups
# Need to include upper and lower end-points too
# If we want 4 groups we will have 5 cuts

summary(Attend) # returns a vector containing summary statistics
Attend.breaks <- summary(Attend)[c('1st Qu.', 'Median', '3rd Qu.')] # elements of summary called 1st Qu. etc.

Attend.fac <- cut(Attend, breaks = c(0, Attend.breaks, 150000), 
                  labels = c("low", "small", "medium", "large"))
table(Attend.fac) # create frequency table to check

Attend[1:20] # first 20 elements of Attend
Attend.fac[1:20] # first 20 elements of Attend.fac

table(AFL$Venue, Attend.fac) # create 2 by 2 freq table
plot(Attend.fac) # default plot for factors

plot(Home)
