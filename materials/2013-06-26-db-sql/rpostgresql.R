# Interfacing with PostgreSQL from R, using the RPostgreSQL package.
#
# This covers:
# * Connecting to a database
# * Doing basic CRUD operations
#   - Create
#   - Read
#  -  Update
#   - Delete
#
# For more examples like those below, see:
#   https://code.google.com/p/rpostgresql/
#
# Jim Regetz
# NCEAS Institute 2013
# 26-Jun-2013

library(RPostgreSQL)

#
# Connect to the database
#

# depending on the details of your database server, here are some things
# you may need to specify:
# ...name of database
dbname <- "my_database"
# ...user name
user <- "my_username"
# ...password (yikes, saved in the script?!?)
password <- "my_password"
# ...put password in a text file called ".pgpass", then read this in
password <- scan(".pgpass", what="")
# ...name of server hosting the database
host <- "isis.nceas.ucsb.edu"

# Case 1: local database not requiring username/password
con <- dbConnect(dbDriver("PostgreSQL"), dbname=dbname)

# Case 2: local database requiring username/password
con <- dbConnect(dbDriver("PostgreSQL"), user=user,
  password=password, dbname=dbname)

# Case 3: remote database requiring username/password
con <- dbConnect(dbDriver("PostgreSQL"), user=user,
  password=password, dbname=dbname, host=host)

summary(con)


#
# Create a table
#

# easiest way to create a new table in the database
dbWriteTable(con, "iris", iris, row.names=FALSE)
# (or you can use SQL: CREATE TABLE ...)

# dbWriteTable variants:
#   overwrite=TRUE : *replaces* table
#   append=TRUE    : inserts new rows
# (default is that both are FALSE; can't have both TRUE)

# another example, this time inserting a data.frame created on the fly 
dbWriteTable(con,
    name = "sillytable",
    value = data.frame(
        time=seq(Sys.time(), by="1 day", length=10),
        value=rnorm(10)),
    row.names=FALSE)


#
# Read data from the database
#

# first let's just get some info about what's in the database
# ...list tables in the database
dbListTables(con)
# ...list column names from particular table
dbListFields(con, "iris")

# three ways to extract data from the database

# 1. retrieve an entire table by name
iris1 <- dbReadTable(con, "iris")

# 2. retrieve data by querying (in this case, entire table!)
iris2 <- dbGetQuery(con, "SELECT * FROM iris")
dbGetQuery(con, "SELECT * FROM iris ORDER BY weighted DESC LIMIT 5")

# show that these options are equivalent
identical(iris1, iris2)
## [1] TRUE

# 3. as above, but decouple query submission from result transfer
rs <- dbSendQuery(con, "SELECT * FROM iris")
dbColumnInfo(rs)
##           name    Sclass   type len precision scale nullOK
## 1 Sepal.Length    double FLOAT8   8        -1    -1   TRUE
## 2  Sepal.Width    double FLOAT8   8        -1    -1   TRUE
## 3 Petal.Length    double FLOAT8   8        -1    -1   TRUE
## 4  Petal.Width    double FLOAT8   8        -1    -1   TRUE
## 5      Species character   TEXT  -1        -1    -1   TRUE
dbGetStatement(rs)
## [1] "SELECT * FROM iris"
dbHasCompleted(rs)
## [1] FALSE
dbGetRowCount(rs)
## [1] 10
#   ... just get the first 10 records
iris3.first10 <- fetch(rs, 10)
#   ... now get the rest of them
iris3.rest <- fetch(rs, -1)
# now free up resources used by the result set
dbClearResult(rs)

# show that this third option is also equivalent
identical(iris2, rbind(iris3.first10, iris3.rest))
## [1] TRUE

#
# Update data
#

# no friendly wrappers in R -- use SQL!
sql <- "INSERT INTO sites (siteid, altitude, habitat) VALUES (33, 121, 'forest')"
dbGetQuery(con, sql)

# let's do it again, violating unique constraint
# ...results in an error!
dbGetQuery(con, sql)

#
# Delete
#

# no friendly wrappers in R -- use SQL!
sql <- "DELETE from sites where siteid=33"
dbGetQuery(con, sql)

#
# Free all resources!
#

# disconnect from database
dbDisconnect(con)

# unload database driver
dbUnloadDriver(drv)


