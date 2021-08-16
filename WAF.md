# Defeating WAF
(https://github.com/0xInfection/Awesome-WAF#evasion-techniques)
1. Blacklisting keywords
    * Use alternative payloads (Eg: Use LIKE instead of =, Use 2 instead of 1)
2. Obfuscation - payload is encoded to a different encoding
    * Case toggling
    * URL Encoding 
3. Unicode normalization - encoding ASCII characters to unicode  
    ```
    Standard - <marquee onstart=prompt()>
    Bypassed -  <marquee onstart=\u0070r\u06f\u006dpt()>  //p,o,m converted to unicode

    Blocked - <marquee loop=1 onfinish=alert()>x
    Bypasses - ＜marquee loop＝1 onfinish＝alert︵1)>x //('s unicode alternative)
    ```
4. HTML Representation 
4. Mixed Encoding
5. Using Comments
`2 OR 2=2#`
```sql
2/*random*/OR/*random*/2/*tt*/LIKE/*tt*/"2"/**/%23  
```
6. Double Encoding
7. Wildcard Obfuscation
8. Dynamic Payload Generation
9. Junk characters
10. Line Breaks
11. Uninitialiased Variables
12. Tabs and Line Feeds

