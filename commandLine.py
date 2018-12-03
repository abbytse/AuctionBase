#to parse command-line options and arguments

import sys 
import pandas as pd 

arguments = []

#skip over the script name and the search keyword 
for index in range(2, len(sys.argv)):
	arguments.append(sys.argv[index].split('='))	

for i in range(len(arguments)):
	print (arguments[i])	

#select * 
#from toys 
#where minPrice = 100 && maxPrice = 1000

#connecting to the database 
#connection = sqlite3.connect("auction.db")

#cursor
#crsr = connection.cursor()

c = ''.join(arguments[2]); 

arg1 = ''.join(arguments[1]);

arg2 = ''.join(arguments[0]);

s = 'select *'
f = ' from ' + c
w = ' where ' + arg1 + arg2 

query = s + f + w 

print (query) 

#execute the statement 
#crsr.execute(query)

