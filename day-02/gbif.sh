#!/bin/bash
# Matt Jones, NCEAS
# The query to be run
SEARCH="Puma+concolor"

OUT="dwcdata.csv"
CURRENT="dwcdata.xml"
BASE=http://data.gbif.org/ws/rest/occurrence
URLC="${BASE}/count?scientificname=${SEARCH}"
URLO=http://data.gbif.org/ws/rest/occurrence/list?scientificname=${SEARCH}\&format=darwin
URLL=${URLO}

echo "to:InsititutionCode,to:CollectionCode,to:catalogNumber,tn:nameComplete" > $OUT

# Query GBIF to find out how many records match the search
COUNT=`curl -s $URLC | xmlstarlet sel -t -m "//gbif:summary" -v "@totalMatched"`
echo "Total records: $COUNT"

# Loop over blocks of those records, extracting the fields of interest into a CSV
COUNTER=0
while [  $COUNTER -lt $COUNT ]; do
    #echo $URLL
    echo "Requesting records starting at $COUNTER..."
	curl -s $URLL | xmlstarlet sel -t -m "//to:TaxonOccurrence" -v "concat(to:institutionCode, ',', to:collectionCode, ',', to:catalogNumber, ',', //tn:nameComplete, '~')" | tr '~' "\n" >> $OUT
    let COUNTER=COUNTER+1000 
    let COUNTER=$COUNT
	export URLL=${URLO}\&startindex=${COUNTER}
done
