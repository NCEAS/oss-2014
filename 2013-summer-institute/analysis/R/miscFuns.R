## http://quantifyingmemory.blogspot.com/2013/02/reproducible-research-with-r-knitr.html
knitsDoc <- function(name,fmt=".html",bibfile="analysis",
                     csl="taylor-and-francis-harvard-x.csl",
                     fake=FALSE) {
  require(knitr)
  knit(paste0(name, ".rmd")) ##, encoding = "utf-8")
  cmd <- paste0("pandoc -s -o ", name, 
                fmt, " ", name, ".md --bibliography ",
                bibfile,".bib")
  if (fake) cat(cmd,"\n") else system(cmd)
## --csl taylor-and-francis-harvard-x.csl"))
}

## grep -h library *.rmd | sed -e 's/library(//' | sed -e 's/).*//' | sed -e 's/"//g' | sort | uniq

