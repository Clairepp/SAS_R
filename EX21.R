# The Solution of EX 12 
# Chen Peng


# 1
# load the package and check the details of the function
library(MASS)
help(package = "MASS")

# 2
# check the details of the data
?Boston

# create the new objects
Crime <- Boston$crim
HousePrice <- Boston$medv

# 3
# check the class of each of these objects
class(Crime)  
# numeric
class(HousePrice)
# numeric

# 4
class(length(Crime))
# integer
class(length(Crime) == length(HousePrice))
# logical
class(lm(HousePrice ~ Crime))
# lm

# 5
# do the linear regression between House Price and Crime
House.lm <- lm(HousePrice ~ Crime)
summary(House.lm)
attributes(House.lm)
House.res <- House.lm$residuals
House.res[1:10]
House.res[1:10] > 0
as.numeric(House.res[1:10] > 0)
House.lm$coefficients
plot(House.lm)

# 6
# plot the House Price against Crime
plot(HousePrice, Crime)
?plot
# "xlb" and "ylab" can change the axis label, and "main" could add a main title.

# plot the log of House Price against the log of Crime
log.HousePrice <- log(HousePrice)
log.Crime <- log(Crime)
plot(log.HousePrice,log.Crime,main = "The plot between The Log of House Price against The Log of Crime", xlab = "The Log of House Price", ylab = "The Log of Crime")
