# 26.10.15
# STAT 5430
# matrices, arrays


# matrix() - create a matrix
# diag() - create a diagonal matrix or access the diagonal of a matrix
# %*% - matrix multiplication
# t() - matrix transpose
# array() - make an array
# dim() - return the dimension of a matrix
# nrow() - number of rows of a matrix
# ncol() - number of columns of a matrix
# apply() - apply a function to each row or column of a matrix/ dim of an array

library(lattice) # needed for wireframe() function

#############
# create a matrix from a vector 
#############

# the (i,j)-th element of the matrix is indexed as [i,j]
# i.e. i indexes the row, and j indexes the column

# use the matrix() function to create a matrix from a vector
?matrix
# in fact a matrix *is* a vector but with a dimension attribute
# the first element of the vector is element [1,1] of the matrix
# the second element of the vector is element [2,1] of the matrix
# ... and so on down the first column, then down the second column, ...

vec <- 1:10
mat <- matrix(vec, nrow = 5, ncol = 2)
mat

dim(mat)
nrow(mat)
ncol(mat)


# only need to specify one dimension if it is a factor of the length of the vector
matrix(vec, nrow = 5)

# if necessary, elements of the vector are recyled
vec <- 1:4
matrix(vec, nrow = 4, ncol = 3)

# if you want to fill the matrix by rows rather than columns, use the option
# byrow = TRUE
vec <- 1:3
matrix(vec, nrow = 5, ncol = 3, byrow = TRUE)
matrix(1:10, nrow = 5, byrow = TRUE)

# to add row and column names, use the dimnames= argument

vec <- 1:12
mat <- matrix(vec, nrow = 3, dimnames = list(c("r1", "r2", "r3"),c("c1", "c2", "c3", "c4")))
mat


###############
# create a diagonal matrix
###############

# use diag() to create a diagonal matrix

diag.mat <- diag(1:5)
diag.mat

diag(rep(1, 10))

# diag() can also be used to return the diagonal entries of a matrix

mat <- matrix(1:25, nrow = 5)
diag(mat)

############
# creating arrays
############

# a matrix is a special case of a 2-d array, with row and column attributes
# use the array() function to make an array
?array

arr <- array(1:36, dim = c(3, 4, 3))
arr

dim(arr)


#################
# indexing matrices
#################

# matrices are indexed and filtered similarly to vectors
# the main difference is that there are now two dimensions
# use [i,j] to refer to the element in the ith row and jth column

# just as for vectors, the index can either be integer, logical, or a character vector of names

vec <- 1:12
mat <- matrix(vec, nrow = 3, dimnames = list(c("r1", "r2", "r3"),c("c1", "c2", "c3", "c4")))
mat

mat[2, 3] # 2nd row, 3rd column
mat[1,] # 1st row, all columns
mat[,2] # 2nd column, all rows 
# note that each of the above return a vector

mat[2:3,2]
mat["r1", c("c3", "c4")]
mat[c(TRUE, TRUE, FALSE), c(TRUE, FALSE, TRUE, FALSE)]

mat[mat[,1] > mat[,2], ] # rows of mat where value in column 1 is greater than in col 2

mat[mat > 5] # vector index - converts mat to vector then performs filtering
as.vector(mat)

#############
# matrix operations
#############

mat

mat2 <- matrix(2, nrow = nrow(mat), ncol = ncol(mat))
mat2

mat + mat2 # element by element
mat * mat2 # element by element
mat %*% t(mat2) # matrix multiplication

apply(mat, 1, sum) # calculate sum of each *row* (dim 1) of mat
apply(mat, 2, mean) # calculate mean of each *column* (dim 2) of mat

##############
# Example - heat map
##############

# sometimes it is easier to visualize a large matrix as an image
# the color/intensity of the [i,j]th cell represents the i-jth value of the matrix

class(volcano)
dim(volcano)
summary(volcano)

plot(volcano) # default matrix plot is a scatter plot - not what we want here

?image
image(volcano)

contour(volcano)

##############
# Example - wireframe plot
#############

# density of a 3d normal

# first make a grid at which to calculate value of density function (z)
# need one matrix that contains the x-values at each point
# and one matrix that contains the y-values at each point
inc <- 0.5
x.vals <- seq(from = -1, to = 1, by = inc)
y.vals <- seq(from = -2, to = 2, by = inc)

x.mat <- matrix(x.vals, nrow = length(y.vals), ncol = length(x.vals), byrow = TRUE)
y.mat <- matrix(y.vals, nrow = length(y.vals), ncol = length(x.vals))

x.mat
y.mat

z.mat <- x.mat^2 + cos(y.mat) 
z.mat  
  
# wireframe() is in the lattice package
wireframe(z.mat ~ x.mat + y.mat)                           

