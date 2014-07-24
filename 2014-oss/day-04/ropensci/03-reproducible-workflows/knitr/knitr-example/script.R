
## @knitr loading-libraries
library(ggplot2)
data(iris)
library(pander)


## @knitr summary_data
pandoc.table(head(iris[, 1:3]))



## @knitr first_figure
ggplot(iris, aes(Sepal.Length, Sepal.Width, color = Species)) + 
geom_point(size = 3) + 
ggtitle("Sepal Length vs Sepal Width")

