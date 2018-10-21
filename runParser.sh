#!bin/bash

rm items.dat
rm category.dat
rm users.dat
rm bids.dat

python skeleton_parser.py ./ebay_data/items-*.json

sort -k1 -u -o items.dat items.dat
sort -k1 -u -o categoryOf.dat category.dat
sort -k1 -u -o users.dat users.dat
sort -k1 -u -o bids.dat bids.dat

cat categoryOf.dat | awk -F"|" '{print $2}' > category.dat
sort -k1 -u -o category.dat category.dat
