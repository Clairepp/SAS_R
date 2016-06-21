# 4.12.15
# STAT 5430
# Using and debugging functions

# traceback()
# print()
# browser()



############
# de-bugging R code
############

# When an error occurs, you can find the stack of function calls 
#  that lead to the error by using traceback().
# This is useful if you are not sure where the error came from!

# Another useful idea is to print the value of some object to the 
#  console so that you can see what is going on as your code is running.
# Use print() to do this.

# Since objects created inside functions are local to the function 
#   environment, you can not "see" them on the workspace.
# browser() pauses execution and lets you look inside a function at the 
#   location where browser() is inserted, to "browse" the objects in that environment.
# This is incredibly useful to allow you to see the value of objects within the environment of the function.

# From within browser(), you can:
#   Enter commands to see the value of objects or expressions;
#   Hit n to enter "Step-through" mode. Within step-through mode:
#     - Hit return to execute the next line of code in the function;
#     - Hit c to continue to the end of the loop or the function;
#   Type where to see the sequence of function calls leading to the current location;
#   Hit return (or c) to leave the browser and continue execution;
#   Hit Q to stop execution and return to the top-level prompt.



###########
# Example
##########

# estimator of mean
# removes largest p% of values, then calculates mean on remaining values
# Inputs:
#   x - numeric vector
#   p - value between 0 and 1
# Value: numeric vector of length 1 containing the estimate
est1 <- function(x, p) {
  
  # error checks
  if(!is.numeric(x)) {
    stop("x must be numeric")
  }
    
  # trim top p% of values
  x <- sort(x)[1:ceiling(1-p)*length(x)]
  
  # return mean of remaining values
  mean(x)
}

# estimator of mean
# removes largest and smallest p/2% of values,
# then calculates mean on remaining values
est2 <- function(x, p) {
  mean(x, trim = p)
}


###########
# Simulation
###########

samp.size <- 100

# generate samples
samp1 <- rnorm(samp.size, mean = 2, sd = 2)
samp2 <- rgamma(samp.size, shape = 1, scale = 2)

# calculate estimates on each sample
mean.ests <- c(mean(samp1), mean(samp2))
est1.ests <- c(est1(samp1, .2), est1(samp2, .2))
est2.ests <- c(est2(samp1, .2), est2(samp2, .2))

results <- rbind(mean.ests, est1.ests, est2.ests)
colnames(results) <- c("normal", "gamma")
results


####
# write code to generate many samples and calculate mean and sd of estimates
# i.e. calculate estimates of the mean and sd of the sampling distributions of the estimators
####


get.samples <- function(num.samples, samp.size) {

  norm.samps <- rnorm(num.samples * samp.size, mean = 2, sd = 2)
  gamma.samps <- rgamma(num.samples * samp.size, shape = 1, scale = 2)
  
  norm.samps <- matrix(norm.samps, ncol = samp.size)
  gamma.samps <- matrix(gamma.samps, ncol = samp.size)
  
  return(list(norm = norm.samps, gamm = gamma.samps))
}

get.estimates <- function(num.samples, samp.size, p = 2) {

  # generate samples
  samples <- get.samples(num.samples, samp.size)

  # calculate estimates
  mean.ests <- apply(samples, 2, mean)
  est1.ests <- apply(samples, 2, est1, p)
  est2.ests <- apply(samples, 2, est2, p)
  
  # calculate mean and sd of each set of estimates
  means <- c(mean(mean.ests), mean(est1.ests), mean(est2.ests))
  sds <- c(sd(mean.ests), sd(est1.ests), sd(est2.ests))
  
  # compile results
  results <- cbind(means, sds)
  rownames(results) <- c("Mean", "Est1", "Est2")
  
  return(results)
}


get.estimates(num.samples = 100, samp.size = 1000)

get.estimates(num.samples = 100, samp.size = 1000, p = -0.1)



##########
# Exercises
##########

# de-bug, add error checks, and properly comment the functions above

# what would you say the mean and variance of the sampling distributon of est1 (with p = 0.15) is on a sample of size 100 from a gamma(1,2) distribution?




