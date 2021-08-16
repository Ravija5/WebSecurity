# CSRF (Cross Site Request Forgery)

**Conditions for CSRF**:
1. Relevant action - that the attacker wants to perform (Eg: changing user password, gaining higher privilege etc.)  
2. Application relies only on session cookie for identifying users
3. No unpredictable parameters in the request.

Idea: 
* Attacker creates their own fake page which will trigger a HTTP request to the vulnerable website. 
* If the victim clicks on this malicious link WHILE being logged in to the legitimate vulnerable website, their cookies stored in the browser are sent. (assuming SameSite cookies are not being used)






