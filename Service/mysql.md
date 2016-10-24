# MySQL优化策略

## 不良症状

* MySQL进程一直负载很高，持续不下

## 检查方案

修改wait_timeout值，释放MySQL进程,解决MySQL进程CPU过高问题；

```
# 先查看一下MySQL的wait_timeout
$ mysql> show global variables like '%timeout%';
------------------------------------------------
# 修改my.cnf,下面两个值同时修改方可生效
wait_timeout=120
interactive_timeout=120
# 重启MySQL
service mysqld restart
```

查找数据库表索引问题造成的MySQL进程负载过高

```
# 查看MySQL进程列表
$ mysql> show full processlist;
------------------------------------------------
# 根据列出来的问题，优化程序索引，优化查询方式
```

##Explain检验SQL状态
###id (SQL执行顺序)
```
select执行的顺序
```
###select_type(查询类型)
```
A: simple:简单的select
B: primary:外层查询select
C: union : select之后使用union查询( 第二层)
D: dependent union:union语句中的第二个select，依赖于外部子查询
E: subquery: 子查询中的第一个 select
F: dependent subquery: 子查询中的第一个 subquery依赖于外部的子查询
G: derived: 派生表 select（from子句中的子查询）
```

#####table(查询数据表)
```
查询使用表
```
####type(查询链接类型，最可怕的是all,index)
```
A：system:表只有一行记录（等于系统表）
B：const:表中最多只有一行匹配的记录，它在查询一开始的时候就会被读取出来；const 用于在和 primary key 或unique 索引中有固定值比较的情形
C：eq_ref:从该表中会有一行记录被读取出来以和从前一个表中读取出来的记录做联合；与const类型不同的是，这是最好的连接类型。它用在索引所有部 分都用于做连接并且这个索引是一个primary key 或 unique 类型；
D：该表中所有符合检索值的记录都会被取出来和从上一个表中取出来的记录作联合。ref用于连接程序使用键的最左前缀或者是该键不是 primary key 或 unique索引（换句话说，就是连接程序无法根据键值只取得一条记录）的情况
E：ref_or_null: 这种连接类型类似 ref，不同的是mysql会在检索的时候额外的搜索包含null 值的记录。这种连接类型的优化是从mysql4.1.1开始的，它经常用于子查询
F：unique_subquery: 这种类型用例如一下形式的 in 子查询来替换 ref
G：unique_subquery: 只是用来完全替换子查询的索引查找函数效率更高了
H：index_subquery: 这种连接类型类似 unique_subquery。它用子查询来代替in，不过它用于在子查询中没有唯一索引的情况下
I：range: 只有在给定范围的记录才会被取出来，利用索引来取得一条记录。key字段表示使用了哪个索引。key_len字段包括了使 用的键的最长部分。这种类型时 ref 字段值是 null。range用于将某个字段和一个定植用以下任何操作符比较时 =, <>, >,>=, <, <=, is null, <=>, between, 或 in；
J：index: 连接类型跟 all 一样，不同的是它只扫描索引树。它通常会比 all快点，因为索引文件通常比数据文件小。mysql在查询的字段知识单独的索引的一部分的情况下使用这种连接类型。
K：all: 将对该表做全部扫描以和从前一个表中取得的记录作联合。这时候如果第一个表没有被标识为const的话就不大好了，在其他情况下通常是非常糟糕的。正常地，可以通过增加索引使得能从表中更快的取得记录以避免all。
```
####possible_keys(可能使用键)
```
指 mysql在搜索表记录时可能使用哪个索引
```
####key(本次查询使用的索引)
```
key字段显示了mysql实际上要用的索引。当没有任何索引被用到的时候，这个字段的值就是null。想要让mysql强行使用或者忽略在 possible_keys字段中的索引列表，可以在查询语句中使用关键字force index, use index,或 ignore index
```
####key_len(索引长度)
```
key_len 字段显示了mysql使用索引的长度。当 key 字段的值为 null时，索引的长度就是 null。注意，key_len的值可以告诉你在联合索引中mysql会真正使用了哪些索引。
```
####ref(关联字段)
```
ref 字段显示了哪些字段或者常量被用来和 key配合从表中查询记录出来
```
####rows(查询的条数)
```
显示了mysql认为在查询中应该检索的记录数
```
####extra(本次查询的具体状态)
```
A:  distinct: mysql当找到当前记录的匹配联合结果的第一条记录之后，就不再搜索其他记录了
B:  not exists: mysql在查询时做一个 left join优化时，当它在当前表中找到了和前一条记录符合left join条件后，就不再搜索更多的记录了
C:  using filesort: mysql需要额外的做一遍从而以排好的顺序取得记录。排序程序根据连接的类型遍历所有的记录，并且将所有符合 where条件的记录的要排序的键和指向记录的指针存储起来。这些键已经排完序了，对应的记录也会按照排好的顺序取出来。
D:  using index: 字段的信息直接从索引树中的信息取得，而不再去扫描实际的记录。这种策略用于查询时的字段是一个独立索引的一部分
E:  using temporary: mysql需要创建临时表存储结果以完成查询。这种情况通常发生在查询时包含了groupby 和 order by 子句，它以不同的方式列出了各个字段
F:  using where: where子句将用来限制哪些记录匹配了下一个表或者发送给客户端。除非你特别地想要取得或者检查表种的所有记录，否则的话当查询的extra 字段值不是 using where 并且表连接类型是 all 或 index时可能表示有问题。如果你想要让查询尽可能的快，那么就应该注意 extra 字段的值为usingfilesort 和 using temporary 的情况。
```



## 优化方案


[MIT License](https://opensource.org/licenses/mit-license.html). ©  [Running Lee](mailto:lihui870920@gmail.com)