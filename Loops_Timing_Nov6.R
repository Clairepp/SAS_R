# 5.11.15
# STAT 5430
# for loops and timing code

# Rprof()
# system.time()
# proc.time()

############
# for loops
############

# perhaps from using SAS or another language such as C, Fortran, or Python, you think
#  of operations element by element. That is, let's loop through every element in this vector /
#  row in this dataframe and do something to it.
# R is programmed in such a way as to make this generally very inefficient
# You are much better off using Rs vectorized functions instead.

# For this class you will most likely never have to use a for loop

# Basic idea
# Suppose we have two vectors and we want to add then together element-by-element

v1 <- rnorm(10)
v2 <- rnorm(10)

# In R this is the usual way vectorized arithmetic works

result <- v1 + v2

# However, we could have done it by looping through each element of the vectors and adding
#  them together:

for(i in 1:length(v1)){
  result[i] <- v1[i] + v2[i]
}

# How much faster is the vectorized approach?


time.R <- system.time(
  result <- v1 + v2
)

time.loop <- system.time(
  for(i in 1:length(v1)){
    result[i] <- v1[i] + v2[i]
  }
)


# What about apply()?

mat <- matrix(rnorm(1000000), nrow = 100)

time.R <- system.time(
  result <- apply(mat, 2, mean)
)

time.loop <- system.time(
  for(i in 1:ncol(mat)){
    result[i] <- mean(mat[,i])
  }
)

time.R
time.loop

# lapply()?

df <- as.data.frame(matrix(rnorm(10000000), nrow = 100))

time.R <- system.time(
  result <- sapply(df, mean)
)

time.loop <- system.time(
  for(i in 1:ncol(df)){
    result[i] <- mean(df[[i]])
  }
)

time.R
time.loop

############
# aggregate()
############

# aggregate() is the PROC MEANS of base R
# it allows you to apply a function to observations grouped by a "by" variable, i.e. a grouping variable

library(MASS)

aggregate(Cars93$Price, by = list(Cars93$Manufacturer), min)

aggregate(Cars93$Price, by = list(Cars93$Type, Cars93$Drive.Train), mean)


# how fast is aggregate compared to a loop?

class.labels <- c("A", "B", "C", "D")

class <- sample(class.labels, 100, replace = TRUE)
df <- data.frame(class, matrix(rnorm(1000000), nrow = 100))

time.R <- system.time(
  result <- aggregate(df[,-1], by = list(class), FUN = mean)
)

pt <- proc.time()
  all.results <- matrix(nrow = length(class.labels), ncol = ncol(df)-1)
  rownames(all.results) <- class.labels
  
  result2 <- vector(length = ncol(df) - 1)
  
  for(j in class.labels){
    df.class <- df[df$class == j, -1]
    for(i in 1:ncol(df.class)){
      result2[i] <- mean(df.class[[i]])
    }
    all.results[j,] <- result2
  }
time.loop <- proc.time() - pt

time.R
time.loop





library(data.table)

df.dt <- data.table(df)
result3 <- df.dt[j = lapply(.SD, sum), by = class]



############
# profiling R code
############

# Rprof() can be used to profile R code, i.e. look at what functions are taking the most time
# This can be useful if you want to try and make your code run faster.

# to start profiling, type
# > Rprof()
# to stop profiling, type
# > Rprof(NULL)
# to see the results of profiling, type
# > summaryRprof()

# By default, Rprof() records which function is being used every 20 miliseconds
# the results are written to the file Rprof.out

