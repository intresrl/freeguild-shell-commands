#! /bin/awk -f

# Split records on something other than newline (set RS variable)
BEGIN { RS = "," }

# Then print all non-empty records that don't contain a newline
$0 !~ /\r|\n|^$/ {print "Record = <" $0 "> ; RT = <" RT ">"}