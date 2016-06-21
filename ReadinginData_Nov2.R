# 2.11.15
# STAT 5430 - reading-in data
# Author: Amber Tomas

# readLines() - reads in each line of a text file into an element of a character vector
# read.table() - used for reading-in a delimited data file
# read.csv() - wrapper to read.table(), with defaults suitable for reading-in csv files
# read.fwf() - reads in data in fixed-width columns from a file
# readHTMLTable() - read in tables from an html file - returns a list with one element for each table

 # create character vector containing file paths
 # good to put these near the top of your code
midafile <- "J:\\private\\Teaching\\STAT3430\\Datasets\\MIDA_4.01_small.csv"
hughesfile <- "J:\\private\\Teaching\\STAT3430\\Datasets\\hughes-l-d-g.txt"
hughes2file <- "J:\\private\\Teaching\\STAT3430\\Datasets\\hughes2.txt"


##########
# reading-in text to a character vector
##########

?readLines
# readLines()
# reads-in lines of a text file and returns a vector - the ith element contains the ith line of data

midalines <- readLines(midafile) # read-in data
  # take a look at the object created to make sure it's right
length(midalines) 
class(midalines)
midalines[1:5]


###########
# reading-in delimited data files
###########

?read.table()
# read.table() allows you to specify the delimiter (sep = ""),
#  whether the file contains variable names on the row before the values start (header = FALSE)
#  how many rows to ignore before the data starts (skip = 0)
#  how many rows of data to read (nrows = -1)
#  what the missing value character is (so they will be read-in as NA) (na.strings = "NA")
# and some other things

# read.csv() is a wrapper to read.table() with the options set to the defaults that are usually appropriate for csv files
#   header = TRUE
#   sep = ","

# always look at raw datafile first to check 
  # - if it has a header (variable names on the first row) - default = TRUE
  # - if it has missing values - can use na.strings = to make R convert all those values to NAs as the data is read-in
  # - what line of the file the data starts on - can use skip = to skip over the first x rows of the datafile

mida <- read.csv(midafile) 

# check that it was read-in correctly
names(mida)
mida[1:5,]
str(mida)

 # specify that -9 values should be interpreted as missing
mida <- read.csv(midafile, 
                 header = TRUE,
                 na.strings = "-9")

# count the number of missing values in each column of a dataframe
count.nas <- function(u){sum(is.na(u))} # function that takes a vector as input and returns the number of missing values
apply(mida, 2, count.nas) # applys the above function to each column of the dataframe

# example of skipping over the header and specifying own column names
mida <- read.csv(midafile,
                 na.strings = "-9", 
                 skip = 1, 
                 header = FALSE, 
                 col.names = letters[1:8])

head(mida)
tail(mida)


############
# reading-in column (fixed-width) files
############

?read.fwf
# read.fwf()
# used for reading-in data from a fixed-width file
# need to specify the width of each column
# can only read-in variable names directly if both of the following are met:
#   1. Names must be on the line immediately preceeding the data values
#   2. Names must be separated by a delimiter
# otherwise, use the col.names argument to specify the variable names


hughes <- read.fwf(hughesfile, 
                   skip = 23,  
                   widths = c(4, 5, 4, 5))
str(hughes)
head(hughes)

 # can use negative widths to skip over blank columns, but be careful not to accidently discard data!
 # specify column names
hughes <- read.fwf(hughesfile, 
                   skip = 23, 
                   col.names = letters[1:4],
                   widths = c(-1, 3, -1, 4, -2, 2, -1, 4))

head(hughes)

 # if file has column names as first row (a "header"), use sep = to specify the delimiter used for this row
hughes2 <- read.fwf(hughes2file, 
                    skip = 23,
                    header = TRUE, 
                    widths = c(4, 5, 4, 5), 
                    sep = ",")
head(hughes2)



###########
# reading data from html tables
###########

# if you haven't already downloaded the XML package, use install.packages("XML")
library(XML)
library(RCurl)

?readHTMLTable
# readHTMLTable()
# returns a list, one element for each table, each element is a dataframe

bschool.url <- getURL("https://en.wikipedia.org/wiki/List_of_United_States_graduate_business_school_rankings")
bschool.tables <- readHTMLTable(bschool.url)

str(bschool.tables)
bschool.ranks <- bschool.tables[[3]]

class(bschool.ranks)
head(bschool.ranks)

