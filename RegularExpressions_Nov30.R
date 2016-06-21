# 30.11.15
# STAT 5430
# more character manipulation
# specifying regular expressions


#######
# examples of regular expressions
#######

phone <- c("434-944-1234", "911", "(210) 338 5555", "899-222-8364", "08009992255", "no phone")
phone

# find which elements contain a 9
grep("9", phone)

# find which elements contain a sequence of at least 2 9s
grep("[9]{2,}", phone)
regexpr("[9]{2,}", phone)
     
# find which elements contain 10 consecutive digits
grep("[[:digit:]]{10}", phone)

# find which elements begin with a string of exactly 3 digits (and then punctuation)
grep("^[[:digit:]]{3}[[:punct:]]+", phone)

# which phone numbers contain letters?
grep("[A-Za-z]", phone)

# numbers containing hyphens, periods, or parentheses?
# use \\ in front of special characters . ^ $ + ? * ( ) [ ] { } | \
# inside a character class, only ^, -, \ and ] are special -- place hyphens first or last
grep("[-.()]", phone)
# remove hyphens, periods, parentheses
gsub("[-.()]", "", phone) # remove these characters (hyphens need to come first in a character class)
# remove all punctuation and spaces
gsub("[[:punct:] ]", "", phone)

contain.digit <- grepl("[[:digit:]]", phone)
phone[contain.digit] <- gsub("[[:punct:] ]", "", phone[contain.digit])
phone


######
# another example
########

files <- c("banana23.pdf", "plot.jpg", "familyphoto.jpeg", "lecture1.tex", "lecture2.tex", "lecture29.tex", "intro.pdf", "Homework1.tex", "homework1_soln.R", "homework1.pdf", "plot1.png", "plot999.png")
files

# jpeg files
# . modifier matches any single character
# ? modifier matches 0 or 1 occurences of previous entity
grep("jp.g", files, value = TRUE)
grep("jp.?g", files, value = TRUE)
grep("jpeg|jpg", files, value = TRUE) # equivalent

# everything that ends in .jpg or .jpeg
grep("\\.jpeg$|\\.jpg$", files)

# everything that starts with homework or Homework
grep("^[hH]omework", files)

# everything that contains "lecture" or "solution"
grep("lecture|soln", files)


##########
# using regular expressions
#########

addresses <- c('728 2nd St NE', 
               '2729 St Marten St', 
               'PO BOX 381', 
               '44 Main St')
addresses

# which addresses begin with a number?
 # keep expression to beginning of string
grep('^[0-9]', addresses, value = TRUE)

state.zip <- c('VA 22902', 'DC 20001, USA', 'VA 22202-2745')
state.zip

# extract zipcodes
# first find start location, then extract the substring of appropriate length
zip.location <- regexpr("([0-9]{5})|([0-9]{5}-[0-9]{4})", state.zip)
zip.location

zipcodes <- substring(state.zip, first = zip.location)
zipcodes

zip.length <- attr(zip.location, "match.length")
substr(state.zip, start = zip.location, stop = zip.location + zip.length - 1)



# remove comma and dollar sign, convert to numeric
house.prices <- c('$87,100', '$330,000', '$1,000,500')
house.prices

house.prices <- gsub("[$,]", "", house.prices)
house.prices
house.prices <- as.numeric(house.prices)
house.prices



#############
# Exercises
############

addresses <- c("537 Main St., Springfield, WY 38829",
               "Unit 1a, Percy Rd, Orange, VA 29901",
               "15/6 Summer Plaza, 15th St, Bandfield, VA 28841")

all.names <- c('Jan K. Miller', 
               'Ronnie P. McPherson', 
               'David J.D. Hill', 
               'Shuting Yoon')


