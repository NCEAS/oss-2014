# Accessing data from DataONE using R

## \ 

## Goal of this presentation:

> * Promote understanding of DataONE model and architecture
* Illustrate access to DataONE hosted data sets using the R dataone package

Matthew B. Jones, NCEAS, UCSB

# Data in the KNB data repository
![](images/knb-search.png)

# With detailed metadata
![](images/knb-metadata.png)

# DataONE Data Flow

![](images/dataflow.png)

# Data Packages

![](images/data-package.png)

# Displaying a package

![](images/web-package.png)

# R "dataone" library functions

> * Search DataONE for data of interest
* Download individual data files and associated metadata
* Download complete data packages (data and metadata)
* Create new data packages on Member Nodes

# Installing the dataone package

> * Requires Java is already installed
* install.packages("dataone")
    - May see dependency errors on XML and rJava; we will work those out
	- May need to run: "sudo R CMD javareconf"

# Searching DataONE

> * DataONE supports SOLR query syntax
* Results returned are list of data packages
* Includes identifiers for:
    - Package (resource map)
    - Science Metadata
    - Data objects

# Search results

![](images/search-results.png)

# Downloading data and packages

> * getD1Object()
* getDataPackage()

# Authentication using CILogon

> * Allows access to restricted objects
* Allows creation of content on appropriate nodes
* CILogon provides authentication through a many current University partners
* https://cilogon.org/?skin=DataONE
* Saves a certificate on your hard drive that the R dataone library finds

# Writing data to DataONE Member Nodes

> * Write data to nodes that provide write service
    - e.g., KNB

* Steps
	- Load the data frame in R
	- Generate or request an identifier for the object
	- Convert it to CSV format
	- Make an instance of D1Object class containing the data
	- Mark the object as publicly accessible
    - Upload the object to the KNB by calling the createD1Object() method

