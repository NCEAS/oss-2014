
# Acquiring ecological data from the web 

*Some notes on why the importance of leveraging web databases to complement one's own data and also retrieve existing datasets to answer other questions.*

For this tutorial we will combine data from three separate web data repositories. 

* **Open Fisheries.org** - Provides access to fisheries landing data from around the world. The data can be queried using an application programming interface (API). The R package `rfisheries` makes this possible and provides simple functions to retrieve data.
* **Taxize** - This package provides an interface to various taxonomic data sources, including the Integrated Taxonomic Information Service. If you ever need to check spelling for species names in a large dataset and/or retrieve other information such as classification data, this is one of the easiest ways to do so. For more examples and use cases for the `taxize` package see a recently submitted paper by Chamberlain and Szocs. 
* **Global Biodiversity Information Facility (gbif)** - Finally we use the gbif database to retrieve distribution data


First install some packages


```r
install.packages("rgbif")
install.packages("taxize")
install.packages("rfisheries")
```



```r
# First we load all the packages.
library(rfisheries)
```

```
## Loading required package: RCurl
## Loading required package: bitops
## Loading required package: RJSONIO
```

```r
library(rgbif)
```

```
## 
## Attaching package: 'rgbif'
## 
## The following object is masked from 'package:rfisheries':
## 
##     country_codes
```

```r
library(taxize)
```

```
## 
## Attaching package: 'taxize'
## 
## The following object is masked from 'package:rgbif':
## 
##     capwords
```

```r
library(rfisheries)
library(plyr)
```

# Retrieve some fisheries data. 
We query the Open Fisheries database to get a full list of species. 

```r
# The species_codes function retrieves a full list of species from the Open
# Fisheries database
species_list <- species_codes(progress = "none")
```



```r
head(species_list)
```

```
##          scientific_name   taxocode a3_code isscaap
## 1     Petromyzon marinus 1020100101     LAU      25
## 2   Lampetra fluviatilis 1020100201     LAR      25
## 3    Lampetra tridentata 1020100202     LAO      25
## 4 Ichthyomyzon unicuspis 1020100401     LAY      25
## 5    Eudontomyzon mariae 1020100501     LAF      25
## 6      Geotria australis 1020100701     LAE      25
##              english_name
## 1             Sea lamprey
## 2           River lamprey
## 3         Pacific lamprey
## 4          Silver lamprey
## 5 Ukrainian brook lamprey
## 6         Pouched lamprey
```

```r
# Rather than look up data for every single one in this dataset, we'll pick
# a random sample of 10
species <- species_list[sample(nrow(species_list), 10), ]
curated_species <- c("COD", "YFT", "OYH", "SQJ")
species <- species_list[which(species_list$a3_code %in% curated_species), ]
```


Grab some landings data for these species



```r
safe_landings <- failwith(NULL, landings)
landings_data <- llply(species$a3_code, function(x) landings(species = x))
```


Next, using the species names we can verify whether they are correct and also locate other classification data which we can save alongside these data as valuable metadata. We pass these species names to various taxonomic name resolvers in the `taxize` package.

#

```r
# Using the species names we obtain taxonomic identifiers
taxon_identifiers <- get_uid(species$scientific_name)
```

```
## 
## Retrieving data for species 'Gadus morhua'
## 
## 
## Retrieving data for species 'Thunnus albacares'
## 
## 
## Retrieving data for species 'Ostreola conchaphila'
## 
## 
## Retrieving data for species 'Todarodes pacificus'
```

```r
# then we can grab the taxonomic information for each species
classification_data <- classification(taxon_identifiers)
names(classification_data) <- species[[1]]
cleaned_classification <- ldply(classification_data)
```

Similarly we can query the gbif database and obtain distribution data (lat, long) for these species.
Note: You may notice that we found nothing on ta



```r
# then locations
locations <- llply(as.list(species$scientific_name), function(x) gbifdata(occurrencelist(x)), 
    .progress = "none")
location_df <- ldply(locations)
names(location_df)[1] <- "scientific_name"
new_data <- merge(species, location_df)
```



```r
library(cshapes)
```

```
## Loading required package: sp
## Loading required package: maptools
## Checking rgeos availability: TRUE
```

```r
# install.packages('cshapes')
world <- cshp(date = as.Date("2008-1-1"))
world.points <- fortify(world)
```

```
## Regions defined for each Polygons
```

```r
# Make a map
species_map <- ggplot(world.points, aes(long, lat)) + geom_polygon(aes(group = group), 
    fill = "#EEEBE7", color = "#6989A0", size = 0.2) + geom_point(data = new_data, 
    aes(decimalLongitude, decimalLatitude, colour = scientific_name), alpha = 0.4, 
    size = 3) + theme(legend.position = "bottom")
```


![](data/species_map.png)


```r
ggsave(species_map, file = "data/species_map.png")
```

```
## Saving 7 x 7 in image
```

```r
write.csv(species, file = "data/species.csv")
write.csv(cleaned_classification, file = "data/cleaned_classification.csv")
# write.csv(locations, file = 'data/locations.csv') This needs some work.
# Scott, any thoughts of maybe working with a more defined species list?
```



add some EML
and push to figshare.

---


