#! /bin/awk -f

# length of shortest line
/01/                # match only lines containing reg.ex (line 01) - default action is to print
{ print }           # print all lines - missing pattern = every line
/her/ { print $0 }  # print only lines containing reg.ex (lines 01,08,10)

# notice that these are applied to every line, so you'll see line 01 three times and lines 08,10 twice