#!/bin/bash

# this is for the purpose of showing my steps. The Ubuntu version of GDAL does not open GDB files yet,
# however the MacOS version does.  This is a conversion script that takes the ACS gdb files and 
# pulls out the data that we need for the class.  Using the whole GDB files is impractical because of
# size and because the number of columns is too large for most programs to work with (1600 per table or more).

################################################################################# 
# convert the county GDB to a spatialite database containing only the geography 
# and household total, and household poverty total
################################################################################# 

# Pull the metadata table so we can see the long names and how they match to the shortcodes for column titles
ogr2ogr -f CSV acs_metadata.csv  ACS_2012_5YR_COUNTY.gdb COUNTY_METADATA_2012

# 1. Get the data for poverty
#
# -f SQLite : use SQLite driver for output
# -dsco SPATIALITE=yes : see SQLite driver documentation. Use spatialite extensions for geometry
# ACS_2012_5YR_COUNTY.gdb : use this database
# X19_INCOME -select GEOID,B19058e1,B19058e2 : pull only these fields from the X19_INCOME layer. they are the geometry linkage and the total household count, and the poverty household count
ogr2ogr -f SQLite -dsco SPATIALITE=yes foodstamps.sqlite ACS_2012_5YR_COUNTY.gdb X19_INCOME -select GEOID,B19058e1,B19058e2  

# 2. Get the geometry.  This is done as a separate step because it's a second table and you can't do two selects
# 
# -append : append to the existing database
ogr2ogr -f SQLite -dsco SPATIALITE=yes -append foodstamps.sqlite ACS_2012_5YR_COUNTY.gdb ACS2012_COUNTY_GEOGRAPHY

# 3. Make a shapefile with a single dataset containing only the data we want: geometry, poverty counts, and household counts
#
# -sql "..." : execute an SQL query to join geometry to povery in a single table 
ogr2ogr -f "ESRI Shapefile" -sql "select * from acs2012_county_geography, x19_income where x19_income.geoid=acs2012_county_geography.geoid_1;" foodstamps_us_county.shp foodstamps.sqlite

rm foodstamps.sqlite

################################################################################# 
# convert the California Tract GDB to a spatialite database containing only the geography 
# and household total, and household poverty total
################################################################################# 
ogr2ogr -f SQLite -dsco SPATIALITE=yes foodstamps.sqlite ACS_2012_5YR_TRACT_06_CALIFORNIA.gdb X19_INCOME -select GEOID,B19058e1,B19058e2
ogr2ogr -f SQLite -dsco SPATIALITE=yes -append foodstamps.sqlite ACS_2012_5YR_TRACT_06_CALIFORNIA.gdb ACS_2012_5YR_TRACT_06_CALIFORNIA
ogr2ogr -f "ESRI Shapefile" -sql "select * from acs_2012_5yr_tract_06_california, x19_income where x19_income.geoid=acs_2012_5yr_tract_06_california.geoid_data;" foodstamps_ca_tract.shp foodstamps.sqlite
rm foodstamps.sqlite

################################################################################# 
# convert the North Carolina Tract GDB to a spatialite database containing only the geography 
# and household total, and household poverty total
################################################################################# 
ogr2ogr -f SQLite -dsco SPATIALITE=yes foodstamps.sqlite ACS_2012_5YR_TRACT_37_NORTH_CAROLINA.gdb X19_INCOME -select GEOID,B19058e1,B19058e2
ogr2ogr -f SQLite -dsco SPATIALITE=yes -append foodstamps.sqlite ACS_2012_5YR_TRACT_37_NORTH_CAROLINA.gdb ACS_2012_5YR_TRACT_37_NORTH_CAROLINA
ogr2ogr -f "ESRI Shapefile" -sql "select * from acs_2012_5yr_tract_37_north_carolina, x19_income where x19_income.geoid=acs_2012_5yr_tract_37_north_carolina.geoid_data;" foodstamps_nc_tract.shp foodstamps.sqlite
rm foodstamps.sqlite

