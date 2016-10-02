# expr

表达式计算方法

## Usage

* expr1 | expr2

表达式或

* expr2 & expr2

表达式与

* expr1 {=, >, >=, <, <=, !=} expr2

字符比较

* expr1 {+, -} expr2

表达式加减

* expr1 {*, /, %} expr2

表达式乘，除，求模

* expr1 : expr2

正则匹配

 ## 表达式列表
 
 > a=$(expr $a + 1)
 
 > a=$(expr 1 + $a)
 
 > a=$(expr \( $a \) + 1)
 
 > a=$((a + 1))
 
 > expr "//$a" : '.*/\(.*\)'
 
 > "${a##*/}"
 
 > expr \( "X$a" : ".*" \) - 1
 
 > ${#a}


## History

V1: 基础版本

## License

[MIT License](https://opensource.org/licenses/mit-license.html). ©  [Running Lee](mailto:lihui870920@gmail.com)