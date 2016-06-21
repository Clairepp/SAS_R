# 23.11.15
# STAT 5430
# character manipulation

# strsplit() - split a string into components based on the location of a character used for splitting
# unlist() - convert a list to a vector if possible
# paste() - paste together the values in a) a vector b) two vectors, element-by-element
# substr() - returns a substring, given start and end positions
# substring() - returns a substring, given start position

# sub() - substitute one string for the first instance of another
# gsub() - substitute one string for every instance of another
# grep() - returns the indices of the elements of a vector that contain a string
# grepl() - returns a logical vector indicating which elements of a vetor contain a string
# regexpr() - returns the location of the first match of a string in each element of a vector
# gregexpr() - returns the location of all matches of a string in each element of a vector

# str_trim() - remove leading and trailing blanks. In the stringr package
# proc.time() - returns system time

##########
# substitutions
##########

phone <- c("193-444-3821", "434-964-1234")
phone

?sub
sub("-", "", phone) # substitute the first instance (in each element) of "-" with ""
gsub("-", "", phone) # substitute all instances of "-" with ""

#############
# split a string into parts
#############

# strsplit()
# strsplit() returns a list. This can be an awkward object to manipulate, and strsplit() is also very resource-intensive.
# Sometimes you have to use this function, but otherwise try not to!

phone.parts <- strsplit(phone, "-")
phone.parts # returns a list
 
 # how to make the list into an object that is easier to deal with?
 # if every element of the list is the same length, then convert to a dataframe or matrix:
as.data.frame(phone.parts)
unlist(phone.parts)
matrix(unlist(phone.parts), ncol = 3, byrow = TRUE)

###########
# pasting elements together
###########

p1 <- phone.parts[[1]]
p2 <- phone.parts[[2]]
p1
p2

paste(p1, p2) # element-by-element 
paste(p1, p2, sep = "...")

paste(p1, collapse = "") # paste together elements of p1
paste(p1, collapse = "-")

# paste the 3 components back together, without anything between them
phone.parts
phone.paste <- lapply(phone.parts, paste, collapse = "") 
phone.paste
unlist(phone.paste)


# compare time required for sprsplit()+paste() and gsub() to do the same thing

pt <- proc.time()
for(i in 1:10000){
 gsub("-", "", phone)
}
print(proc.time() - pt)

pt <- proc.time()
for(i in 1:10000){
  phone.parts <- strsplit(phone, "-")
  phone.paste <- lapply(phone.parts, paste, collapse = "")
  unlist(phone.paste)
}
print(proc.time() - pt)

###########
# extracting substrings
###########

# extract names and email addresses from a webpage

tutor <- readLines("J:\\private\\Teaching\\STAT3430\\Datasets\\tutor.html")
tutor <- tutor[146:154]
tutor

# how long is each string?

nchar(tutor) # number of characters in each element of the character vector

# find location of characters in the string

grep("@", tutor) # which elements contain an @
grepl("@", tutor) # does (T or F) each element contain an @
grep("W", tutor)
grepl("W", tutor)

 # find location of first >
ts <- regexpr(">", tutor)
ts
 
 # find location of second <
regexpr("<", tutor)
gregexpr("<", tutor)

 # make output of gregexpr() easier to deal with
tl <- unlist(gregexpr("<", tutor))
tl
tl <- tl[seq(2, length(tl), by = 2)] # every second element of tl
tl
 
# extract the substring between the first > and the second <

ss <- substr(tutor, start = ts+1, stop = tl-1)
ss

# note: substr() takes a start position and a stop position and returns the substring between these locations
# substring() takes a start position and will return every character from there to the end
at <- regexpr("@", ss)
substring(ss, first = at)
substr(ss, start = at, stop = nchar(ss))

