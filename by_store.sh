#!/bin/sh

store=$1
filter="to_entries | .[] | select((.value | type) == \"object\") | select(.value[\"$model\"] == \"ALL\") | .key"
filter=".\"$store\" | to_entries | .[] | select(.key != \"timeSlot\") | select(.value == \"ALL\") | .key"
matches=`curl -s https://reserve.cdn-apple.com/US/en_US/reserve/iPhone/availability.json | jq -r "$filter"`
for match in $matches;
do
  jq -r ".skus[] | select(.part_number == \"$match\") | select(.group_id == \"100185\") | .productDescription" catalog.json
done
