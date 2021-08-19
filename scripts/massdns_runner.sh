#!/usr/bin/env bash

DOMAIN=quoccaos.quoccabank.com

#Seclists files
SUBDOMAINS="/Users/ravijamaheshwari/Documents/csGitRepos/WebSecurity/SecLists/top_5000_subdomains.txt"
RESOLVER_FILE="/Users/ravijamaheshwari/Documents/csGitRepos/WebSecurity/SecLists/massdns_resolvers.txt"
PREFIX_FILE="/Users/ravijamaheshwari/Documents/csGitRepos/WebSecurity/SecLists/subdomain_prefixes.txt"

#Enumeration tools
MASSDNS="/Users/ravijamaheshwari/Desktop/COMP6443/massdns/bin/massdns"
ALT_DNS="/Users/ravijamaheshwari/Documents/csGitRepos/altdns/altdns/__main__.py"

MASSDNS_INPUT_1="/Users/ravijamaheshwari/temp/massdns_input_1.txt"
MASSDNS_OUTPUT_1="/Users/ravijamaheshwari/temp/massdns_output_1.txt"

ALTDNS_OUTPUT="/Users/ravijamaheshwari/temp/altdns_output.txt"
SUBFINDER_OUTPUT_2="/Users/ravijamaheshwari/temp/subfinder_output_2.txt"
MERGED_OUTPUT_TEMP="/Users/ravijamaheshwari/temp/merged_output_temp.txt"
MERGED_OUTPUT="/Users/ravijamaheshwari/temp/merged_output.txt"
FINAL_SUBDOMAINS="/Users/ravijamaheshwari/temp/final_subdomains.txt"

echo "****** Recon for $DOMAIN ********"

#Files clean up and creation
rm -rf $ALTDNS_OUTPUT
touch $ALTDNS_OUTPUT

rm -rf $MASSDNS_INPUT_1
touch $MASSDNS_INPUT_1

rm -rf $MASSDNS_OUTPUT_1
touch $MASSDNS_OUTPUT_1

rm -rf $ALTDNS_OUTPUT
touch $ALTDNS_OUTPUT

rm -rf $SUBFINDER_OUTPUT_2
touch $SUBFINDER_OUTPUT_2

rm -rf $MERGED_OUTPUT_TEMP
touch $MERGED_OUTPUT_TEMP

rm -rf $MERGED_OUTPUT
touch $MERGED_OUTPUT

#Creating a temp file which will be given to massdns to check if it is valid domain
while read -r line
do
    echo "$line.$DOMAIN" >> $MASSDNS_INPUT_1
done < $SUBDOMAINS

#Running massdns for active recon
echo "--------------------------------------------------------------------"
echo "Starting massdns for active recon...."
echo "--------------------------------------------------------------------"
$MASSDNS -r $RESOLVER_FILE -q -t A -o S -w $MASSDNS_OUTPUT_1 $MASSDNS_INPUT_1

echo "--------------------------------------------------------------------"
echo "Completed massdns recon. Output at $MASSDNS_OUTPUT_1"
echo "Starting subfinder for passive recon...."
echo "--------------------------------------------------------------------"

#Running subfinder for passive recon
subfinder -d $DOMAIN -all -nW -o $SUBFINDER_OUTPUT_2 -silent

echo "--------------------------------------------------------------------"
echo "Completed subfinder recon. Check output at $SUBFINDER_OUTPUT_2"
echo "--------------------------------------------------------------------"

#Merging both outputs into a single file
cat $MASSDNS_OUTPUT_1 >> $MERGED_OUTPUT_TEMP
cat $SUBFINDER_OUTPUT_2 >> $MERGED_OUTPUT_TEMP
awk '{print $1}' $MERGED_OUTPUT_TEMP > $MERGED_OUTPUT
sort -u $MERGED_OUTPUT -o $MERGED_OUTPUT

echo "--------------------------------------------------------------------"
echo "Merged both files. Check output at $MERGED_OUTPUT"
echo "Starting altdns to generate permutations..."
echo "--------------------------------------------------------------------"

python3 $ALT_DNS -i $MERGED_OUTPUT -o $ALTDNS_OUTPUT -w $PREFIX_FILE

echo "--------------------------------------------------------------------"
echo "Completed altdns run. Checkout output at $ALTDNS_OUTPUT"
echo "Sending merged to massdns again..."
echo "--------------------------------------------------------------------"

cat $MERGED_OUTPUT >> $ALTDNS_OUTPUT
$MASSDNS -r $RESOLVER_FILE -q -t A -o S -w $FINAL_SUBDOMAINS $ALTDNS_OUTPUT

echo "--------------------------------------------------------------------"
echo "Completed recon. Check output in $FINAL_SUBDOMAINS"
echo "--------------------------------------------------------------------"

