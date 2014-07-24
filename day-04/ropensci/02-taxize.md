---
title: Resolving taxonomic names using Taxize
author: Karthik Ram
output:
  pdf_document:
    toc: false
    highlight: default
---  





```r
library(taxize)
```

```
  
  
  New to taxize? Tutorial at http://ropensci.org/tutorials/taxize_tutorial.html 
  citation(package='taxize') for the citation for this package 
  API key names have changed. Use tropicosApiKey, eolApiKey, ubioApiKey, and pmApiKey in your .Rprofile file. 
  Use suppressPackageStartupMessages() to suppress these startup messages in the future
```

```r
temp <- gnr_resolve(names = c("Helianthos annus", "Homo saapiens"))
temp$results[ , -c(1,4)]
```

```
                   matched_name data_source_title
  1        Helianthus annuus L. Catalogue of Life
  2         Helianthus annus L.               EOL
  3            Helianthus annus               EOL
  4            Helianthus annus     uBio NameBank
  5 Homo sapiens Linnaeus, 1758 Catalogue of Life
```



```r
mynames <- c("Helianthus annuus", "Pinus contort", "Poa anua", "Abis magnifica",
    "Rosa california", "Festuca arundinace", "Sorbus occidentalos","Madia sateva")
tnrs(query = mynames, source = "iPlant_TNRS")[ , -c(5:7)]
```

```
  Calling http://taxosaurus.org/retrieve/ccff9600065fe4d6cd9cb89f1f6477ff
```

```
          submittedname        acceptedname    sourceid score
  7   Helianthus annuus   Helianthus annuus iPlant_TNRS     1
  4       Pinus contort      Pinus contorta iPlant_TNRS  0.98
  5            Poa anua           Poa annua iPlant_TNRS  0.96
  3      Abis magnifica     Abies magnifica iPlant_TNRS  0.96
  8     Rosa california    Rosa californica iPlant_TNRS  0.99
  2  Festuca arundinace Festuca arundinacea iPlant_TNRS  0.99
  1 Sorbus occidentalos Sorbus occidentalis iPlant_TNRS  0.99
  6        Madia sateva        Madia sativa iPlant_TNRS  0.97
```

# Retrieve higher taxonomic names

Another task biologists often face is getting higher taxonomic names for a taxa list. Having the higher taxonomy allows you to put into context the relationships of your species list. For example, you may find out that species A and species B are in Family C, which may lead to some interesting insight, as opposed to not knowing that Species A and B are closely related. This also makes it easy to aggregate/standardize data to a specific taxonomic level (e.g., family level) or to match data to other databases with different taxonomic resolution (e.g., trait databases).


```r
specieslist <- c("Abies procera","Pinus contorta")
classification(specieslist, db = 'itis')
```

```
  
  Retrieving data for taxon 'Abies procera'
  
  http://www.itis.gov/ITISWebService/services/ITISService/getITISTermsFromScientificName?srchKey=Abies procera
  
  Retrieving data for taxon 'Pinus contorta'
  
  http://www.itis.gov/ITISWebService/services/ITISService/getITISTermsFromScientificName?srchKey=Pinus contorta
  http://www.itis.gov/ITISWebService/services/ITISService/getFullHierarchyFromTSN?tsn=181835
  http://www.itis.gov/ITISWebService/services/ITISService/getFullHierarchyFromTSN?tsn=183327
```

```
  $`Abies procera`
                name          rank
  1          Plantae       Kingdom
  2   Viridaeplantae    Subkingdom
  3     Streptophyta  Infrakingdom
  4     Tracheophyta      Division
  5  Spermatophytina   Subdivision
  6     Gymnospermae Infradivision
  7        Pinopsida         Class
  8          Pinales         Order
  9         Pinaceae        Family
  10           Abies         Genus
  11   Abies procera       Species
  
  $`Pinus contorta`
                name          rank
  1          Plantae       Kingdom
  2   Viridaeplantae    Subkingdom
  3     Streptophyta  Infrakingdom
  4     Tracheophyta      Division
  5  Spermatophytina   Subdivision
  6     Gymnospermae Infradivision
  7        Pinopsida         Class
  8          Pinales         Order
  9         Pinaceae        Family
  10           Pinus         Genus
  11  Pinus contorta       Species
  
  attr(,"class")
  [1] "classification"
  attr(,"db")
  [1] "itis"
```

It turns out both species are in the family Pinaceae. You can also get this type of information from the NCBI by doing classification(specieslist, db = 'ncbi').
Instead of a full classification, you may only want a single name, say a family name for your species of interest. The function *tax_name} is built just for this purpose. As with the classification function you can specify the data source with the db argument, either ITIS or NCBI.


```r
tax_name(query = "Helianthus annuus", get = "family", db = "ncbi")
```

```
  
  Retrieving data for taxon 'Helianthus annuus'
```

```
        family
  1 Asteraceae
```


# What taxa are the children of my taxon of interest?

If someone is not a taxonomic specialist on a particular taxon he likely does not know what children taxa are within a family, or within a genus. This task becomes especially unwieldy when there are a large number of taxa downstream. You can of course go to a website like Wikispecies or Encyclopedia of Life to get downstream names. However, taxize provides an easy way to programatically search for downstream taxa, both for the Catalogue of Life (CoL) and the Integrated Taxonomic Information System. Here is a short example using the CoL in which we want to find all the species within the genus Apis (honey bees).


```r
col_downstream(name = "Apis", downto = "Species")
```

```
  
```

```
  $Apis
    childtaxa_id     childtaxa_name childtaxa_rank
  1      6971712 Apis andreniformis        Species
  2      6971713        Apis cerana        Species
  3      6971714       Apis dorsata        Species
  4      6971715        Apis florea        Species
  5      6971716 Apis koschevnikovi        Species
  6      6845885     Apis mellifera        Species
  7      6971717   Apis nigrocincta        Species
```
