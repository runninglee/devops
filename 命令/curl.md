# curl

curl是一个服务之间的传输工具，支持DICT, FILE, FTP, FTPS, GOPHER, HTTP, HTTPS, IMAP, 
IMAPS,LDAP,  LDAPS,  POP3, POP3S, RTMP, RTSP, SCP, SFTP, SMB, SMBS, SMTP, SMTPS,
TELNET and TFTP 端口协议

## 使用参数

```
   -o, --output <file>
          Write output to <file> instead of stdout. If you are using {} or []
          to fetch multiple documents, you can use '#' followed by  a  number
          in  the  <file>  specifier. That variable will be replaced with the
          current string for the URL being fetched. Like in:

            curl http://{one,two}.site.com -o "file_#1.txt"

          or use several variables like:

            curl http://{site,host}.host[1-5].com -o "#1_#2"

          You may use this option as many times as the  number  of  URLs  you
          have.

          See  also  the --create-dirs option to create the local directories
          dynamically. Specifying the output as  '-'  (a  single  dash)  will
          force the output to be done to stdout.

   -O, --remote-name
          Write  output  to  a  local file named like the remote file we get.
          (Only the file part of the remote file is used,  the  path  is  cut
          off.)

          The  remote file name to use for saving is extracted from the given
          URL, nothing else.

          Consequentially, the file will be  saved  in  the  current  working
          directory.  If  you  want  the file saved in a different directory,
          make sure you change current working directory  before  you  invoke
          curl with the -O, --remote-name flag!

          There  is  no  URL decoding done on the file name. If it has %20 or
          other URL encoded parts of the name, they will end up as-is as file
          name.

          You  may  use  this  option as many times as the number of URLs you
          have.

   --oauth2-bearer
          (IMAP, POP3, SMTP) Specify the Bearer Token for  OAUTH  2.0  server
          authentication.  The  Bearer  Token is used in conjunction with the
          user name which can be specified as part of the --url or -u, --user
          options.

          The Bearer Token and user name are formatted according to RFC 6750.

          If this option is used several times, the last one will be used.

   --proxy-header <header>
          (HTTP) Extra header to include in the request when sending HTTP  to
          a  proxy.  You may specify any number of extra headers. This is the
          equivalent option to -H, --header but is  for  proxy  communication
          only  like in CONNECT requests when you want a separate header sent
          to the proxy to what is sent to the actual remote host.

          curl will make sure that each header you add/replace is  sent  with
          the  proper  end-of-line  marker, you should thus not add that as a
          part of the  header  content:  do  not  add  newlines  or  carriage
          returns, they will only mess things up for you.

          Headers specified with this option will not be included in requests
          that curl knows will not be sent to a proxy.

          This option can be used multiple times to add/replace/remove multi-
          ple headers.

          (Added in 7.37.0)

   -p, --proxytunnel
          When  an  HTTP  proxy is used (-x, --proxy), this option will cause
          non-HTTP protocols to attempt to tunnel through the  proxy  instead
          of  merely using it to do HTTP-like operations. The tunnel approach
          is made with the HTTP proxy CONNECT request and requires  that  the
          proxy allows direct connect to the remote port number curl wants to
          tunnel through to.

   -P, --ftp-port <address>
          (FTP) Reverses the default initiator/listener roles when connecting
          with FTP. This switch makes curl use active mode. In practice, curl
          then tells the server to connect back  to  the  client's  specified
          address and port, while passive mode asks the server to setup an IP
          address and port for it to connect to. <address> should be one of:

          interface
                 i.e "eth0" to specify which interface's IP address you  want
                 to use (Unix only)

          IP address
                 i.e "192.168.10.1" to specify the exact IP address

          host name
                 i.e "my.host.domain" to specify the machine

          -      make  curl pick the same IP address that is already used for
                 the control connection

          If this option is used several times, the last one  will  be  used.
          Disable the use of PORT with --ftp-pasv. Disable the attempt to use
          the EPRT command instead of PORT by using --disable-eprt.  EPRT  is
          really PORT++.

          Starting in 7.19.5, you can append ":[start]-[end]" to the right of
          the address, to tell curl what TCP port range to  use.  That  means
          you specify a port range, from a lower to a higher number. A single
          number works as well, but do note that it  increases  the  risk  of
          failure since the port may not be available.

   --pass <phrase>
          (SSL/SSH) Passphrase for the private key

          If this option is used several times, the last one will be used.

   --path-as-is
          Tell  curl  to not handle sequences of /../ or /./ in the given URL
          path. Normally curl will squash or merge them  according  to  stan-
          dards but with this option set you tell it not to do that.

          (Added in 7.42.0)

   --post301
          (HTTP)  Tells  curl to respect RFC 2616/10.3.2 and not convert POST
          requests into GET requests when following a  301  redirection.  The
          non-RFC  behaviour  is ubiquitous in web browsers, so curl does the
          conversion by default to maintain consistency.  However,  a  server
          may  require a POST to remain a POST after such a redirection. This
          option is meaningful only  when  using  -L,  --location  (Added  in
          7.17.1)

   --post302
          (HTTP)  Tells  curl to respect RFC 2616/10.3.2 and not convert POST
          requests into GET requests when following a  302  redirection.  The
          non-RFC  behaviour  is ubiquitous in web browsers, so curl does the
          conversion by default to maintain consistency.  However,  a  server
          may  require a POST to remain a POST after such a redirection. This
          option is meaningful only  when  using  -L,  --location  (Added  in
          7.19.1)

   --post303
          (HTTP)  Tells  curl to respect RFC 2616/10.3.2 and not convert POST
          requests into GET requests when following a  303  redirection.  The
          non-RFC  behaviour  is ubiquitous in web browsers, so curl does the
          conversion by default to maintain consistency.  However,  a  server
          may  require a POST to remain a POST after such a redirection. This
          option is meaningful only  when  using  -L,  --location  (Added  in
          7.26.0)

   --proto <protocols>
          Tells  curl  to use the listed protocols for its initial retrieval.
          Protocols are evaluated left to right, are comma separated, and are
          each  a protocol name or 'all', optionally prefixed by zero or more
          modifiers. Available modifiers are:

          +  Permit this protocol in addition to protocols already  permitted
             (this is the default if no modifier is used).

          -  Deny  this  protocol,  removing  it  from  the list of protocols
             already permitted.

          =  Permit only this protocol (ignoring the list already permitted),
             though  subject  to  later modification by subsequent entries in
             the comma separated list.

          For example:

          --proto -ftps  uses the default protocols, but disables ftps

          --proto -all,https,+http
                         only enables http and https

          --proto =http,https
                         also only enables http and https

          Unknown protocols produce a warning. This allows scripts to  safely
          rely  on  being  able  to  disable potentially dangerous protocols,
          without relying upon support for that  protocol  being  built  into
          curl to avoid an error.

          This option can be used multiple times, in which case the effect is
          the same as concatenating the protocols into one  instance  of  the
          option.

          (Added in 7.20.2)

   --proto-redir <protocols>
          Tells  curl  to  use  the  listed  protocols  after a redirect. See
          --proto for how protocols are represented.

          (Added in 7.20.2)

   --proxy-anyauth
          Tells curl to pick a suitable authentication method  when  communi-
          cating   with   the   given   proxy.  This  might  cause  an  extra
          request/response round-trip. (Added in 7.13.2)

   --proxy-basic
          Tells curl to use HTTP Basic authentication when communicating with
          the  given proxy. Use --basic for enabling HTTP Basic with a remote
          host. Basic is the default authentication  method  curl  uses  with
          proxies.

   --proxy-digest
          Tells  curl  to  use  HTTP Digest authentication when communicating
          with the given proxy. Use --digest for enabling HTTP Digest with  a
          remote host.

   --proxy-negotiate
          Tells  curl to use HTTP Negotiate (SPNEGO) authentication when com-
          municating with the given proxy. Use --negotiate for enabling  HTTP
          Negotiate (SPNEGO) with a remote host. (Added in 7.17.1)

--proxy-ntlm
      Tells  curl to use HTTP NTLM authentication when communicating with
      the given proxy. Use --ntlm for enabling NTLM with a remote host.

--proxy-service-name <servicename>
      This option allows you to change the service name for proxy negoti-
      ation.

      Examples:  --proxy-negotiate  proxy-name --proxy-service-name sockd
      would use sockd/proxy-name.  (Added in 7.43.0).

   --proxy1.0 <proxyhost[:port]>
          Use the specified HTTP 1.0 proxy. If the port number is not  speci-
          fied, it is assumed at port 1080.

          The  only  difference  between  this and the HTTP proxy option (-x,
          --proxy), is that attempts to use CONNECT through  the  proxy  will
          specify an HTTP 1.0 protocol instead of the default HTTP 1.1.

   --pubkey <key>
          (SSH)  Public  key file name. Allows you to provide your public key
          in this separate file.

          If this option is used several times, the last one will be used.

          (As of 7.39.0, curl attempts to automatically  extract  the  public
          key  from the private key file, so passing this option is generally
          not required. Note that this public key extraction requires libcurl
          to  be  linked  against  a  copy of libssh2 1.2.8 or higher that is
          itself linked against OpenSSL.)

   -q     If used as the first parameter on the command line, the curlrc con-
          fig  file  will  not  be  read  and  used. See the -K, --config for
          details on the default config file search path.

   -Q, --quote <command>
          (FTP/SFTP) Send an arbitrary command to  the  remote  FTP  or  SFTP
          server.  Quote  commands  are  sent BEFORE the transfer takes place
          (just after the initial PWD command  in  an  FTP  transfer,  to  be
          exact).  To  make  commands take place after a successful transfer,
          prefix them with a dash '-'.  To make commands be sent  after  curl
          has  changed  the  working directory, just before the transfer com-
          mand(s), prefix the command with a '+' (this is only supported  for
          FTP). You may specify any number of commands. If the server returns
          failure for one of the  commands,  the  entire  operation  will  be
          aborted.  You  must  send syntactically correct FTP commands as RFC
          959 defines to FTP servers, or one of the commands listed below  to
          SFTP  servers.  This option can be used multiple times. When speak-
          ing to an FTP server, prefix the command with an  asterisk  (*)  to
          make  curl  continue  even  if the command fails as by default curl
          will stop at first failure.

          SFTP is a binary protocol. Unlike for  FTP,  curl  interprets  SFTP
          quote  commands  itself  before  sending  them to the server.  File
          names may be quoted shell-style to embed spaces or special  charac-
          ters.  Following is the list of all supported SFTP quote commands:

          chgrp group file
                 The chgrp command sets the group ID of the file named by the
                 file operand to the group ID specified by the group operand.
                 The group operand is a decimal integer group ID.

          chmod mode file
                 The  chmod command modifies the file mode bits of the speci-
                 fied file. The mode operand is an octal integer mode number.

          chown user file
                 The  chown  command  sets the owner of the file named by the
                 file operand to the user ID specified by the  user  operand.
                 The user operand is a decimal integer user ID.

          ln source_file target_file
                 The  ln  and  symlink commands create a symbolic link at the
                 target_file location pointing to the source_file location.

          mkdir directory_name
                 The mkdir command creates the directory named by the  direc-
                 tory_name operand.

          pwd    The pwd command returns the absolute pathname of the current
                 working directory.

          rename source target
                 The rename command renames the file or  directory  named  by
                 the source operand to the destination path named by the tar-
                 get operand.

          rm file
                 The rm command removes the file specified by the file  oper-
                 and.

          rmdir directory
                 The  rmdir  command removes the directory entry specified by
                 the directory operand, provided it is empty.

          symlink source_file target_file
                 See ln.

   -r, --range <range>
          (HTTP/FTP/SFTP/FILE) Retrieve a byte range (i.e a partial document)
          from  a HTTP/1.1, FTP or SFTP server or a local FILE. Ranges can be
          specified in a number of ways.

          0-499     specifies the first 500 bytes

          500-999   specifies the second 500 bytes

          -500      specifies the last 500 bytes

          9500-     specifies the bytes from offset 9500 and forward

          0-0,-1    specifies the first and last byte only(*)(H)

          500-700,600-799
                    specifies 300 bytes from offset 500(H)

          100-199,500-599
                    specifies two separate 100-byte ranges(*)(H)

          (*) = NOTE that this will cause the server to reply with  a  multi-
          part response!

          Only  digit  characters  (0-9)  are valid in the 'start' and 'stop'
          fields of the 'start-stop' range syntax. If a  non-digit  character
          is  given  in the range, the server's response will be unspecified,
          depending on the server's configuration.

          You should also be aware that many HTTP/1.1  servers  do  not  have
          this  feature  enabled,  so  that  when you attempt to get a range,
          you'll instead get the whole document.

          FTP and SFTP range downloads only support the  simple  'start-stop'
          syntax  (optionally  with  one  of  the  numbers  omitted). FTP use
          depends on the extended FTP command SIZE.

          If this option is used several times, the last one will be used.

   -R, --remote-time
          When used, this will make curl attempt to figure out the  timestamp
          of  the  remote  file, and if that is available make the local file
          get that same timestamp.

   --random-file <file>
          (SSL) Specify the path name to file containing what will be consid-
          ered as random data. The data is used to seed the random engine for
          SSL connections.  See also the --egd-file option.

   --raw  (HTTP) When used, it disables all internal HTTP decoding of content
          or  transfer  encodings and instead makes them passed on unaltered,
          raw. (Added in 7.16.2)

   --remote-name-all
          This option changes the default action for all  given  URLs  to  be
          dealt  with  as  if -O, --remote-name were used for each one. So if
          you want to disable that for a specific URL after --remote-name-all
          has  been  used, you must use "-o -" or --no-remote-name. (Added in
          7.19.0)

   --resolve <host:port:address>
          Provide a custom address for a specific host and port  pair.  Using
          this, you can make the curl requests(s) use a specified address and
          prevent the otherwise normally resolved address to  be  used.  Con-
          sider  it  a sort of /etc/hosts alternative provided on the command
          line. The port number should be the number used  for  the  specific
          protocol  the  host  will  be  used  for. It means you need several
          entries if you want to provide address for the same host  but  dif-
          ferent ports.

          This  option  can  be  used  many  times  to add many host names to
          resolve.

          (Added in 7.21.3)

   --retry <num>
          If a transient error is returned  when  curl  tries  to  perform  a
          transfer, it will retry this number of times before giving up. Set-
          ting the number to 0  makes  curl  do  no  retries  (which  is  the
          default).  Transient  error  means  either:  a  timeout, an FTP 4xx
          response code or an HTTP 5xx response code.

          When curl is about to retry a transfer, it will first wait one sec-
          ond and then for all forthcoming retries it will double the waiting
          time until it reaches 10 minutes  which  then  will  be  the  delay
          between  the  rest of the retries.  By using --retry-delay you dis-
          able this exponential backoff algorithm. See also  --retry-max-time
          to limit the total time allowed for retries. (Added in 7.12.3)

          If this option is used several times, the last one will be used.

   --retry-delay <seconds>
          Make curl sleep this amount of time before each retry when a trans-
          fer has failed with a transient error (it changes the default back-
          off  time algorithm between retries). This option is only interest-
          ing if --retry is also used. Setting this delay to zero  will  make
          curl use the default backoff time.  (Added in 7.12.3)

          If this option is used several times, the last one will be used.

   --retry-max-time <seconds>
          The retry timer is reset before the first transfer attempt. Retries
          will be done as usual (see --retry) as long  as  the  timer  hasn't
          reached  this  given limit. Notice that if the timer hasn't reached
          the limit, the request will be made and while  performing,  it  may
          take  longer  than  this  given  time  period.  To  limit  a single
          request's maximum time, use -m, --max-time.   Set  this  option  to
          zero to not timeout retries. (Added in 7.12.3)

          If this option is used several times, the last one will be used.

   -s, --silent
          Silent  or quiet mode. Don't show progress meter or error messages.
          Makes Curl mute. It will still output the data you ask for,  poten-
          tially even to the terminal/stdout unless you redirect it.

   --sasl-ir
          Enable initial response in SASL authentication.  (Added in 7.31.0)

   --service-name <servicename>
          This option allows you to change the service name for SPNEGO.

          Examples:  --negotiate --service-name sockd would use sockd/server-
          name.  (Added in 7.43.0).

   -S, --show-error
          When used with -s it makes curl show an error message if it  fails.

   --ssl  (FTP,  POP3,  IMAP,  SMTP)  Try  to use SSL/TLS for the connection.
          Reverts to a non-secure connection if the  server  doesn't  support
          SSL/TLS.   See  also --ftp-ssl-control and --ssl-reqd for different
          levels of encryption required. (Added in 7.20.0)

          This option was formerly known as --ftp-ssl (Added in 7.11.0). That
          option  name can still be used but will be removed in a future ver-
          sion.

   --ssl-reqd
          (FTP, POP3, IMAP, SMTP) Require SSL/TLS for the connection.  Termi-
          nates  the connection if the server doesn't support SSL/TLS. (Added
          in 7.20.0)

          This option was formerly known as --ftp-ssl-reqd (added in 7.15.5).
          That  option name can still be used but will be removed in a future
          version.

   --ssl-allow-beast
          (SSL) This option tells curl to not work around a security flaw  in
          the SSL3 and TLS1.0 protocols known as BEAST.  If this option isn't
          used, the SSL layer may use workarounds known to  cause  interoper-
          ability problems with some older SSL implementations. WARNING: this
          option loosens the SSL security, and by using this flag you ask for
          exactly that.  (Added in 7.25.0)

   --socks4 <host[:port]>
          Use  the  specified  SOCKS4 proxy. If the port number is not speci-
          fied, it is assumed at port 1080. (Added in 7.15.2)

          This option overrides any previous use of -x, --proxy, as they  are
          mutually exclusive.

          Since  7.21.7,  this  option is superfluous since you can specify a
          socks4 proxy with -x, --proxy using a socks4:// protocol prefix.

          If this option is used several times, the last one will be used.

   --socks4a <host[:port]>
          Use the specified SOCKS4a proxy. If the port number is  not  speci-
          fied, it is assumed at port 1080. (Added in 7.18.0)

          This  option overrides any previous use of -x, --proxy, as they are
          mutually exclusive.

          Since 7.21.7, this option is superfluous since you  can  specify  a
          socks4a  proxy with -x, --proxy using a socks4a:// protocol prefix.

          If this option is used several times, the last one will be used.

   --socks5-hostname <host[:port]>
          Use the specified SOCKS5 proxy (and let the proxy resolve the  host
          name).  If  the port number is not specified, it is assumed at port
          1080. (Added in 7.18.0)

          This option overrides any previous use of -x, --proxy, as they  are
          mutually exclusive.

          Since  7.21.7,  this  option is superfluous since you can specify a
          socks5 hostname proxy with -x, --proxy using a socks5h://  protocol
          prefix.

          If  this  option  is used several times, the last one will be used.
          (This option was previously wrongly documented and used as  --socks
          without the number appended.)

   --socks5 <host[:port]>
          Use the specified SOCKS5 proxy - but resolve the host name locally.
          If the port number is not specified, it is assumed at port 1080.

          This option overrides any previous use of -x, --proxy, as they  are
          mutually exclusive.

          Since  7.21.7,  this  option is superfluous since you can specify a
          socks5 proxy with -x, --proxy using a socks5:// protocol prefix.

          If this option is used several times, the last one  will  be  used.
          (This  option was previously wrongly documented and used as --socks
          without the number appended.)

          This option (as well as --socks4) does not work with IPV6, FTPS  or
          LDAP.

   --socks5-gssapi-service <servicename>
          The  default  service  name for a socks server is rcmd/server-fqdn.
          This option allows you to change it.

          Examples: --socks5 proxy-name --socks5-gssapi-service  sockd  would
          use  sockd/proxy-name  --socks5  proxy-name --socks5-gssapi-service
          sockd/real-name would  use  sockd/real-name  for  cases  where  the
          proxy-name does not match the principal name.  (Added in 7.19.4).

   --socks5-gssapi-nec
          As part of the GSS-API negotiation a protection mode is negotiated.
          RFC 1961 says in section 4.3/4.4 it should be  protected,  but  the
          NEC reference implementation does not.  The option --socks5-gssapi-
          nec allows the unprotected exchange of the protection mode negotia-
          tion. (Added in 7.19.4).

   --stderr <file>
          Redirect all writes to stderr to the specified file instead. If the
          file name is a plain '-', it is instead written to stdout.

          If this option is used several times, the last one will be used.

   -t, --telnet-option <OPT=val>
          Pass options to the telnet protocol. Supported options are:

          TTYPE=<term> Sets the terminal type.

          XDISPLOC=<X display> Sets the X display location.

          NEW_ENV=<var,val> Sets an environment variable.

   -T, --upload-file <file>
          This transfers the specified local file to the remote URL. If there
          is  no  file  part in the specified URL, Curl will append the local
          file name. NOTE that you must use a trailing / on the  last  direc-
          tory  to  really  prove  to Curl that there is no file name or curl
          will think that your last directory name is the remote file name to
          use.  That  will most likely cause the upload operation to fail. If
          this is used on an HTTP(S) server, the PUT command will be used.

          Use the file name "-" (a single dash) to use  stdin  instead  of  a
          given  file.   Alternately, the file name "." (a single period) may
          be specified instead of "-" to use stdin in  non-blocking  mode  to
          allow reading server output while stdin is being uploaded.

          You  can specify one -T for each URL on the command line. Each -T +
          URL pair specifies what to upload and to where. curl also  supports
          "globbing" of the -T argument, meaning that you can upload multiple
          files to a single URL by using the same  URL  globbing  style  sup-
          ported in the URL, like this:

          curl -T "{file1,file2}" http://www.uploadtothissite.com

          or even

          curl -T "img[1-1000].png" ftp://ftp.picturemania.com/upload/

   --tcp-nodelay
          Turn  on  the  TCP_NODELAY  option. See the curl_easy_setopt(3) man
          page for details about this option. (Added in 7.11.2)

   --tftp-blksize <value>
          (TFTP) Set TFTP BLKSIZE option (must be >512). This  is  the  block
          size  that curl will try to use when transferring data to or from a
          TFTP server. By default 512 bytes will be used.

          If this option is used several times, the last one will be used.

          (Added in 7.20.0)

   --tlsauthtype <authtype>
          Set TLS authentication type. Currently, the only  supported  option
          is  "SRP",  for  TLS-SRP (RFC 5054). If --tlsuser and --tlspassword
          are specified but --tlsauthtype is not, then this  option  defaults
          to "SRP".  (Added in 7.21.4)

   --tlspassword <password>
          Set  password  for use with the TLS authentication method specified
          with --tlsauthtype. Requires that --tlsuser also be set.  (Added in
          7.21.4)

   --tlsuser <user>
          Set  username  for use with the TLS authentication method specified
          with  --tlsauthtype.  Requires  that  --tlspassword  also  be  set.
          (Added in 7.21.4)

   --tlsv1.0
          (SSL)  Forces  curl  to use TLS version 1.0 when negotiating with a
          remote TLS server.  (Added in 7.34.0)

   --tlsv1.1
          (SSL) Forces curl to use TLS version 1.1 when  negotiating  with  a
          remote TLS server.  (Added in 7.34.0)

   --tlsv1.2
          (SSL)  Forces  curl  to use TLS version 1.2 when negotiating with a
          remote TLS server.  (Added in 7.34.0)

   --tr-encoding
          (HTTP) Request a compressed Transfer-Encoding response using one of
          the algorithms curl supports, and uncompress the data while receiv-
          ing it.

          (Added in 7.21.6)

   --trace <file>
          Enables a full trace  dump  of  all  incoming  and  outgoing  data,
          including  descriptive  information,  to the given output file. Use
          "-" as filename to have the output sent to stdout.

          This option overrides previous uses of -v,  --verbose  or  --trace-
          ascii.

          If this option is used several times, the last one will be used.

   --trace-ascii <file>
          Enables  a  full  trace  dump  of  all  incoming and outgoing data,
          including descriptive information, to the given  output  file.  Use
          "-" as filename to have the output sent to stdout.

          This  is  very  similar to --trace, but leaves out the hex part and
          only shows the ASCII part of the dump. It makes smaller output that
          might be easier to read for untrained humans.

          This option overrides previous uses of -v, --verbose or --trace.

          If this option is used several times, the last one will be used.

   --trace-time
          Prepends  a time stamp to each trace or verbose line that curl dis-
          plays.  (Added in 7.14.0)

   --unix-socket <path>
          (HTTP) Connect through this Unix domain socket,  instead  of  using
          the network. (Added in 7.40.0)

   -u, --user <user:password>
          Specify  the  user  name and password to use for server authentica-
          tion. Overrides -n, --netrc and --netrc-optional.

          If you simply specify the user name, curl will prompt for  a  pass-
          word.

          The  user name and passwords are split up on the first colon, which
          makes it impossible to use a colon  in  the  user  name  with  this
          option. The password can, still.

          When  using  Kerberos  V5  with  a  Windows based server you should
          include the Windows domain name in the user name, in order for  the
          server  to successfully obtain a Kerberos Ticket. If you don't then
          the initial authentication handshake may fail.

          When using NTLM, the user name can be specified simply as the  user
          name, without the domain, if there is a single domain and forest in
          your setup for example.

          To specify the domain name use either Down-Level Logon Name or  UPN
          (User  Principal  Name)  formats.  For  example,  EXAMPLE\user  and
          user@example.com respectively.

          If you use a Windows SSPI-enabled curl binary and perform  Kerberos
          V5, Negotiate, NTLM or Digest authentication then you can tell curl
          to select the user name and password from your environment by spec-
          ifying a single colon with this option: "-u :".

          If this option is used several times, the last one will be used.

   -U, --proxy-user <user:password>
          Specify the user name and password to use for proxy authentication.

          If you use a Windows SSPI-enabled curl binary and do either Negoti-
          ate  or  NTLM  authentication  then you can tell curl to select the
          user name and password from your environment by specifying a single
          colon with this option: "-U :".

          If this option is used several times, the last one will be used.

   --url <URL>
          Specify  a  URL to fetch. This option is mostly handy when you want
          to specify URL(s) in a config file.

          This option may be used any number of times. To control where  this
          URL  is  written,  use  the  -o,  --output or the -O, --remote-name
          options.

   -v, --verbose
          Be more verbose/talkative during the operation. Useful  for  debug-
          ging  and  seeing what's going on "under the hood". A line starting
          with '>' means "header data" sent by curl, '<' means "header  data"
          received  by curl that is hidden in normal cases, and a line start-
          ing with '*' means additional info provided by curl.

          Note that if  you  only  want  HTTP  headers  in  the  output,  -i,
          --include might be the option you're looking for.

          If  you  think  this  option still doesn't give you enough details,
          consider using --trace or --trace-ascii instead.

          This option overrides previous uses of --trace-ascii or --trace.

          Use -s, --silent to make curl quiet.

   -w, --write-out <format>
          Make curl display information on stdout after a completed transfer.
          The  format  is a string that may contain plain text mixed with any
          number of variables. The format  can  be  specified  as  a  literal
          "string",  or  you  can  have curl read the format from a file with
          "@filename" and to tell curl to read  the  format  from  stdin  you
          write "@-".

          The  variables  present in the output format will be substituted by
          the value or text that curl thinks fit,  as  described  below.  All
          variables  are specified as %{variable_name} and to output a normal
          % you just write them as %%. You can output a newline by using  \n,
          a carriage return with \r and a tab space with \t.

          NOTE:  The  %-symbol  is a special symbol in the win32-environment,
          where all occurrences of % must be doubled when using this  option.

          The variables available are:

          content_type   The Content-Type of the requested document, if there
                         was any.

          filename_effective
                         The ultimate filename that curl writes out to.  This
                         is  only  meaningful  if  curl is told to write to a
                         file with the --remote-name or --output option. It's
                         most useful in combination with the --remote-header-
                         name option. (Added in 7.25.1)

          ftp_entry_path The initial path curl ended up in when logging on to
                         the remote FTP server. (Added in 7.15.4)

          http_code      The  numerical  response  code that was found in the
                         last retrieved HTTP(S) or FTP(s) transfer. In 7.18.2
                         the  alias  response_code was added to show the same
                         info.

          http_connect   The numerical  code  that  was  found  in  the  last
                         response  (from  a proxy) to a curl CONNECT request.
                         (Added in 7.12.4)

          local_ip       The IP address of the local end of the most recently
                         done  connection - can be either IPv4 or IPv6 (Added
                         in 7.29.0)

          local_port     The local port number of the most recently done con-
                         nection (Added in 7.29.0)

          num_connects   Number  of new connects made in the recent transfer.
                         (Added in 7.12.3)

          num_redirects  Number  of  redirects  that  were  followed  in  the
                         request. (Added in 7.12.3)

          redirect_url   When  an  HTTP request was made without -L to follow
                         redirects, this variable will show the actual URL  a
                         redirect would take you to. (Added in 7.18.2)

          remote_ip      The remote IP address of the most recently done con-
                         nection - can be  either  IPv4  or  IPv6  (Added  in
                         7.29.0)

          remote_port    The  remote  port  number  of the most recently done
                         connection (Added in 7.29.0)

          size_download  The total amount of bytes that were downloaded.

          size_header    The total amount of bytes of the downloaded headers.

          size_request   The total amount of bytes that were sent in the HTTP
                         request.

          size_upload    The total amount of bytes that were uploaded.

          speed_download The average download speed that  curl  measured  for
                         the complete download. Bytes per second.

          speed_upload   The  average upload speed that curl measured for the
                         complete upload. Bytes per second.

          ssl_verify_result
                         The result of the SSL peer certificate  verification
                         that  was  requested.  0  means the verification was
                         successful. (Added in 7.19.0)

          time_appconnect
                         The time, in seconds, it took from the  start  until
                         the SSL/SSH/etc connect/handshake to the remote host
                         was completed. (Added in 7.19.0)

          time_connect   The time, in seconds, it took from the  start  until
                         the  TCP  connect  to the remote host (or proxy) was
                         completed.

          time_namelookup
                         The time, in seconds, it took from the  start  until
                         the name resolving was completed.

          time_pretransfer
                         The  time,  in seconds, it took from the start until
                         the file transfer was  just  about  to  begin.  This
                         includes  all pre-transfer commands and negotiations
                         that are  specific  to  the  particular  protocol(s)
                         involved.

          time_redirect  The  time,  in  seconds, it took for all redirection
                         steps include name lookup, connect, pretransfer  and
                         transfer  before  the final transaction was started.
                         time_redirect shows the complete execution time  for
                         multiple redirections. (Added in 7.12.3)

          time_starttransfer
                         The  time,  in seconds, it took from the start until
                         the first byte was just  about  to  be  transferred.
                         This includes time_pretransfer and also the time the
                         server needed to calculate the result.

          time_total     The total time, in seconds, that the full  operation
                         lasted.  The time will be displayed with millisecond
                         resolution.

          url_effective  The URL that was fetched last. This is most meaning-
                         ful if you've told curl to follow location: headers.

          If this option is used several times, the last one will be used.

   -x, --proxy <[protocol://][user:password@]proxyhost[:port]>
          Use the specified proxy.

          The proxy string can be specified  with  a  protocol://  prefix  to
          specify  alternative  proxy  protocols.  Use socks4://, socks4a://,
          socks5:// or socks5h:// to request the specific SOCKS version to be
          used. No protocol specified, http:// and all others will be treated
          as HTTP proxies. (The protocol support was added in curl 7.21.7)

          If the port number is not specified in  the  proxy  string,  it  is
          assumed to be 1080.

          This  option  overrides existing environment variables that set the
          proxy to use. If there's an environment variable setting  a  proxy,
          you can set proxy to "" to override it.

          All operations that are performed over an HTTP proxy will transpar-
          ently be converted to HTTP. It means that certain protocol specific
          operations  might not be available. This is not the case if you can
          tunnel through the proxy, as one with the -p, --proxytunnel option.

          User  and  password  that might be provided in the proxy string are
          URL decoded by curl. This allows you to pass in special  characters
          such as @ by using %40 or pass in a colon with %3a.

          The  proxy  host  can  be specified the exact same way as the proxy
          environment variables, including the protocol prefix (http://)  and
          the embedded user + password.

          If this option is used several times, the last one will be used.

   -X, --request <command>
          (HTTP)  Specifies a custom request method to use when communicating
          with the HTTP server.  The specified request method  will  be  used
          instead  of the method otherwise used (which defaults to GET). Read
          the HTTP 1.1 specification for  details  and  explanations.  Common
          additional  HTTP requests include PUT and DELETE, but related tech-
          nologies like WebDAV offers PROPFIND, COPY, MOVE and more.

          Normally you don't need this option. All sorts of GET,  HEAD,  POST
          and PUT requests are rather invoked by using dedicated command line
          options.

          This option only changes the actual word used in the HTTP  request,
          it  does not alter the way curl behaves. So for example if you want
          to make a proper HEAD request, using -X HEAD will not suffice.  You
          need to use the -I, --head option.

          The  method  string  you set with -X will be used for all requests,
          which if you for example use -L, --location  may  cause  unintended
          side-effects  when  curl doesn't change request method according to
          the HTTP 30x response codes - and similar.

          (FTP) Specifies a custom FTP command to use instead  of  LIST  when
          doing file lists with FTP.

          (POP3)  Specifies  a  custom POP3 command to use instead of LIST or
          RETR. (Added in 7.26.0)

          (IMAP) Specifies a custom IMAP command  to  use  instead  of  LIST.
          (Added in 7.30.0)

          (SMTP)  Specifies  a  custom SMTP command to use instead of HELP or
          VRFY. (Added in 7.34.0)

          If this option is used several times, the last one will be used.

   --xattr
          When saving output to a file, this option tells curl to store  cer-
          tain  file metadata in extended file attributes. Currently, the URL
          is stored in the xdg.origin.url attribute and, for HTTP,  the  con-
          tent  type is stored in the mime_type attribute. If the file system
          does not support extended attributes, a warning is issued.


   -y, --speed-time <time>
          If a download is slower than speed-limit bytes per second during  a
          speed-time  period,  the  download  gets  aborted. If speed-time is
          used, the default speed-limit will be 1 unless set with -Y.

          This option controls transfers and thus will not affect  slow  con-
          nects  etc. If this is a concern for you, try the --connect-timeout
          option.

          If this option is used several times, the last one will be used.

   -Y, --speed-limit <speed>
          If a download is slower than this given speed (in bytes per second)
          for  speed-time  seconds it gets aborted. speed-time is set with -y
          and is 30 if not set.

          If this option is used several times, the last one will be used.

   -z, --time-cond <date expression>|<file>
          (HTTP/FTP) Request a file that has been  modified  later  than  the
          given  time  and  date,  or  one that has been modified before that
          time. The <date expression> can be all sorts of date strings or  if
          it  doesn't  match any internal ones, it is taken as a filename and
          tries to get the modification date (mtime) from <file> instead. See
          the curl_getdate(3) man pages for date expression details.

          Start  the date expression with a dash (-) to make it request for a
          document that is older than the given date/time, default is a docu-
          ment that is newer than the specified date/time.

          If this option is used several times, the last one will be used.

   -h, --help
          Usage  help.  This  lists  all  current command line options with a
          short description.

   -M, --manual
          Manual. Display the huge help text.

   -V, --version
          Displays information about curl and the libcurl version it uses.

```

 ###使用案例

指定文件路径名称下载

```
curl -O URL /path/filename
```

认证

```
```

代理

```
```

## History
* man curl命令



## License

[MIT License](https://opensource.org/licenses/mit-license.html). © Running Lee


