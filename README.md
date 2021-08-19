# Steps when searching for vulns

**TODO** - link this stuff to the relevant pages. 

## Generic
0. Recon 
1. Look in source code
2. Look in headers
3. Look in robots.txt

## Server Side  
4. Try LFI in URL bar  
    * Or Latex injection  
    * Or CSV Injection  
5. Try Template injection in text input fields  
6. SQL injection  
7. XXE (if the website uses any xml)      

## Client Side
1. XXS
2. CSRF

## Authentication
Identifies a specific user logging in.

1. Brute forcing passwords - use `template.py` with Seclists
    * Try admin, admin
    * Try guest, guest 
2. Check if password/url params are known hashes
    * Enter hash value on google (for SHA, MD5)
3. Check if password/url params are encoded
    * Base 64 onions
    * Base 58
    * URL encoding
    * JWT encoding
    * Other base encodings...
2. Broken forgot password/password reset functionality 
    * Is the reset email link generated securely
3. Session hijacking - hijacking an active user's session 
    * Predictable session token/cookie
    * Client Side Attacks(XSS) 
    * Session fixation - stealing a valid user's session
4. XSS Stealing cookies
5. Injection on input fields
6. Hashes 

## Authorization (Access Control)
Identifies if a user has permission/privilege to take an actionor use a resource.

1. IDOR (id=2)
2. Browse to privileged pages as an unprivileged user
3. Modify own user's page
4. CSRF - force server/legitimate user to make a priviledged action
5. XSS- use another user to fetch privileged content

# Tools
1. Pastebin 
2. Tinyurl
3. Cookie Editor
4. Changing user agent
```
Click on three dots in dev tools -> More tools -> Network Conditions -> Uncheck choose default
```
6. Cyberchef (https://gchq.github.io/CyberChef/)
7. Hosting a URL 
    * Use **python local server** to host content on local host 8000 (usually)
    ```
    python3 -m http.server
    ```
    * **Localtunnel** - To expose this URL (can use https or http versions)
    ```
    lt -port 8000
    ```
8. Changing User Agent via Chrome 
