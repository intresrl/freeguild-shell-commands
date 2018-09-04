#! /bin/awk -f

# Expected input should be formatted like the result of `ls -l`

# number of lines of given input
END { print "Number of files: " NR }

# kb of listed files if byte size is in 5th column (space-separated)
{ bytes += $5 }
END { print "Total kilobytes: "int(bytes/1024)"kb" }

