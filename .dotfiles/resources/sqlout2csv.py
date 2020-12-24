#!/usr/bin/env python

'''
sqlout2csv
==========
*Convert output text of SQL queries to CSV*.
Reads text of SQL queries from stdin.  Prints CSV to stdout.
USAGE
$ cat sqlout.txt
+-------+--------+
|cmpg_id|BucketId|
+-------+--------+
|22918  |0       |
|22918  |1       |
|22918  |2       |
|22987  |12      |
+-------+--------+
only showing top 4 rows
$ cat sqlout.txt | sqlout2csv.py
cmpg_id,BucketId
22918,0
22918,1
22918,2
22987,12
'''

import sys
import re

sqlout = sys.stdin.readlines()
sqlout = map(lambda x: x[0:-1], sqlout)

def tocsv(line):
    pat = r'\s*\|\s*'
    replacement = ','
    clean_line = line.strip()[1:-1].strip()
    line_out = re.sub(pat, replacement, clean_line)
    return line_out
    
t = filter(lambda x: x.startswith('|'), sqlout)
csvlines = map(lambda x: tocsv(x), t)

print('\n'.join(csvlines))
