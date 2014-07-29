---
title: "creating-r-packages.Rmd"
author: "Matt Jones"
date: "July 28, 2014"
output:
  html_document:
    keep_md: yes
---

## Why packages?

Most R users are familiar with loading and utilizing packages in their work. And they know how rich CRAN is in providing for many conceivable needs.  Ironically, most have never created a package for their own work, and most think the process is too complicated.  It is not.  Creating packages serves two main use cases:

- Mechanism to redistribute reusable code
- Mechanism to reproducibly document analysis and models and their results

The `devtools` and `roxygen` package makes creating and maintining a package to be a straightforward experience.

## Install and load packages


```r
install.packages("devtools")
library("devtools")
devtools::install_github("klutometis/roxygen")
library(roxygen2)
```

## Create a directory for the package

Thanks to the great [devtools](https://github.com/hadley/devtools) package, it only takes one function call to create the skeleton of an R package using `create()`.  Which eliminates pretty much all reasons for procrastination.  All you do is:


```r
library("devtools")
create("mytools")
```

This will create a top-level directory structure, including a number of critical files under the [standard R package structure](http://cran.r-project.org/doc/manuals/r-release/R-exts.html#Package-structure).  The most important of which is the `DESCRIPTION` file, which provides metadata about your package. Edit the `DESCRIPTION` file to provide reasonable values for each of the fields. Information about choosing a LICENSE is provided in the [Extending R](http://cran.r-project.org/doc/manuals/r-release/R-exts.html#Licensing) documentation.


```r
Package: mytools
Title: Utility functions created by Matt Jones
Version: 0.1
Authors@R: "Matthew Jones <jones@nceas.ucsb.edu> [aut, cre]"
Description: Package mytools contains a suite of utility functions useful whenever I need stuff to get done.
Depends: R (>= 3.1.0)
License: Apache License (== 2.0)
LazyData: true
```

For discussion on when to list a package under Imports or Depends, see [this discussion on StackOverflow](http://stackoverflow.com/questions/8637993/better-explanation-of-when-to-use-imports-depends). But in brief:

Avoid depends as much as possible. It's basically like saying `library(other_package)` every time your package is loaded. This can lead to a large number of dependencies being installed each time. Instead, list a package under Imports like so:

```
Imports:
    ggplot2
```

The in the documentation for any package, add the following line:

```
#' @importFrom ggplot2 ggplot
```

If you need to use all (or most functions from a package)

```
#' @import ggplot2
```

This will ensure that only the necessary functions and packages are downloaded and specific functions are referenced by NAMESPACE.

For an example to poke around, see one of Karthik's packages: [https://github.com/ropensci/ecoengine](https://github.com/ropensci/ecoengine)

See how I listed an import: 
1. https://github.com/ropensci/ecoengine/blob/master/DESCRIPTION#L25
2. and specifically imported a function for a package: https://github.com/ropensci/ecoengine/blob/master/R/ee_observations.R#L36

---

## Add your code

The skeleton package created contains a directory `R` which should contain your source files.  Add your functions and classes in files to this directory, attempting to choose names that don't conflict with existing packages.  For example, you might add a file `info.R` that contains a function `environment_info()` that you might want to reuse. This one might leave something to be desired...


```r
environment_info <- function(msg) {
    print("This should really do something useful!")
    print(paste("Also print the incoming message: ", msg))
}
```

## Add documentation

You should provide documentation for each of your functions and classes.  This is done in the `roxygen2` approach of providing embedded comments in the source code files, which are in turn converted into manual pages and other R documentation artifacts.    Be sure to define the overall purpose of the function, and each of its parameters.


```r
#' A function to print information about the current environment.
#'
#' This function prints current environment information, and a message.
#' @param msg The message that should be printed
#' @keywords debugging
#' @export
#' @examples
#' environment_info("Hi, what is your name?")
environment_info <- function(msg) {
    print("This should really do something useful!")
    print(paste("Also print the incoming message: ", msg))
}
```

Once your files are documented, you can then process the documentation using the `document()` function to generate the appropriate .Rd files that your package needs.


```r
setwd("./mytools")
document()
```

```
## Error: could not find function "document"
```

That's really it.  You now have a package that you can `check()` and `install()` and `release()`.  See below for these helper utilities.

## Checking and installing your package

Now that your package is built, you can check it for consistency and completeness using `check()`, and then you can install it locally using `install()`, which needs to be run from the parent directory of your module.


```r
setwd("./mytools")
check()
```

```
## Error: could not find function "check"
```

```r
setwd("..")
install("mytools")
```

```
## Error: could not find function "install"
```

Your package is now available for use in your local environment.

## Sharing and releasing your package

The simplest way to share your package with others is to upload it to a [GitHub repository](https://github.com), which allows others to install your package using the `install_github('mytools','github_username')` function from `devtools`.

If your package might be broadly useful, also consider releasing it to CRAN, using the `release()` method from `devtools().



