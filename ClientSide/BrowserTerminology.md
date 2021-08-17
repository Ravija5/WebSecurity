# Client side protections

Browser provides some minimal protections

## Terminology
1. Same origin vs cross origin
Two URIs are of the same origin if they have the same sceme (http), host (www.xxx.yyy.com) and port.

2. Site: domain formed by the most specific public suffix along with domain label preceding it.  
* https://foo.example.org, https://bar.example.org (same site casue org is suffix and example is domain label preceding)
* https://foo.github.io, https://bar.github.io (cross site cause github.io is suffix and foo/bar are domain labels preceding)

## Same Origin Policy  
A page can have multiple origins (resources loaded from somewhere, frames etc.)  

SOP is a security mechanism stating that only same origins can share resources with each other.   

Rules:  
1. Script from Origin 1 can send data to Origin 2  
2. But it cannot access data from Origin 2 (or see the response)  

## To Allow Cross Origin Access - CORS (Cross Origin Resource Sharing)

When a Site A i.e. the origin, requests a resource from Site B. Site B sends back some Access Control headers that tell the browser what origins the resource can be loaded on it. If Site A is included within this, only then will the browser render resource content.

## To Block Cross Origin Access
1. CSRF tokens

## Attributes for cookies
1. HttpOnly - allow/deny JS scripts to access cookie (can't use document.cookie)
2. Secure - can only send over TLS connections (https)
3. SameSite   
    3.1 If same site, then cookies are always sent  
    3.2 For cross site:       
        3.1 Strict  - Browser will only sent cookie in 1st party context (i.e. url matches the first party site). 
        3.2 Lax - Browser will send the cookie when top level navigations occurs from third party pages (i.e. clicking on a link in third party leading ot first party)
        3.3 None - Browser sends cookie when requesting a resource on the third party site.


## CSP (Content Security Policy)
Enforces loading of resources on a page from trusted location.   
Effective against XSS.



