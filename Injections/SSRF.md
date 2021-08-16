# Server Side Request Forgery (SSRF)

## What is it?
In SSRF, the attacker can abuse functionality on the server to read or update internal resources. 
They do this by supplying a URL, which the code running on the server will read or submit data. 

When the manipulated request goes to the server, the server-side code picks up the manipulated URL and tries to read data to the manipulated URL. By selecting target URLs, the attacker may be able to read data from services that are not directly exposed on the internet:

Note: XXE can lead to SSRF attacks.

## Injection target
URLs (Eg: image import function from URL)

## Exploit ideas:
1. In an image upload API function, provide another secret API that you already know of ad check the response.