#!/bin/bash
OUT="dwcdata.csv"
CURRENT="dwcdata.xml"
BASE=http://data.gbif.org/ws/rest/occurrence
URLC="${BASE}/count?scientificname=Puma+concolor"
#URLL="${BASE}/list?scientificname=Puma+concolor\&format=darwin"
URLL=http://data.gbif.org/ws/rest/occurrence/list?scientificname=Puma+concolor\&format=darwin

echo "to:InsititutionCode,to:CollectionCode,to:catalogNumber,tn:nameComplete" > $OUT

# Query GBIF to find out how many records match the search
#COUNT=`curl $URLC | xmlstarlet sel -t -m "//gbif:summary" -v "@totalMatched"`
#echo $COUNT

curl $URLL
#echo $URLL
#curl $URLL -o $CURRENT

# Loop over blocks of those records, extracting the fields of interest into a CSV
#COUNTER=0
#while [  $COUNTER -lt 1 ]; do
#    echo The counter is $COUNTER
#    echo $URLL
#    curl $URLL > $CURRENT
#    cat $CURRENT | xmlstarlet sel -t -m "//to:TaxonOccurrence" -v "concat(to:institutionCode, ',', to:collectionCode, ',', to:catalogNumber, ',', //tn:nameComplete, '~')" | tr '~' "\n" >> $OUT
#    URLL=`cat $CURRENT | xmlstarlet sel -t -v "//gbif:nextRequestUrl"`
#    echo "New Endpoint is: $URLL"
#    let COUNTER=COUNTER+1000 
#done
