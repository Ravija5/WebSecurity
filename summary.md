# Steps when searching for vulns

## Generic
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
8. 

## Client Side
7. 

# Tools
1. Pastebin
2. Tinyurl
3. Cookie Editor
4. TBD - user agent changer
5. TBD - tool that makes line green if it sees burp flag
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

