---
title: "Tidying data with tidyr"
author: "Karthik Ram"
date: "July 26, 2014"
output: html_document
---

`tidyr` is a new package in R that is meant to be an update/replacement to the widely used `reshape2` package. It works similar to `dplyr` in that it uses pipes (`%>%`) to chain the output from one function into the next. In addition to giving you the speed of dplyr, it also makes complex code human readable. Here are a few examples on how to use `tidyr`. I pulled together various examples from stackoverflow and answered them below.




```r
# http://stackoverflow.com/questions/7449198/
library(tidyr)
library(dplyr)
```


```r
set.seed(1001)
d <- expand.grid(f1=LETTERS[1:3],f2=letters[1:3],
                 f3=factor(as.character(as.roman(1:3))),rep=1:4)
d$y <- runif(nrow(d))
d$z <- rnorm(nrow(d))

results <- d %>% group_by(f1, f2, f3) %>% summarise(y.mean = mean(y), z.mean = mean(z))
head(results)
```

```
  Source: local data frame [6 x 5]
  Groups: f1, f2
  
    f1 f2  f3 y.mean   z.mean
  1  A  a   I 0.6502  0.38326
  2  A  a  II 0.4877 -0.20417
  3  A  a III 0.3103 -0.21567
  4  A  b   I 0.3914  0.03594
  5  A  b  II 0.5257  0.93212
  6  A  b III 0.3357 -0.37686
```

## Example 2


```r
# http://stackoverflow.com/questions/23953163/
library(tidyr)
library(dplyr)

mydata <- data.frame(var = rep(c("A","B","C"),each = 3), 
	code = rep(c("x","y","z"),3), 
	yearA = 1:9, yearB = 10:18, yearC = 20:28)

mydata %>% gather(year, value, yearA:yearC) %>%
mutate(var = paste0("var", ".", var)) %>%
spread(var, value)	
```

```
    code  year var.A var.B var.C
  1    x yearA     1     4     7
  2    x yearB    10    13    16
  3    x yearC    20    23    26
  4    y yearA     2     5     8
  5    y yearB    11    14    17
  6    y yearC    21    24    27
  7    z yearA     3     6     9
  8    z yearB    12    15    18
  9    z yearC    22    25    28
```

## Example 3


```r
# http://stackoverflow.com/questions/23945350/
library(tidyr)
library(dplyr)

dw <- read.table(header=T, text='
 sbj f1.avg f1.sd f2.avg f2.sd  blabla
   A   10    6     50     10      bA
   B   12    5     70     11      bB
   C   20    7     20     8       bC
   D   22    8     22     9       bD
 ')

dw %>% gather(v, value, f1.avg:f2.sd) %>% 
separate(v, c("var", "col")) %>% 
arrange(sbj) %>% 
spread(col, value)
```

```
    sbj blabla var avg sd
  1   A     bA  f1  10  6
  2   A     bA  f2  50 10
  3   B     bB  f1  12  5
  4   B     bB  f2  70 11
  5   C     bC  f1  20  7
  6   C     bC  f2  20  8
  7   D     bD  f1  22  8
  8   D     bD  f2  22  9
```

```r
dw %>% gather(v, value, f1.avg:f2.sd) %>% 
separate(v, c("var", "col")) %>% 
spread(col, value)
```

```
    sbj blabla var avg sd
  1   A     bA  f1  10  6
  2   A     bA  f2  50 10
  3   B     bB  f1  12  5
  4   B     bB  f2  70 11
  5   C     bC  f1  20  7
  6   C     bC  f2  20  8
  7   D     bD  f1  22  8
  8   D     bD  f2  22  9
```

