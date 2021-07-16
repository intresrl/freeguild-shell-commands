# AWK
 From https://en.wikipedia.org/wiki/AWK:
>
> The AWK language is a data-driven scripting language consisting of a set of actions
>  to be taken against streams of textual data for purposes of extracting or transforming text.
> The language extensively uses the string datatype, associative arrays
>  (that is, arrays indexed by key strings), and regular expressions.
>
> When you run awk, you specify an awk program that tells awk what to do.
>  The program consists of a series of rules: each one is a pattern followed by an action.
>  The action is enclosed in braces to separate it from the pattern. Newlines usually separate rules.
>
 
 Some information taken from [GAWK manual](https://www.gnu.org/software/gawk/manual/gawk.html)
> NOTE: If you use Bash as your shell, you should execute the command
> `set +H` before running programs interactively, to disable the C shell-style
> command history, which treats `!` as a special character.


## Inline program (single-quotes are important!)

- read + echo (input from std.in)

```bash
awk '{ print }'
```

- read + echo (input from file)

```bash
awk '{ print }' 10-lines
```

## Program from file
```bash
awk -f 01.awk
```

## Executable
If you `chmod +x` an awk file, on many systems you can run it directly, 
 provided you added the right shebang at the beginning to tell the shell
 what program should be used to interpret the commands.
```bash
#! /bin/awk -f
```

Example
```bash
chmod +x 02.awk
./02.awk
```

## Quoting issues
- Quoted and unquoted expressions can be concatenated simply
  by putting them one after another
- Preceding any single character with a backslash (`\ `) quotes that character
- Single quotes protect everything between the opening and closing quotes. 
  The shell does no interpretation of the quoted text (also, it's impossible to embed a single quote inside single-quoted text)
- Double quotes protect most things between the opening and closing quotes. 
  The shell does at least variable and command substitution on the quoted text.
  
## Examples
See files from `03.awk` onward for more examples.

You can use them as follow:
```bash
awk -f 03.awk 10-lines
awk -f 04.awk 10-lines
ls -ld * | awk -f 05.awk
```
...and so on.

Or:
```bash
chmod +x *.awk
./03.awk 10-lines
./04.awk 10-lines
ls -ld * | ./05.awk
./06.awk 10-lines
./07.awk 10-lines
./08.awk 10-lines
./09.awk 10-lines
seq 1 100 | ./FizzBuzz.awk
```

## Command-line options
#### -F _fs_
 Set field separator (`FS`) variable= to _fs_ 

Example:
```bash
find . -type f | awk -F "/" '{ print $NF }'
``` 
Find all files from current path and print only their names
 (= the last field when separating on `/`).
 
#### -v _var_=_val_
Set variable _var_ to value _val_ before execution.
Variable is available in BEGIN rule. 

Example:
```bash
awk -v suffix="... But that's not the end." '{print $0 suffix}' 10-lines
``` 
Print all lines of the file, appending the given `suffix`.

#### _var_=_val_
Set variable _var_ to value _val_. 

Example:
```bash
awk 'step==1 { print step"."$1 }
     step==2 { print step"."$2}' FS=a step=1 10-lines step=2 10-lines
``` 
Make two passes on given file, the first with `step` set to 1
and the second with `step` set to 2.
The value of `step` is used for pattern matching.

Note that setting `FS` variable is the same as using `-F` option.

## Including other files in a program
File `test1` ...
```bash
BEGIN {print "This is #1"}
```
... can be imported in `test2` as follows.
```bash
@include "test1"
BEGIN {print "This is #2"}
```
