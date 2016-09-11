### Regular Expressions

---

**Basic Metacharacters**

```
- .    (dot or fullstop) Any character.
- [ ]  Range. Match any of these characters.
- [^ ] Range. Match any character which is not one of these.
- \    (backslash) Escape. Remove or add special meaning to a character.
```

**Multipliers**

```
*      Match zero or more times.
+      Match one or more times.
?      Match zero or one times.
{x}    Match exactly x times.
{x,y}  Match between x and y times.
{x,}   Match at least x times.
```

**Shorthand Character Classes**

```
\s     Anything which is considered whitespace.
\S     Anything which is not considered whitespace.
\d     A digit (ie. 0 - 9)
\D     Anything which is not a digit.
\w     Anything which is considered a word character.
\W     Anything which is not considered a word character.

```

**Non printable characters**

```
\t    Tab
\r    Carriage return
\n    Newline (or line feed)

```

**Anchors and Word Boundaries**

```
^     The beginning of the line.
$     The end of the line.
\<    The beginning of a word.
\>    The end of a word.
\b    The beginning or end of a word.

```

**Grouping and backreferences**

~~ May be used anywhere in any path ~~

```
( )            Create a grouping.
\x (x = digit) Match what was matched in the corresponding grouping.

```

**Alternation**

```
|   Match what is on the left, or, what is on the right of the pipe symbol.

```

**Lookahead and Lookbehind**

```
(?=x)   A positive lookahead.

(?!x)   A negative lookahead.

(?<=x)  A positive lookbehind.

(?<!x)  A negative lookbehind.

```


[Regular Expressions - Cheet Sheet](http://ryanstutorials.net/regular-expressions-tutorial/regular-expressions-cheat-sheet.php)