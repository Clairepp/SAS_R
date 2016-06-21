# 16.11.15
# STAT 5430 
# Low-level plotting functions

# points() - add points at x-y coordinates
# lines() - add lines joining x-y coordinates
# abline() - add a straight line
# text() - add text
# grid() - add a grid
# legend() - add a legend

# density() - make a density estimate


# use the Seatbelts dataset in the datasets package
library(datasets)
Seatbelts <- as.data.frame(Seatbelts)
attach(Seatbelts)  

#########
# grids 
#########

# start with scatter plot from Wednesday
plot(kms, drivers, 
     main = "Drivers Killed or Seriously Injured in GB\n Monthly totals, 1969-84",
     xlab = "kms travelled",
     ylab = "Number of Drivers",
     pch = 16,
     col = ifelse(law == 0, 1, 2))

# add a grid
grid()
grid(col = "grey", lty = 2)

# note that the grid is placed *over* the points
# To avoid that, draw the grid first, then add the points:

plot(kms, drivers, 
     main = "Drivers Killed or Seriously Injured in GB\n Monthly totals, 1969-84",
     xlab = "kms travelled",
     ylab = "Number of Drivers",
     type = "n") # type = 'n' means that the plot is drawn without any points or lines

grid(col = "gray") # then add the grid

points(kms, drivers, 
       pch = 16, 
       col = ifelse(law == 0, 1, 2)) # then add points


#########
# writing a plot to a file
#########

# if using RStudio, easiest way is to click the "Export" button at the top of the Plot tab

savePlot(filename = "test.png", type = "png")

pdf(file = "test.pdf")
   plot(kms, drivers)
dev.off()

#########
# legends
#########

# whenever your plot has points, lines, or bars of various colors or patters etc, you need to include a legend

par(xpd = TRUE) # allow objects to be plotted outside the figure region
legend(18000, 2500,
       legend = c("before law", "after law"),
       pch = 16,
       col = c(1, 2))

legend("topright",
       legend = c("before law", "after law"),
       pch = 16,
       col = c(1, 2),
       bty = "n")


# use a different symbol for each group
plot(kms, drivers, 
     main = "Drivers Killed or Seriously Injured in GB\n Monthly totals, 1969-84",
     xlab = "kms travelled",
     ylab = "Number of Drivers",
     pch = ifelse(law == 0, 1, 16))

legend("topright",
       legend = c("before law", "after law"),
       pch = c(1, 16))


##########
# identifying points and adding text
##########

# find row index of interesting observations

# identify() allows you to click on points on the plot and it returns the index of that point in the dataset.
# Press escape to exit the interactive mode.
identify(kms, drivers)
Seatbelts[c(24, 48, 164, 2),]

outliers <- c(24, 48, 164, 2) #identify(kms, drivers)
Seatbelts$Month <- 1:nrow(Seatbelts) # add a variable indicating the Month
text(kms[outliers], drivers[outliers], Seatbelts$Month[outliers],
     pos = 2)

text(x = 18000, y = 2600, "Black dots are months after\n law was introduced")

#############
# adding reference lines
############

# abline(): a is y-intercept, b is slope
# alternatively, use h = to specify a horizontal line,
  # or v = to specify a vertical line

par(xpd = FALSE) # makes sure objects are contained to figure region again
abline(a = 3500, b = -.12)

abline(h = 2000)
abline(v = 16000, lty = 2, col = 2)

 # plot the line fitted by a linear model
lm1 <- lm(drivers ~ kms)
lm1$coeff
abline(lm1$coeff, col = 2)


#############
# plotting multiple series
#############

x.pts <-  seq(1969, by = 1/12, length = length(drivers))
plot(x.pts, drivers,
     type = "l",
     lty = 1,
     col = 2,
     main = "monthly driver deaths in GB",
     xlab = "months from 1969-1984",
     ylab = "drivers killed")

lines(x.pts, front)
lines(x.pts, rear)

# find appropriate limits for y-axis
# need to be wide enough to fit all points
max.y <- max(c(drivers, front, rear))
min.y <- min(c(drivers, front, rear))
max.y
min.y


plot(x.pts, drivers,
     type = "l",
     lty = 1,
     col = 2,
     main = "monthly driver deaths in GB",
     xlab = "months from 1969-1984",
     ylab = "drivers killed",
     ylim = c(0, 2700)) # use ylim = to change default y limits

lines(x.pts, front)
lines(x.pts, rear, col = 4)

legend("topright", 
       legend = c("drivers", "front", "rear"),
       lty = c(1, 1, 1),
       col = c(2, 1, 4))

min(which(law == 1))
abline(v = x.pts[170])


############
# add smooth density estimate to a histogram
############

par(mfrow = c(2, 1))

hist(front, freq = FALSE,
     main = "Distribution of Monthly Front Seat Passenger\n Deaths and Serious Injuries",
     xlab = "Count",
     xlim = c(200, 1300))

lines(density(front))

hist(rear, freq = FALSE,
     main = "Distribution of Monthly Rear Seat Passenger\n Deaths and Serious Injuries",
     xlab = "Count",
     xlim = c(200, 1300))

lines(density(rear))



######################

par(mfrow = c(1,1))
detach(Seatbelts) 



