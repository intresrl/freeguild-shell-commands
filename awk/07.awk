#! /bin/awk -f

# Print 2nd field when it matches a reg.ex. (ending with a vowel)
$2 ~ /[aeiouAEIOU]$/ { print "+ "$2}

# Print 2nd field when it does not match a reg.ex. (ending with a vowel)
$2 !~ /[aeiouAEIOU]$/ { print "- "$2}
