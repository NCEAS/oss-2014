## Another Taxize use case
### Making a phylogeny directly from species names.

This functionality is currently only supported for plants. However we do expect to improve this by adding other taxonomic groups shortly.




### Load libraries


```r
library(taxize)
```


```r
splist <- c("Helianthus annuus",
"Pinus contorta",
"Collomia grandiflora",
"Abies magnifica",
"Rosa californica",
"Datura wrightii",
"Mimulus bicolor",
"Nicotiana glauca",
"Madia sativa",
"Bartlettia scaposa")
```

### Phylomatic is a web service with an API that we can use to obtain a phylogeny. We now fetch phylogeny from phylomatic 


```r
phylogeny <- phylomatic_tree(taxa = splist,
taxnames = TRUE,
get = 'POST',
informat='newick',
method = "phylomatic",
storedtree = "R20120829",
taxaformat = "slashpath",
outformat = "newick",
clean = "true")
```

### Format tip-labels 


```r
phylogeny$tip.label <- taxize_capwords(phylogeny$tip.label, 
	onlyfirst = TRUE)
```

### Plot phylogeny 


```r
plot(phylogeny)
```

![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-3.png) 
