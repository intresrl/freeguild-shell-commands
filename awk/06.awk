#! /bin/awk -f

# Lines with 5, 10, 15, ... (space-separated) fields - print the 5th, 10th, 15th, ... fields of each
NF % 5 == 0 { print $5 " " $10 " " $15 " " $20 " " $25 }

