#!/bin/bash
curl -A 'Mozilla/4.0 (MSIE 6.0; Windows NT 5.0)' 'http://www.carqueryapi.com/api/0.3/?cmd=getMakes' | jq '.Makes[]' | jq '{country: .make_country, cars_released: .make_country, model: .make_display}' | jq -s 'sort_by(.country, .model) | reverse' > cars.json

REPLACEMENTS=$(cat cars.json | grep country | awk -F ':' '{print $NF}' | sort -r | uniq -c | sed 's/^ *//' | sed 's/ *"/:"/' | sed 's/ /_/g')

for REPLACEMENT in ${REPLACEMENTS}; do
  SEARCH=$(echo  ${REPLACEMENT} | awk -F ':' '{print "\"cars_released\": "$NF}' | sed 's/_/ /g' | sed 's/cars released/cars_released/g');
  REPLACE=$(echo ${REPLACEMENT} | awk -F ':' '{print "\"cars_released\": \""$1"\","}');
  sed -i "s/${SEARCH}/${REPLACE}/g" cars.json;
done

aws s3 cp ./cars.json s3://bugcrowd-infrastructure-interview/toddkimball/
