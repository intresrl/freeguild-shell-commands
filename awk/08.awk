#! /bin/awk -f

BEGIN { color1 = "\033[0;33m" }
BEGIN { color2 = "\033[0;34m" }
BEGIN { color3 = "\033[0;35m" }
BEGIN { nocolor = "\033[0m" }

# Reg.ex. with character classes
/[[:alpha:]]+[[:punct:]][[:alpha:]]+/ { print color1 "RULE <1> " nocolor $0}

# Dynamic reg.ex.
BEGIN { reg_ex_part = "in" }
$0 ~ reg_ex_part"."reg_ex_part { print color2 "RULE <2> " nocolor $0}

# Case-insensitive matching
toupper($0) ~ / IT / { print color3 "RULE <3> " nocolor $0}

BEGIN { strong =  "\033[1;31m" }
BEGIN { normal =  "\033[0;36m" }
END { print normal "\n" \
            normal "################################################################\n" \
            normal "# Sorry, but " \
            strong "awk" \
            normal " does not support look-ahead or look-behind,   #\n" \
            normal "# since it uses POSIX Extended Regular Expression (ERE).       #\n" \
            normal "################################################################\n" \
            nocolor }