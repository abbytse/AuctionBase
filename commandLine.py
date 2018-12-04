#!/usr/bin/python
#test case: python commandLine.py search ItemID=1043374545
#test case: python commandLine.py bid itemID=1679480995 userID=007cowboy price=1009

import sys
import sqlite3
from sqlite3 import Error
import datetime
from datetime import datetime

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
        #case-sensitive in SQL
        if text[0] == 'minPrice':
            text[0] = 'First_Bid'
        elif text[0] == 'maxPrice':
            text[0] = 'Currently'
        elif text[0] == 'itemID':
            text[0] = 'ItemID'
        elif text[0] == 'description':
            text[0] = 'Description'
        elif text[0] == 'category':
            text[0] = 'Category'
        elif text[0] == 'price':
            text[0] = 'Amount'
        elif text[0] == 'userID':
            text[0] = 'UserID'
            text[1] = '\'' + text[1] + '\''
        argument.append(text[0])
        argument.append(text[1])
        i+=1
    return argument

def search(conn,argument):
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

    cur = conn.cursor()
    cur.execute("SELECT * FROM Items WHERE %s" % (arguments,))

    rows = cur.fetchall()

    for row in rows:
        print(row)


# def buy(conn,argument):
#     cur = conn.cursor()
#     cur.execute("INSERT
#
    rows = cur.fetchall()

    for row in rows:
        print(row)


def bid(conn,argument):
    date = datetime(2001,12,20,00,00) #default datetime
    date = date.replace(second=1)
    date = "\'" + str(date) + "\'"

    #assigns UserID to user
    user = ""
    i = 0
    while(i < len(argument)):
        if argument[i] == 'UserID':
            user = str(argument[i+1])
        i += 1

    i = 0
    attribute = ""
    values = ""
    while i < len(argument):
        if(i % 2 == 0):
            attribute+=str(argument[i]) + ", "
            # if(i != (len(argument) - 2)):
            #     attribute+=", "
        elif(i % 2 != 0):
            values+=str(argument[i]) + ", "
            # if(i != (len(argument) - 1)):
            #     values+=", "
        i+=1
    attribute+="Time"
    values+=str(date)
    sql = "INSERT INTO Bids (" + attribute + ") VALUES (" + values + ")"

    cur = conn.cursor()
    cur.execute(sql)
    cur.execute("SELECT * FROM Bids WHERE UserID=%s" % (user,))

    rows = cur.fetchall()

    for row in rows:
        print(row)


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
            bid(conn,argument)

if __name__ == "__main__":
    main()
