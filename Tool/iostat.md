# iostat

监控系统输入输出以及CPU使用情况


###选项参数

```
 The options are as follows:

     -?    Display a usage statement and exit.

     -C    Display CPU statistics.  This is on by default, unless -d is specified.

     -c    Repeat the display count times.  If no wait interval is specified, the default is 1 second.

     -d    Display only device statistics.  If this flag is turned on, only device sta-
           tistics will be displayed, unless -C or -U or -T is also specfied to enable
           the display of CPU, load average or TTY statistics.

     -I    Display total statstics for a given time period, rather than average statis-
           tics for each second during that time period.

     -K    In the blocks transferred display (-o), display block count in kilobytes
           rather then the device native block size.

     -n    Display up to devs number of devices.  iostat will display fewer devices if
           there aren't devs devices present.

     -o    Display old-style iostat device statistics.  Sectors per second, transfers per
           second, and miliseconds per seek are displayed.  If -I is specified, total
           blocks/sectors, total transfers, and miliseconds per seek are displayed.

     -T    Display TTY statistics.  This is on by default, unless -d is specified.

     -U    Display system load averages.  This is on by default, unless -d is specified.

     -w    Pause wait seconds between each display.  If no repeat count is specified, the
           default is infinity.
```

###使用



[MIT License](https://opensource.org/licenses/mit-license.html). ©  [Running Lee](mailto:lihui870920@gmail.com)