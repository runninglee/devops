# Sass

CSS预编译文件处理

## 使用方式


**使用```$```加变量即可**

```
$bg-color:#d2d2d2;

body{
    background:$bg-color;
}
```

**使用```&```应用父标签**

```
a {
  font-weight: bold;
  text-decoration: none;
  &:hover { text-decoration: underline; }
  body.firefox & { font-weight: normal; }
}
&表示a标签
```

**使用```@mixin```定义程序块**

```
@mixin navbar-active {
  background: $bg-color-active;
  color: $text-color;
}

在标签中使用@include navbar-active;
```

**使用```@include```引入公共程序块**

```
nav{
    @include navbar-active;
}
```

**使用```@extend```继承扩展程序块**

```
.message {
  border: 1px solid #ccc;
  padding: 10px;
  color: #333;
}

.success {
  @extend .message;
  border-color: green;
}

.error {
  @extend .message;
  border-color: red;
}

.warning {
  @extend .message;
  border-color: yellow;
}
-----------------------------------
.message, .success, .error, .warning {
  border: 1px solid #cccccc;
  padding: 10px;
  color: #333;
}

.success {
  border-color: green;
}

.error {
  border-color: red;
}

.warning {
  border-color: yellow;
}
```

**使用```@mixin```定义含参数程序块**

```
使用#{}包裹变量

@mixin firefox-message($selector) {
  body.firefox #{$selector}:before {
    content: "Hi, Firefox users!";
  }
}
@include firefox-message(".header");
```

**使用```function```使用函数计算程序块**
```
$grid-width: 40px;
$gutter-width: 10px;

@function grid-width($n) {
  @return $n * $grid-width + ($n - 1) * $gutter-width;
}

直接赋值
#sidebar { width: grid-width(5); }
使用默认值
#sidebar { width: grid-width($n: 5); }
```

**使用```颜色色块方法```处理程序块**
```
$linkColor: #08c;
a {
    text-decoration:none;
    color:$linkColor;
    &:hover{
      color:darken($linkColor,10%);
    }
}
------------------------------------
lighten(#cc3, 10%) // #d6d65c
darken(#cc3, 10%)  // #a3a329
grayscale(#cc3)   // #808080
complement(#cc3)  // #33c
```

**使用```使用@if```处理程序块**
```
@if darken($color) > 30% {
　　　　background-color: #000;
　　} @else {
　　　　background-color: #fff;
　　}
```

**使用```使用@for```处理程序块**
```
@for $i from 1 to 3 {
　　　　.item-#{$i} {
　　　　　　border-radis: #{$i}px;
　　　　}
　　}
```

**使用```使用@each```处理程序块**

```
@each $position in header, body, sidebar, footer {
　　　　.#{$position} {
　　　　　　background-image: url("/image/#{$position}.jpg");
　　　　}
　　}
```

## History

## Related

v1: 开发中经常使用的Sass程序块

## License

[MIT License](https://opensource.org/licenses/mit-license.html). © Running Lee