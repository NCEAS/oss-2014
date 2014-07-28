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

You can also coerce this into a `data.frame` like so:


```r
data.frame(x)
```

```
       Species smallest_sepal largest_sepal
  1     setosa            4.3           5.8
  2 versicolor            4.9           7.0
  3  virginica            4.9           7.9
```

Need to check to make sure there are even samples across all species?


```r
y <- iris %>% group_by(Species) %>% summarise(sample_size = n())
y
```

```
  Source: local data frame [3 x 2]
  
       Species sample_size
  1     setosa          50
  2 versicolor          50
  3  virginica          50
```

More complex select operations


```r
iris <- tbl_df(iris) # so it prints a little nicer
select(iris, starts_with("Petal"))
```

```
  Source: local data frame [150 x 2]
  
     Petal.Length Petal.Width
  1           1.4         0.2
  2           1.4         0.2
  3           1.3         0.2
  4           1.5         0.2
  5           1.4         0.2
  6           1.7         0.4
  7           1.4         0.3
  8           1.5         0.2
  9           1.4         0.2
  10          1.5         0.1
  ..          ...         ...
```

```r
select(iris, ends_with("Width"))
```

```
  Source: local data frame [150 x 2]
  
     Sepal.Width Petal.Width
  1          3.5         0.2
  2          3.0         0.2
  3          3.2         0.2
  4          3.1         0.2
  5          3.6         0.2
  6          3.9         0.4
  7          3.4         0.3
  8          3.4         0.2
  9          2.9         0.2
  10         3.1         0.1
  ..         ...         ...
```

```r
select(iris, contains("etal"))
```

```
  Source: local data frame [150 x 2]
  
     Petal.Length Petal.Width
  1           1.4         0.2
  2           1.4         0.2
  3           1.3         0.2
  4           1.5         0.2
  5           1.4         0.2
  6           1.7         0.4
  7           1.4         0.3
  8           1.5         0.2
  9           1.4         0.2
  10          1.5         0.1
  ..          ...         ...
```

```r
select(iris, Petal.Length, Petal.Width)
```

```
  Source: local data frame [150 x 2]
  
     Petal.Length Petal.Width
  1           1.4         0.2
  2           1.4         0.2
  3           1.3         0.2
  4           1.5         0.2
  5           1.4         0.2
  6           1.7         0.4
  7           1.4         0.3
  8           1.5         0.2
  9           1.4         0.2
  10          1.5         0.1
  ..          ...         ...
```



