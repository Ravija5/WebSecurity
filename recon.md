# Recon Tools

## Bruteforcing subdomains 
0. massdns
```
./bin/massdns -r <wordlist-file> "quoccabank.com" "output.txt"
```


1. Google it. Use `site: quoccabank.com`
2. [DNS Dumpster](https://dnsdumpster.com/)
3. [SubdomainFinder] (https://subdomainfinder.c99.nl/scans/2020-08-21/quoccabank.com)

## Directory enumeration:
4. DirSearch
```
python3 dirsearch.py -u https://www.quoccabank.com/ -x 401,301,302 -r -w <common_paths_file>
```
Note: common file path '../../../Documents/csGitRepos/WebSecurity/SecLists/common_paths.txt'  






