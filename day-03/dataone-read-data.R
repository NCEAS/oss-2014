library(dataone)

# Initialize a client to interact with DataONE
cli <- D1Client()

# search for data packages, listing both data and metadata relevant, and only request versions that are not obsolete
results <- d1SolrQuery(cli, list(q="increase experiments -obsoletedBy:*",fl="identifier,title,author,documents,resourceMap"))
sr <- xmlParse(results)
sr

# Directly fetch one of the data files listed in search results
obj0 <- getD1Object(cli, "doi:10.5063/AA/wolkovich.30.1")
d0 <- asDataFrame(obj0)
head(d0)

# Retrieve a whole data package and its contents, and list its identifiers
pkg <- getPackage(cli, "resourceMap_nceas.982.3")
getIdentifiers(pkg)

# Create data frames for each of the data objects
obj1 <- getMember(pkg, "doi:10.5063/AA/wolkovich.28.1")
d1 <- asDataFrame(obj1)
head(d1)

obj2 <- getMember(pkg, "doi:10.5063/AA/wolkovich.29.1")
d2 <- asDataFrame(obj2)
head(d2)

# Download the metadata as well
obj4 <- getMember(pkg, "doi:10.5063/AA/nceas.982.3")
getFormatId(obj4)
metadata <- xmlParse(getData(obj4))
metadata

# Extract and print a list of all attribute names in the metadata
attList <- sapply(getNodeSet(metadata, "//attributeName"), xmlValue)
attList
