#!/bin/sh

model=$1
store_filters=${2:-.}
filter="to_entries | .[] | select((.value | type) == \"object\") | select(.value[\"$model\"] == \"ALL\") | .key"
matches=`curl -s https://reserve.cdn-apple.com/US/en_US/reserve/iPhone/availability.json | jq -r "$filter"`
for match in $matches;
do
  jq -r ".stores[] | select(.storeNumber == \"$match\") | $store_filters" stores.json
done
