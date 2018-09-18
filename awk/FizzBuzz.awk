#! /bin/awk -f

NR%15==0           { print "FizzBuzz" }
NR%3==0 && NR%15>0 { print "Fizz" }
NR%5==0 && NR%15>0 { print "Buzz" }
NR%3>0  && NR%5>0  { print $0 }