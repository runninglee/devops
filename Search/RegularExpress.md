### 正则表达式

---
##### 原子符

- `.` (dot) - a single character.
- `?` - the preceding character matches 0 or 1 times only.
- `*` - the preceding character matches 0 or more times.
-`+` - the preceding character matches 1 or more times.
- `{n}` - the preceding character matches exactly n times.
- `{n,m}` - the preceding character matches at least n times and not more than m times.
- `[agd]` - the character is one of those included within the square brackets.
- `[^agd]` - the character is not one of those included within the square brackets.
- `[c-f]` - the dash within the square brackets operates as a range. In this case it means either the letters c, d, e or f.
- `()` - allows us to group several characters to behave as one.
- `|` (pipe symbol) - the logical OR operation.
- `^` - matches the beginning of the line.
- `$` - matches the end of the line.
