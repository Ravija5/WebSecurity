# CSRF (Cross Site Request Forgery)

**Conditions for CSRF**:
1. Relevant action - that the attacker wants to perform (Eg: changing user password, gaining higher privilege etc.)  
2. Application relies only on session cookie for identifying users
3. No unpredictable parameters in the request.


## Simple CSRF explanation
Cross-Site Request Forgery (CSRF) in simple words
Assume you are currently logged into your online banking at www.mybank.com
Assume a money transfer from mybank.com will result in a request of (conceptually) the form http://www.mybank.com/transfer?to=<SomeAccountnumber>;amount=<SomeAmount>. (Your account number is not needed, because it is implied by your login.)
You visit www.cute-cat-pictures.org, not knowing that it is a malicious site.
If the owner of that site knows the form of the above request (easy!) and correctly guesses you are logged into mybank.com (requires some luck!), they could include on their page a request like http://www.mybank.com/transfer?to=123456;amount=10000 (where 123456 is the number of their Cayman Islands account and 10000 is an amount that you previously thought you were glad to possess).
You retrieved that www.cute-cat-pictures.org page, so your browser will make that request.
Your bank cannot recognize this origin of the request: Your web browser will send the request along with your www.mybank.com cookie and it will look perfectly legitimate. There goes your money!
This is the world without CSRF tokens.

Now for the better one with CSRF tokens:

The transfer request is extended with a third argument: http://www.mybank.com/transfer?to=123456;amount=10000;token=31415926535897932384626433832795028841971.
That token is a huge, impossible-to-guess random number that mybank.com will include on their own web page when they serve it to you. It is different each time they serve any page to anybody.
The attacker is not able to guess the token, is not able to convince your web browser to surrender it (if the browser works correctly...), and so the attacker will not be able to create a valid request, because requests with the wrong token (or no token) will be refused by www.mybank.com.

Credits: https://stackoverflow.com/questions/5207160/what-is-a-csrf-token-what-is-its-importance-and-how-does-it-work


## Can I do a CSRF?
1. Is there a CSRF token in the GET/POST request made and does cookie have SameSite attribute? -> if no , CSRF
2. If yes, does the application check existence of token? -> If no, remove it and do csrf
3. If yes, is the token tied to the user session? If no -> change token to a known existing token for another user account.  

## References:

https://cobalt.io/blog/a-pentesters-guide-to-cross-site-request-forgery-csrf


