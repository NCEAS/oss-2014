
# Depositing and reading data with figshare

![](figshare-main.png)

In this demo we will learn how to share data and results after we have acquired, manipulated and processed them for an analysis. 


## What is figshare?  

> figshare allows researchers to publish all of their data in a citable, searchable and sharable manner. All data is persistently stored online under the most liberal Creative Commons licence, waiving copyright where possible. This allows scientists to access and share the information from anywhere in the world with minimal friction.

## why figshare?    


## API Keys

To access your account programmatically we will use API keys rather than using a username and password directly. To add API keys for this demo, paste the following code into your account 

```coffee
options(FigshareKey = "xxxxxxxxxxx")
options(FigshareSecret = "xxxxxxxxxxx")
options(FigshareToken = "xxxxxxxxxxx")
options(FigshareTokenSecret = "xxxxxxxxxxx")
```
For today's demo I have already loaded these keys into your [`.rprofile`](https://github.com/ropensci/workshops-sheffield-2013-09/blob/master/02-reproducible-workflows/.rprofile_example). You can look at your keys with the `getOption()` function.

for example:

```coffee
getOption("FigshareKey")
# the others will work similarly
```


## figshare demo

Today we'll upload some data that we have access to locally. This can be data that we made up or loaded from any of the packages that we have already installed.


First load up the package:

```coffee
library(rfigshare)
# then we authenticate
fs_auth()
fs_author_search("Boettiger")
```

## Making results and data public  

```coffee
## First create an identifier on figshare
id <- fs_create("Sheffield test dataset", "File contains made up data", "dataset")
data(iris)
write.csv(iris, "iris.csv")
fs_upload(id, "iris.csv")
fs_add_tags(id, "demo")
fs_category_list()
# finally we make the data public
fs_make_public(id)
```

Now we can view the dataset on the [profile page](http://figshare.com/authors/ROpenSci%20Demo/453074) for this demo account we're using.


```coffee
Do all of the above in a single function call

id <- fs_new_article(title="A Test of rfigshare", 
                     description="This is a test", 
                     type="figure", 
                     authors=c("Karthik Ram", "Scott Chamberlain"), 
                     tags=c("ecology", "openscience"), 
                     categories="Ecology", 
                     links="http://ropensci.org", 
                     files="figure/rfigshare.png",
                     visibility="private")

```

```coffee
# Details on these files
fs_details(id, mine = TRUE)
```

```coffee
fs_browse(mine = TRUE)
# Browse all your files
```
#Note that we can easily grab the ids with the wrapper function fs_ids:

```coffee
fs_ids(all_mine)
```

# Delete non-public files

Remember that once you've made a file public, you can't delete it. 

```coffee
fs_delete(id)
```

## Retrieving other data from the web

Through a random search on fgishare for popualtion count data I found this Excel file on the web.

```
http://figshare.com/articles/_GO_model_based_gene_set_analysis_MGSA_25_using_the_Ontologizer_65_/472564
```

Let's download that one with:

```coffee
# Using the id: 41e3440
file <- fs_download(472564, urls_only = TRUE)
library(gdata)
df <- read.xls(file, sheet=1, header=T)
```


## A workflow involving figshare

* Load up your own data/acquire other data from the web
* clean and manipulate the data
* Work on your analysis
* Generate results (including tables and figures)
* Publish to figshare

