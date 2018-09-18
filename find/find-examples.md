### Examples
Find all empty folders from current directory, and add a `.gitkeep` file to each one
```bash
find . -type d -empty -exec touch {}/.gitkeep \;
```
