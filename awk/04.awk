#! /bin/awk -f

# only print lines with less than 50 characters
length($0) < 50

# print min and max length
BEGIN { min=9999999 }                                   # BEGIN: execute before starting lines
{ if (length($0)>max) max=length($0) }
{ if (length($0)<min) min=length($0) }
END { print "Line length varies from " min " to " max } # END: execute after finishing lines

# print five random numbers from 1 to 90
END { print "And now five \"random\" numbers..." }
END { for(i=1;i<=5;i++) print int(1+90*rand()) }