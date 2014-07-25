

# Learning the apply family of functions

One of the greatest joys of vectorized operations is being able to use the entire family of `apply` functions that are available in base `R`.

These include:


```r
apply
by
lapply
tapply
sapply
```

## apply

`apply` applies a function to each row or column of a matrix.


```r
m <- matrix(c(1:10, 11:20), nrow = 10, ncol = 2)
m
```

```
##       [,1] [,2]
##  [1,]    1   11
##  [2,]    2   12
##  [3,]    3   13
##  [4,]    4   14
##  [5,]    5   15
##  [6,]    6   16
##  [7,]    7   17
##  [8,]    8   18
##  [9,]    9   19
## [10,]   10   20
```

```r
# 1 is the row index
# 2 is the column index
apply(m, 1, sum)
```

```
##  [1] 12 14 16 18 20 22 24 26 28 30
```

```r
apply(m, 2, sum)
```

```
## [1]  55 155
```

```r
apply(m, 1, mean)
```

```
##  [1]  6  7  8  9 10 11 12 13 14 15
```

```r
apply(m, 2, mean)
```

```
## [1]  5.5 15.5
```

## by

`by` applies a function to subsets of a data frame.


```r
head(iris)
```

```
##   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
## 1          5.1         3.5          1.4         0.2  setosa
## 2          4.9         3.0          1.4         0.2  setosa
## 3          4.7         3.2          1.3         0.2  setosa
## 4          4.6         3.1          1.5         0.2  setosa
## 5          5.0         3.6          1.4         0.2  setosa
## 6          5.4         3.9          1.7         0.4  setosa
```

```r
by(iris[, 1:2], iris[,"Species"], summary)
```

```
## iris[, "Species"]: setosa
##   Sepal.Length   Sepal.Width  
##  Min.   :4.30   Min.   :2.30  
##  1st Qu.:4.80   1st Qu.:3.20  
##  Median :5.00   Median :3.40  
##  Mean   :5.01   Mean   :3.43  
##  3rd Qu.:5.20   3rd Qu.:3.67  
##  Max.   :5.80   Max.   :4.40  
## -------------------------------------------------------- 
## iris[, "Species"]: versicolor
##   Sepal.Length   Sepal.Width  
##  Min.   :4.90   Min.   :2.00  
##  1st Qu.:5.60   1st Qu.:2.52  
##  Median :5.90   Median :2.80  
##  Mean   :5.94   Mean   :2.77  
##  3rd Qu.:6.30   3rd Qu.:3.00  
##  Max.   :7.00   Max.   :3.40  
## -------------------------------------------------------- 
## iris[, "Species"]: virginica
##   Sepal.Length   Sepal.Width  
##  Min.   :4.90   Min.   :2.20  
##  1st Qu.:6.22   1st Qu.:2.80  
##  Median :6.50   Median :3.00  
##  Mean   :6.59   Mean   :2.97  
##  3rd Qu.:6.90   3rd Qu.:3.17  
##  Max.   :7.90   Max.   :3.80
```

```r
by(iris[, 1:2], iris[,"Species"], sum)
```

```
## iris[, "Species"]: setosa
## [1] 421.7
## -------------------------------------------------------- 
## iris[, "Species"]: versicolor
## [1] 435.3
## -------------------------------------------------------- 
## iris[, "Species"]: virginica
## [1] 478.1
```


## tapply

`tapply` applies a function to subsets of a vector.


```r
df <- data.frame(names = sample(c("A","B","C"), 10, rep = T), length = rnorm(10))
df
```

```
##    names  length
## 1      A -0.5237
## 2      C -1.1278
## 3      C -0.2186
## 4      A -0.4439
## 5      A  0.3567
## 6      B -1.3114
## 7      A -0.3108
## 8      A  0.4412
## 9      C  1.1764
## 10     A -0.9969
```

```r
tapply(df$length, df$names, mean)
```

```
##        A        B        C 
## -0.24623 -1.31138 -0.05667
```

Now with a more familiar dataset.


```r
tapply(iris$Petal.Length, iris$Species, mean)
```

```
##     setosa versicolor  virginica 
##      1.462      4.260      5.552
```

## lapply (and llply)

What it does: Returns a list of same length as the input. 
Each element of the output is a result of applying a function to the corresponding element.


```r
my_list <- list(a = 1:10, b = 2:20)
my_list
```

```
## $a
##  [1]  1  2  3  4  5  6  7  8  9 10
## 
## $b
##  [1]  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20
```

```r
lapply(my_list, mean)
```

```
## $a
## [1] 5.5
## 
## $b
## [1] 11
```



## sapply

`sapply` is a more user friendly version of `lapply` and will return a list of matrix where appropriate.


Let's work with the same list we just created.


```r
my_list
```

```
## $a
##  [1]  1  2  3  4  5  6  7  8  9 10
## 
## $b
##  [1]  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20
```

```r
x <- sapply(my_list, mean)
x
```

```
##    a    b 
##  5.5 11.0
```

```r
class(x)
```

```
## [1] "numeric"
```

## replicate

An extremely useful function to generate datasets for simulation purposes. 


```r
replicate(10, rnorm(10))
```

```
##          [,1]    [,2]       [,3]    [,4]     [,5]    [,6]    [,7]    [,8]
##  [1,] -0.9172  0.5877  7.015e-01  0.5953  0.23283  1.0006  0.4676 -0.2198
##  [2,] -0.3131 -2.2828 -6.308e-01 -0.0229  2.52533  0.3202 -0.6358 -2.1148
##  [3,] -0.3028 -0.1740 -6.211e-01 -1.3815 -0.35488 -0.2921 -1.3676  0.9081
##  [4,]  1.3013  1.5584  4.857e-01 -0.7587 -3.19866 -1.7516  1.4684 -0.9567
##  [5,]  1.0282  1.4281  2.023e-01  0.1864 -0.37917  0.8007  0.1699 -0.5438
##  [6,] -0.2324  0.7510 -1.851e-01 -0.8039  1.48701  0.5355  0.7567 -0.9853
##  [7,] -0.3058  0.9654 -5.257e-01 -1.8401 -1.12360  0.1255 -1.3400  0.6999
##  [8,]  1.5022  0.3563 -6.248e-07 -0.3686 -0.09473  0.6308  0.1028  1.3917
##  [9,]  1.0695 -0.2155 -9.796e-01 -0.5049 -0.33289 -0.4239  0.4249  0.9442
## [10,]  0.4670  0.7183  1.275e-01 -0.7439 -1.32077 -0.1651  0.5861  1.1303
##          [,9]   [,10]
##  [1,] -1.8391 -0.4209
##  [2,] -0.7572  2.1268
##  [3,] -1.1631 -0.4599
##  [4,]  0.5651  0.6275
##  [5,]  1.6858 -1.2053
##  [6,]  0.3718  0.1373
##  [7,] -0.7717  0.2004
##  [8,] -0.5512 -0.7647
##  [9,]  1.2261  1.1384
## [10,] -0.1802 -0.2699
```

```r
replicate(10, rnorm(10), simplify = TRUE)
```

```
##           [,1]    [,2]     [,3]     [,4]      [,5]    [,6]     [,7]
##  [1,]  0.71056  0.3211  0.30678 -0.03676 -1.360423 -1.6983  0.95665
##  [2,] -0.07385 -0.4088  2.06794  1.25581 -0.263350  0.7347 -0.05864
##  [3,]  0.46824 -1.2731  0.30914 -0.75352 -0.945496  0.6424  1.12964
##  [4,]  0.12487  1.5709  0.85055  0.17472 -0.580646 -0.1959  1.00494
##  [5,]  0.11741 -1.0469 -1.28490  0.05063 -1.076642 -0.1719  0.81520
##  [6,]  0.84867 -0.8863  0.03317 -0.48463  0.002375  0.6690 -0.63954
##  [7,] -1.05752 -0.7564  1.76743  0.10923 -0.475291 -1.0282 -1.03974
##  [8,] -0.27705 -2.2957  0.50913 -0.20030  0.025941  0.2164 -0.92946
##  [9,] -0.62126  0.1341  0.03418 -0.15921 -0.698089  0.5157 -0.28427
## [10,]  1.40383 -0.4704  1.37494 -0.72116 -0.786238 -1.9769 -0.05760
##          [,8]     [,9]   [,10]
##  [1,]  1.3396 -0.61083  0.2596
##  [2,] -0.3629  0.42503  0.5381
##  [3,] -0.4916 -0.20084 -0.2647
##  [4,]  0.3957  1.25256  1.1703
##  [5,] -0.3210  0.05367 -0.7512
##  [6,]  0.2540 -0.90845  1.2619
##  [7,] -1.2433 -1.39903 -1.3815
##  [8,] -1.4525 -0.70451 -1.3244
##  [9,]  0.6626 -1.07744  0.3161
## [10,] -1.0035  0.92710  0.5647
```

The final arguments turns the result into a vector or matrix if possible.

## mapply
Its more or less a multivariate version of `sapply`. It applies a function to all corresponding elements of each argument. 

example:


```r
list_1 <- list(a = c(1:10), b = c(11:20))
list_1
```

```
## $a
##  [1]  1  2  3  4  5  6  7  8  9 10
## 
## $b
##  [1] 11 12 13 14 15 16 17 18 19 20
```

```r
list_2 <- list(c = c(21:30), d = c(31:40))
list_2
```

```
## $c
##  [1] 21 22 23 24 25 26 27 28 29 30
## 
## $d
##  [1] 31 32 33 34 35 36 37 38 39 40
```

```r
mapply(sum, list_1$a, list_1$b, list_2$c, list_2$d)
```

```
##  [1]  64  68  72  76  80  84  88  92  96 100
```



