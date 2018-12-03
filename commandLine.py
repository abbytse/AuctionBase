#to parse command-line options and arguments

import sys 

arguments = []

#skip over the script name and the search keyword 
for index in range(2, len(sys.argv)):
	arguments.append(sys.argv[index].split('='))	

for i in range(len(arguments)):
	print (arguments[i])	
