## `AntWeb` : Mapping ant occurrence data

In this example we plot actual occurrence data for *Bradypus* species against a single predictor variable, `BIO1` (annual mean temperature). This is only ont step in a species distribution modelling nworkflow.

This example can be done using BISON data as well with our `rbison` package.






```r
library(AntWeb)
leaf_cutter_ants  <- aw_data(genus = "acromyrmex")
```

Then we can map these as an interactive map that is easy to embed on web pages, talks, etc.


```r
aw_map(leaf_cutter_ants)
```

![ant map](http://ropensci.org/assets/tutorial-images/antweb/leafletmap.png)
