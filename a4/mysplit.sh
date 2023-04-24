#!/bin/bash

#Check if the file has 1 input
if [ -z "$1" ] ;
then
	echo "Usage: $0 <dataset>"
	exit 1
fi

# create a variable to represent the % of the split (80% and 20%)
first_sub=80

# This will count the total entry excluding the headline of the file

total_entry=$(tail -n +2 "$1" | wc -l)

# Create a variable to store the entry numbers within the first subset (80% of the original)

entry_sub=$(echo "scale=0; $total_entry * $first_sub /100" | bc)

# Getting the header of the file and everything below to $entry_sub (80%).
# Then, redirect it the corresponding DIR and File
(head -n 1 "$1" && tail -n +2 "$1" | head -n $entry_sub) > cs131/a4/train/data.csv

# Getting the header of the file and everything starting from $entry_sub (the remaining % of the file)
# Then, redirect it the corresponding DIR and File
(head -n 1 "$1" && tail -n +2 "$1" | tail -n +$(($entry_sub+1))) > cs131/a4/test/data.csv
