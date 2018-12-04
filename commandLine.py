#!/usr/bin/python
#test case: python clInterface.py search ItemID=1043374545

import sys
import sqlite3
from sqlite3 import Error

def create_connection(db_file):
    try:
        conn = sqlite3.connect(db_file)
        return conn
    except Error as e:
        print(e)

    return None

def split():
    argument = []
    i = 2
    for x in sys.argv[2:]:
        text = sys.argv[i].split("=")
        argument.append(text[0])
        argument.append(text[1])
        i+=1
    return argument

def search(conn,argument):
    cur = conn.cursor()
    i = 0
    arguments = ""
    for x in argument:
        arguments+=str(x) + " "
        if(i == (len(argument)-1)):
            break
        elif(i%2 == 0):
            arguments+=str("= ")
        elif(i%2 != 0):
            arguments+=str(" AND ")
        i+=1
    cur.execute("SELECT * FROM Items WHERE %s" % (arguments,))

    rows = cur.fetchall()

    for row in rows:
        print(row)

def buy():

    return None

def bid():

    return None


def main():
    database = "auction.db"

    #create a database connection
    conn = create_connection(database)
    with conn:
        argument = split()
        function = sys.argv[1]
        if function == "search":
            print("\nSearching...")
            search(conn,argument)
        elif function == "buy":
            None
        elif function == "bid":
            None

if __name__ == "__main__":
    main()
