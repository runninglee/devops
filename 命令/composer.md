# composer

PHP包管理工具

## 参数详解

###### autoload

* classmap 文件夹映射

    自动加载与 vendor 同级的 database 文件夹下的所有文件

    ```php
    "autoload": {
        "classmap": [
          "database"
        ]
      },
    ```

* files 自动加载文件

    自动加载指定文件
    
    ```php
     "autoload": {
       "files": [
         "app/Extensions/helpers.php",
         "app/Extensions/another_helpers.php"
       ]
     }, 
   ```

* psr-4 PSR命名空间映射文件夹

    自动加载命名空间下映射文件夹中的类文件
    
    ```php
     "autoload": {
         "psr-4": {
           "App\\": "app/"
         }
       },
    ```

###### scripts

