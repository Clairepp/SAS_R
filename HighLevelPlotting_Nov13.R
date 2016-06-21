# 13.11.15
# STAT 5430 
# High-level plotting functions



# Graphs in R are created using a "high-level" plotting function which sets the basic parameters and objects of the plot.
  # plot() - use for basic x-y plots, including line (type = "l") or scatter
  # boxplot() - boxplots
  # hist() - histograms
  # barplot() - barplots
# You can then add features to the plot using "low-level" plotting functions that add features such as points, lines, text, legends, etc
  # points() - add points at x-y coordinates
  # lines() - add lines joining x-y coordinates
  # abline() - add a straight line
  # text() - add text

# Common arguments to high-levels plotting functions include:
  # main= - add a main title
  # sub= - add a sub title
  # xlab= - add a label to the x-axis
  # ylab= - add a label to the y-axis
  # xlim= - vector of length 2 specifying limits of the x-axis
  # ylim= - vector of length 2 specifying limits of the y-axis

# High-level plotting functions also have their own optional arguments -- look at the help file to see what you can control

# "Graphical parameters" are parameters of the plotting functions that control the default appearance of things like titles, axis labels, margin spacing, etc.
# These are controlled by a call to par(), or can often be included as arguments to the plot function.
# To see a list of all the graphical parameters, type ?par
# Some of the more commonly used ones are:
# mfrow - by default each plot is displayed in a separate window. Use mfrow if you want several plots to be printed in the same window.
# cex - "character expansion" factor. Controls how big the symbols are.
# col - plotting color. 
# las - "label style": determines the orientation of axis labels
# lty - line type for line plots
# mar - used if you want to increase any of the margins of the plot
# pch - plot character/symbol for scatter plots
# xpd - change this to TRUE if you want to allow your plot objects to show in the margins as well as the figure region

# for these examples, use the Seatbelts dataset in the datasets package
library(datasets)
Seatbelts <- as.data.frame(Seatbelts)
attach(Seatbelts) # "Attaches" the object to the workspace so that R will look for objects on the workspace and in the attached datasets


window() # open a separate plot window (on a mac you might need X11())

#########
# scatter plots
#########

plot(kms, drivers)

# add a title and new axis labels
plot(kms, drivers, 
     main = "Drivers Killed or Seriously Injured in GB\n Monthly totals, 1969-84",
    xlab = "kms travelled",
    ylab = "Number of Drivers")

plot(kms/1000, drivers, 
     main = "Drivers Killed or Seriously Injured in GB\n Monthly totals, 1969-84",
     xlab = "kms travelled (000s)",
     ylab = "Number of Drivers")

# change orientation of axis labels
# use graphical parameter las
plot(kms, drivers, 
     main = "Drivers Killed or Seriously Injured in GB\n Monthly totals, 1969-84",
     xlab = "kms travelled",
     ylab = "Number of Drivers",
     las = 2)


# change color or symbol of points
plot(1:20, 1:20, pch = 1:20) # find which character corresponds to what number
plot(1:10, 1:10, col = 1:10, pch = 19) # find which color corresponds to what number

plot(kms, drivers, 
     main = "Drivers Killed or Seriously Injured in GB\n Monthly totals, 1969-84",
     xlab = "kms travelled",
     ylab = "Number of Drivers",
     pch = 4,
     col = 2)

# use a different color for each group
plot(kms, drivers, 
     main = "Drivers Killed or Seriously Injured in GB\n Monthly totals, 1969-84",
     xlab = "kms travelled",
     ylab = "Number of Drivers",
     pch = 16,
     col = law + 1)

# use a different symbol for each group
plot(kms, drivers, 
     main = "Drivers Killed or Seriously Injured in GB\n Monthly totals, 1969-84",
     xlab = "kms travelled",
     ylab = "Number of Drivers",
     pch = ifelse(law == 0, 1, 16))

# need to add a legend!! (see next lecture)




#############
# series plots
#############

plot(drivers)
plot(drivers, type = "l") # lines
plot(drivers, type = "b") # both points and lines
plot(drivers, type = "n") # nothing (just the axes)

plot(drivers, type = "l",
     lty = 1,
     col = 2,
     main = "monthly driver deaths in GB",
     xlab = "months from 1969-1984",
     ylab = "drivers killed")

# change scale of x axis
plot(y = drivers, x = seq(1969, by = 1/12, length = length(drivers)),
     type = "l",
     lty = 1,
     col = 2,
     main = "monthly driver deaths in GB",
     xlab = "months from 1969-1984",
     ylab = "drivers killed")




##########
# box plots
###########

# produce one box for one numeric vector
boxplot(drivers)

# produce one box for each of several numeric vectors
boxplot(drivers, front, rear)
 # change the names of the boxes, add a y-axis label
boxplot(drivers, front, rear, 
        names = c("drivers", "front", "rear"),
        main = "Deaths or Serious Injuries by Position",
        ylab = "Deaths or Serious Injuries per Month")

# produce one box for each group of observations, grouped by a factor
# use the formula notation values ~ group
boxplot(drivers ~ law)
boxplot(drivers ~ law,
        main = "Number of Drivers per Month Seriously Killed or injured\n before and after seatbelt law",
        names = c("before", "after"),
        las = 1)


############
# histograms
############

hist(drivers) # default gives frequency on y-axis
hist(drivers, freq = FALSE) # for density estimate

hist(drivers, freq = FALSE,
     main = "Distribution of Monthly Driver Deaths and Serious Injuries",
     xlab = "Count")

# plot 2 histograms side-by-side or on top of eachother
par(mfrow = c(1,2)) # 1 row, 2 cols
hist(front)
hist(rear)

par(mfrow = c(2,1)) # 2 row, 1 cols
hist(front)
hist(rear)

# change limits of x axis

par(mfrow = c(2,1)) # 2 row, 1 cols
hist(front, xlim = c(200, 1300))
hist(rear, xlim = c(200, 1300))



#############
# bar charts
#############

?barplot
# need to give the heights of each bar

# find average numbers of drivers, front, rear passengers killed per month
killed <- apply(Seatbelts[,c("DriversKilled", "front", "rear")], 2, mean)
killed

par(mfrow = c(1,1))
barplot(killed,
        main = "Average monthly deaths, 1969-84")

# change bar labels
barplot(killed,
        main = "Average monthly deaths, 1969-84",
        names.arg = c("drivers", "front", "rear"),
        las = 3)


# find average numbers of drivers, front, rear passengers killed per month, before and after law introduced
killed2 <- aggregate(Seatbelts[,c("DriversKilled", "front", "rear")], by = list(law), mean)
killed2

plot.dat <- t(killed2[,-1])
plot.dat

barplot(plot.dat)
barplot(plot.dat, beside = TRUE)

# add title, labels, legend, etc
rownames(plot.dat)[1] <- "drivers"

barplot(plot.dat, beside = TRUE,
        legend.text = TRUE,
        names.arg = c("before", "after"),
        main = "Average monthly road deaths in GB\n Before and After seatbelt law introduced")


######################

detach(Seatbelts) 



