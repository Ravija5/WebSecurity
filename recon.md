# Recon Tools

## Bruteforcing subdomains 
0. massdns - Change domain name variable
```
sh /Users/ravijamaheshwari/Documents/csGitRepos/WebSecurity/scripts/massdns_runner.sh
```

1. Google it. Use `site: quoccabank.com`
2. [Pentest Tools](https://pentest-tools.com/information-gathering/find-subdomains-of-domain# )
3. [SubdomainFinder] (https://subdomainfinder.c99.nl/scans/2020-08-21/quoccabank.com)

## Directory enumeration:
4. DirSearch
```
python3 /Users/ravijamaheshwari/Desktop/COMP6443/dirsearch/dirsearch.py -u https://www.quoccabank.com/ -x 401,301,302 -r -w /Users/ravijamaheshwari/Documents/csGitRepos/WebSecurity/SecLists/common_paths.txt

```



