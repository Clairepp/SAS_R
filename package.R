# aplpack
faces(x["x1","x2","x3"])
# maps
library(maps)
map("state", interior = FALSE)
map("state", boundary = FALSE, col="red", add = TRUE)
map('world', fill = TRUE,col=heat.colors(10))