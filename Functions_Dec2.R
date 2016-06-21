# 2.12.15
# STAT 5430
# User-defined functions

# function() - create a function
# warning() - print a warning message
# stop() - print an error message and stop execution 

# if(condition) expression - only executes code in the expression if condition is TRUE


#######
# simple example
#######

my.function <- function(x, y = 8) {
	zz <<- x+y #global equation
  z <- x + y
  return(z)
}

my.function()
my.function(10)
my.function(10, 12)



# objects created inside the function are local, 
#   and hide any objects with the same name in the workspace (global environment)

z <- 20
x <- 10
my.function(x = 0)
z
x

########
# anonymous functions
########

# sometimes it is useful to pass a function directly to functions like lapply()
# for example,

library(MASS)
head(Cars93)

# sum logical variable could be 0 or 1

num.missing <- sapply(Cars93, function(u){sum(is.na(u))})

# the above is equivalent to
count.nas <- function(u) {
  sum(is.na(u))
}
num.missing <- sapply(Cars93, count.nas)

# if you want to use a complex function the second approach is usually better as it
#   is easier to debug
# for simple operations, anonymous functions are easy and efficient


########
# error checking
########

my.function(x = 10)
my.function(x = "cat")


# it's always a good idea to include error checks in your function
# these should go at the beginning of your function and check that all arguments are of the required class, length, etc.
# if the arguments are not appropriate, decide whether to modify the argument (with a warning) or just return an error

# warning() - prints a warning message but continues execution
warning("test")
# stop() - prints an error message and stops execution of the function
stop("test")

# conditional execution can be used to only execute some code if a condition is met.
#if(condition) expression
# if condition evaluates to TRUE, R evaluates expression. Otherwise it does not.


my.function <- function(x, y = 8) {
	if(!is.numeric(x)|!is.numeric(y)){
		stop("x and y arguments must be numeric")
	}
	if (length(x) != length(y)){
		warning("elements of shorter vector were recycled")
	}
  z <- x + y
  return(z)
}

########
# documentation
########

# Always use comments to accompany each function that give:
# A description of what the function does
# A description of every argument, including the class of object required and any default values
# A description of the value returned, including the class of the object, or (if a list is returned) a description of every object in the list.


# my.function: returns the elementwise sum of two numeric vectors. Recycles the shorter vector if necessary
# Inputs: x - a numeric vector
#         y - a numeric vector
# Value: a numeric vector containing the element-wise sums of x and y



#########
# returning more than one object
#########

# functions can only return one object, but that object can be a list of objects

my.function.3 <- function(x, y = 8) {
  z.sum <- x + y
  z.diff <- x - y
  z.mult <- x * y
  z.div <- x / y
  
  return(list(z.sum, z.diff, z.mult, z.div))
}

test <- my.function3(10, 5)
test$z.sum
test$z.div


########
# additional arguments ...
########

# additional arguments to the function can be passed to other functions within the function call
# if additional arguments are used in the function call, they will be passed along with ... to other functions.

# my.plot.fun: function to make a scatter plot or boxplot of two vectors
# Inputs: x -numeric vector
#         y - numeric vector
#         plot.type - one of "box" or "scatter"
# Value: NULL. Produces a plot.

my.plot.fun <- function(x, y, plot.type = "box", ...) # allow additional arguments
{
  if(plot.type == "box") {
    boxplot(x, y,
            notch = TRUE,
            col = "grey",
            ...)
  } else {
    plot(x, y, pch = 19, ...)
  }
}

my.plot.fun(rnorm(1000), rnorm(20))

my.plot.fun(rnorm(1000), rnorm(20), 
            names = c("samp size 1000", "samp size 20"),
            main = "Samples from a N(0, 1) Distribution")

my.plot.fun(rnorm(1000), rnorm(20), plot.type = "scatter")
