library(stringr)
library(knitr)
library(plyr)
if(str_detect(getwd(), "source")) {

files <- dir(pattern = ".Rmd")
path <- normalizePath("../")
opts_knit$set(base.dir = path)
l_ply(files, function(x) {
        knit(x, file.path(path, sub('.Rmd$', '.md', x)))
 })

} else {
	stop("Can't execute this code outside the source dir. Please set appropriate directory first")
} 
