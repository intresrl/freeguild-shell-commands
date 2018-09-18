# SED
Sed (stream editor) is a non-interactive command-line text editor.

A stream editor is used to perform basic text transformations 
 on an input stream (a file or input from a pipeline).

sed works by making only one pass over the input(s).

It is sed's ability to filter text in a pipeline which 
 particularly distinguishes it from other types of editors.
 
## Usage
```bash
sed [OPTION]... {script-only-if-no-other-script} [input-file]...
```
usually used as
```bash
sed SCRIPT INPUTFILE...
```

E.g. the script `'s/hello/world/` replaces all `hello`s in the input with `world`. 
All the following take their input from file `A` and write it to `B`.

```bash
sed 's/hello/world/' A > B
sed 's/hello/world/' < A > B
cat A | sed 's/hello/world/' - > B
```

Some options
```bash
-e script
Add the commands in script to the set of commands to be run 
while processing the input.

-f script-file
Add the commands contained in the file script-file to the set 
of commands to be run while processing the input.

-l N
Specify the default line-wrap length for the l command. 
A length of 0 (zero) means to never wrap long lines. 
If not specified, it is taken to be 70.
```
Without `-e` or `-f` options, sed uses the first non-option parameter
 as the script, and the following non-option parameters as input 
 files. If `-e` or `-f` options are used to specify a script, all 
 non-option parameters are taken as input files. Options `-e` and `-f` 
 can be combined, and can appear multiple times (in which case the 
 final effective script will be concatenation of all the individual
 scripts).

Commands within a script or script-file can be separated by
 semicolons (`;`) or newlines (ASCII 10). 

## Commands
sed commands follow this syntax:

```bash
[addr]X[options]
```
- `X` is a single-letter sed command; 
- `[addr]` is an optional line address. If specified, the command will be executed only on the matched lines; it can be a single line number, a regular expression, or a range of lines;
- `[options]` are used for some sed commands.

### Command list
- `a text`: append text
  - append `banana` after line 1
  ```bash
  sed '1a banana' input
  ```
  - append `^ GOOD` after every line matching reg.ex.
  ```bash
  sed '/lorem/a ^ GOOD' input
  ```
- `c text`: change text
  - replace lines 2 to 5 with text `pineapple` (replace whole block)
  ```bash
  sed '2,5c pineapple' input
  ```
  - replace every third line starting from 1 with text `cherry`
  ```bash
  sed '1~3c cherry' input
  ```
- `d`: delete lines
  - delete line 2
  ```bash
  sed '2d' input
  ```
  - delete lines from 3 to 7
  ```bash
  sed '3,7d' input
  ```
  - delete lines matching reg.ex.
  ```bash
  sed '/[02468]/d' input
  ```
- `i text`: insert text before a line
  - insert `mango` before last line (`$`)
  ```bash
  sed '$i mango' input
  ```
  - insert `kiwi` before each line NOT matching reg.ex.
  ```bash
  sed '/This/!i kiwi' input
  ```
- `q[code]`: exit with given exit code (or 0 if never matched; check with `echo $?`)
  - stop processing and exit with code 33 if a line matches reg.ex.
  ```bash
  sed '/baz/q33' input
  ```
  - stop processing and exit with code 99 after line 66 if present
  ```bash
  sed '66q99' input
  ```
- `s/regexp/replacement/[flags]`: substitute reg.ex.
  - See dedicated session
- `y/src/dst/`: transliterate chars in source-chars with the corresponding in dest-chars.
  - replace all `a`s with `*` and all `o` with `#`
  ```bash
  sed 'y/ao/*#/' input
  ```

### The `s` command 
It's the most important and complex.

Syntax:
```
s/regexp/replacement/flags
```
Attempt to match `regexp` against the pattern space.
If successful, replace that portion matched with `replacement`.
The `replacement` may contain the special character `&` 
 to refer to that portion of the pattern space which matched, 
 and the special escapes `\1` through `\9` to refer to the
  corresponding matching sub-expressions in the regexp.