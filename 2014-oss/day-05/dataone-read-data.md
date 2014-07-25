---
title: Using the dataone package
author: Matt Jones
output:
  html_document:
    toc: false
    highlight: default
---  

The `dataone` package provides classes for reading and writing data from DataONE repositories.  We demonstrate how to connect to DataONE, query to locate data of interest, and how to then use the identifiers of that data to access both the data files and the associated metadata.  We then load the data as a data.frame.


```r
library(dataone)

mn_nodeid <- "urn:node:mnTestKNB"
#mn_nodeid <- "urn:node:mnDemo9"
```

## Create a client 

The DataONE package uses a client of the class `D1Client` to communicate with the system.  The `D1Client` communicates with the DataONE network of Member Nodes when a user requests to read or write data.


```r
# cli <- D1Client()
cli <- D1Client("STAGING2")
setMNodeId(cli, mn_nodeid)
```

## Search for data

Once we have a client (`cli`), we can use it to search for data packages, and only request versions that have not been replaced by a newer version (`-obsoletedBy:*`). The search syntax follows the [SOLR/Lucene query syntax](http://lucene.apache.org/core/3_6_0/queryparsersyntax.html).  DataONE provides a list of searchable fields which have been extracted from the metadata of all of their data packages. In this example, we request any data set with metadata matching `increase experiments`, and we ask that the `identifier`, `title`, `author`, `documents`, and `resourceMap` fields be returned.


```r
results <- d1SolrQuery(cli, list(q="increase experiments -obsoletedBy:*",fl="identifier,title,author,documents,resourceMap"))
sr <- xmlParse(results)
sr
```

```
## <?xml version="1.0" encoding="UTF-8"?>
## <response>
##   <lst name="responseHeader">
##     <int name="status">0</int>
##     <int name="QTime">57</int>
##     <lst name="params">
##       <str name="fl">identifier,title,author,documents,resourceMap</str>
##       <str name="q">increase experiments -obsoletedBy:*</str>
##     </lst>
##   </lst>
##   <result name="response" numFound="448" start="0">
##     <doc>
##       <str name="author">Daly</str>
##       <arr name="documents">
##         <str>AKCRRAB.35.1</str>
##       </arr>
##       <str name="identifier">AKCRRAB.36.1</str>
##       <arr name="resourceMap">
##         <str>resourceMap_AKCRRAB.36.1</str>
##       </arr>
##       <str name="title">Size grading juvenile RKC (size-diet)</str>
##     </doc>
##     <doc>
##       <str name="author">Elizabeth Wolkovich</str>
##       <arr name="documents">
##         <str>doi:10.5063/AA/wolkovich.30.1</str>
##         <str>doi:10.5063/AA/wolkovich.29.1</str>
##         <str>doi:10.5063/AA/wolkovich.28.1</str>
##       </arr>
##       <str name="identifier">doi:10.5063/AA/nceas.982.3</str>
##       <arr name="resourceMap">
##         <str>resourceMap_nceas.982.3</str>
##       </arr>
##       <str name="title">STONE: Synthesis of Timings Observed in iNcrease Experiments</str>
##     </doc>
##     <doc>
##       <str name="author">Elizabeth Wolkovich</str>
##       <arr name="documents">
##         <str>doi:10.5063/AA/wolkovich.30.1</str>
##         <str>doi:10.5063/AA/wolkovich.29.1</str>
##         <str>doi:10.5063/AA/wolkovich.28.1</str>
##       </arr>
##       <str name="identifier">doi:10.5063/AA/nceas.982.2</str>
##       <arr name="resourceMap">
##         <str>resourceMap_nceas.982.2</str>
##       </arr>
##       <str name="title">STONE: Synthesis of Timings Observed in iNcrease Experiments</str>
##     </doc>
##     <doc>
##       <str name="author">John Downing</str>
##       <str name="identifier">doi:10.5063/AA/connolly.245.3</str>
##       <str name="title">Meta-analysis of marine nutrient-enrichment experiments: systematic variation in the magnitude of nutrient limitation</str>
##     </doc>
##     <doc>
##       <str name="author">Elsa Cleland</str>
##       <str name="identifier">doi:10.5063/AA/knb.192.5</str>
##       <str name="title">Synthesis of nitrogen fertilization experiments in North America - plant species relative abundance</str>
##     </doc>
##     <doc>
##       <arr name="documents">
##         <str>doi:10.5063/AA/FlowExp.4.9</str>
##       </arr>
##       <str name="identifier">doi:10.5063/AA/FlowExp.3.2</str>
##       <arr name="resourceMap">
##         <str>resourceMap_FlowExp.3.2</str>
##       </arr>
##       <str name="title">Large-scale flow experiments site attributes</str>
##     </doc>
##     <doc>
##       <arr name="documents">
##         <str>FlowExp.4.10</str>
##       </arr>
##       <str name="identifier">FlowExp.3.3</str>
##       <arr name="resourceMap">
##         <str>resourceMap_FlowExp.3.3</str>
##       </arr>
##       <str name="title">Large-scale flow experiments site attributes</str>
##     </doc>
##     <doc>
##       <str name="author">John Stephen Roden</str>
##       <str name="identifier">doi:10.5063/AA/nrs.702.1</str>
##       <str name="title">The Physiological  Benefit of Leaf Flutter in Poplars</str>
##     </doc>
##     <doc>
##       <str name="author">Sherburne, Friend Jr. Cook</str>
##       <str name="identifier">doi:10.5063/AA/nrs.645.6</str>
##       <str name="title">Coexistence and Competition in Two Species of Legume Aphids</str>
##     </doc>
##     <doc>
##       <str name="author">Eric Seabloom</str>
##       <arr name="documents">
##         <str>doi:10.5063/AA/seabloom.3.1</str>
##         <str>doi:10.5063/AA/seabloom.4.1</str>
##       </arr>
##       <str name="identifier">doi:10.5063/AA/seabloom.5.2</str>
##       <arr name="resourceMap">
##         <str>resourceMap_seabloom.5.2</str>
##       </arr>
##       <str name="title">Sedgwick BYDV Prevalence</str>
##     </doc>
##   </result>
## </response>
## 
```

## Directly fetch data

Inspecting the search output above, one can see data packages, their identifiers, and identifiers of both the metadata and component data files that comprise the data package.  We can download one of the data files listed in the search results, and convert it to a data frame if we know it is a CSV file.


```r
obj0 <- getD1Object(cli, "doi:10.5063/AA/wolkovich.30.1")
d0 <- asDataFrame(obj0)
head(d0)
```

```
##     site temprep
## 1 EEC003    mean
## 2 EEC003    mean
## 3 EEC003    mean
## 4 EEC003    mean
## 5 EEC003    mean
## 6 EEC003    mean
```

## Data Packages

Often a data set will consist of many tens of files, and individually examining search output to find each of them can be tedious.  We can make use of the DataONE DataPackage metadata to determine which data files are contained in the data set, and then list the identifiers for those.


```r
pkg <- getPackage(cli, "resourceMap_nceas.982.3")
getIdentifiers(pkg)
```

```
## [1] "doi:10.5063/AA/wolkovich.30.1" "doi:10.5063/AA/nceas.982.3"   
## [3] "doi:10.5063/AA/wolkovich.29.1" "doi:10.5063/AA/wolkovich.28.1"
```

## Get data from a package

Once a DataPackage has been downloaded, its data objects are local and we can request each of the items from the package using its identifier.  Below, we get the data for two identified data files, and create data frames for each of the data objects as we know they are CSV format (which can be determined from the object format type).



## Download metadata

Each data package can also have associated science metadata, which we retrieve in the same way as the data objects.  But in this case, the metadata returned is in XML format, for which we can use a standard XML parser to manipulate the metadata.


```r
obj4 <- getMember(pkg, "doi:10.5063/AA/nceas.982.3")
getFormatId(obj4)
```

```
## [1] "eml://ecoinformatics.org/eml-2.1.0"
```

```r
metadata <- xmlParse(getData(obj4))
```

## Extract attributes 

With the metadata parsed, we can now extract and print a list of all attribute names in the metadata (and any other metadata field that was encoded in the metadata document).  See the [EML Specification](https://knb.ecoinformatics.org/software/eml) for details on the possible fields in a metadata document.


```r
attList <- sapply(getNodeSet(metadata, "//attributeName"), xmlValue)
attList
```

```
##  [1] "\"DatasetID\""       "\"Year\""            "\"medium\""         
##  [4] "\"Temp_treat\""      "\"onetempchange\""   "\"Precip_treat\""   
##  [7] "\"precipchange\""    "\"precipchangetyp\"" "\"DatasetID\""      
## [10] "\"Temp_treat\""      "\"Precip_treat\""    "\"Year\""           
## [13] "\"Genus\""           "\"Species\""         "\"responsetype\""   
## [16] "\"meanresponse\""    "\"responseunites\""  "\"stderror\""       
## [19] "\"n\""               "\"otherdatanote\""   "\"Responsenotes\""  
## [22] "\"phenper\""         "\"phentype\""        "\"species\""        
## [25] "\"medium\""          "\"onetempchange\""   "\"precipchange\""   
## [28] "\"precipchangetyp\"" "\"site\""            "\"temprep\""
```

## Load into EML

Alternatively, we can use the `EML` package to parse the EML document and gain access to its contents through convenient parsing methods. The `EML` package is aware of the `dataone` package and will use it to load metadata from the DataONE network.


```r
library(EML)
eml <- eml_read("doi:10.5063/AA/nceas.982.3")
eml_get(eml, "id")
```

```
## [1] "nceas.982.3"
```

```r
eml_get(eml, "version")
```

```
## [1] "eml://ecoinformatics.org/eml-2.1.0"
```

```r
eml_get(eml, "creator")
```

```
## [1] "[cre]"                                                    
## [2] "[cre]"                                                    
## [3] "Elizabeth Wolkovich <wolkovich@biodiversity.ubc.ca> [cre]"
```

```r
eml_get(eml, "attributeList")
```

```
## $attribute
## $attribute[[1]]
## [1] "\"DatasetID\""
## 
## $attribute[[2]]
## [1] "Unique identifier of study"
## 
## $attribute[[3]]
## [1] "Initials of person who entered study and 3 digit numerical code"
## 
## 
## $attribute
## $attribute[[1]]
## [1] "\"Year\""
## 
## $attribute[[2]]
## [1] "Year"
## 
## $attribute[[3]]
## [1] "YYYY"
## 
## 
## $attribute
## $attribute[[1]]
## [1] "\"medium\""
## 
## $attribute[[2]]
## [1] "Medium in which climate variable was measured"
## 
## $attribute[[3]]
## [1] "Medium in which climate variable was measured"
## 
## 
## $attribute
## $attribute[[1]]
## [1] "\"Temp_treat\""
## 
## $attribute[[2]]
## [1] "Temperature treatment"
## 
## $attribute[[3]]
## [1] "0 is control, 1 is heating, 2 is heating above 1 etc."
## 
## 
## $attribute
## $attribute[[1]]
## [1] "\"onetempchange\""
## 
## $attribute[[2]]
## [1] "temperature change, collapsing data from multiple columns in original file"
## 
## $attribute[[3]]
## [1] "celsius"
## 
## 
## $attribute
## $attribute[[1]]
## [1] "\"Precip_treat\""
## 
## $attribute[[2]]
## [1] "Precipitation treatment"
## 
## $attribute[[3]]
## [1] "0 is control, 1 is water addition, -1 water removal etc."
## 
## 
## $attribute
## $attribute[[1]]
## [1] "\"precipchange\""
## 
## $attribute[[2]]
## [1] "Change in precipitation"
## 
## $attribute[[3]]
## [1] "Change in precipitation"
## 
## 
## $attribute
## $attribute[[1]]
## [1] "\"precipchangetyp\""
## 
## $attribute[[2]]
## [1] "Information on change in precipitation"
## 
## $attribute[[3]]
## [1] "Information on precipitation measurement"
```

