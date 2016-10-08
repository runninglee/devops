# cut
显示行中指定的部分，盛出文件中指定的字段

## Options

```
     -b list
             The list specifies byte positions.

     -c list
             The list specifies character positions.

     -d delim
             使用delim替换tab做为字段分隔符

     -f list
             The list specifies fields, separated in the input by the field
             delimiter character (see the -d option.)  Output fields are sepa-
             rated by a single occurrence of the field delimiter character.

     -n      Do not split multi-byte characters.  Characters will only be output
             if at least one byte is selected, and, after a prefix of zero or
             more unselected bytes, the rest of the bytes that form the character
             are selected.

     -s      Suppress lines with no field delimiter characters.  Unless speci-
             fied, lines with no delimiters are passed through unmodified.
```


## History


## License

[MIT License](https://opensource.org/licenses/mit-license.html). ©  [Running Lee](mailto:lihui870920@gmail.com)