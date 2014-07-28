---
title: "Introduction to dplyr, including how to interact with databases"
author: "Karthik Ram"
date: "July 26, 2014"
output: pdf_document
---





Manipulating and munging data just became considerably easier in `R` thanks to the `dplyr` package developed by Hadley Wickham.


```r
library(dplyr)
x <- iris %>%  
group_by(Species) %>%
summarise(smallest_sepal = min(Sepal.Length), largest_sepal = max(Sepal.Length)) 
```

Need to check to make sure there are even samples across all species?


```r
y <- iris %>% group_by(Species) %>% summarise(sample_size = n())
y
```

```
#> Source: local data frame [3 x 2]
#> 
#>      Species sample_size
#> 1     setosa          50
#> 2 versicolor          50
#> 3  virginica          50
```

You can also coerce this into a `data.frame` like so:


```r
data.frame(x)
```

```
#>      Species smallest_sepal largest_sepal
#> 1     setosa            4.3           5.8
#> 2 versicolor            4.9           7.0
#> 3  virginica            4.9           7.9
```

