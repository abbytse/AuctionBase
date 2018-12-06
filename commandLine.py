#!/usr/bin/python
#search test case: python commandLine.py search itemID=1043374545
#search test case: python commandLine.py search description=paypal
#join test case: python commandLine.py search itemID=1043374545 category=Decorative
#bid test case: python commandLine.py bid itemID=1679480995 userID=007cowboy price=1009
#bid == buy_price test case: python commandLine.py bid itemID=1679391688 userID=007cowboy price=11.53
#buy test case: python commandLine.py buy itemID=1679386982 userID=1philster
#buy test case: python commandLine.py buy itemID=1679386982 userID=007cowboy

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
    print(argument)
    for x in argument:
        if(x == 'Description'):
            arguments+= argument[i] + " like \'%" + argument[i+1] + "%\'"
            i+=1
        else:
            arguments+=str(x) + " "
        if(i == (len(argument)-1)):
            break
        elif(i%2 == 0):
            arguments+=str("= ")
        elif(i%2 != 0):
            arguments+=str(" AND ")
        i+=1

    print(arguments)
    cur = conn.cursor()
    cur.execute("SELECT * FROM Items WHERE %s" % (arguments,))

    rows = cur.fetchall()

    for row in rows:
        print(row)
        if(sys.argv[1] != "search"):
            return row

def join(conn,argument):
    print(len(argument))
    arguments = ""
    i = 0
    while i < len(argument):
        if(argument[i] == 'Category'):
            temp = 'C.'
            arguments+= str(temp) + argument[i] + " like \'%" + argument[i+1] + "%\'"
        elif(argument[i] == 'Description'):
            temp = 'I.'
            arguments+= str(temp) + argument[i] + " like \'%" + argument[i+1] + "%\'"
        else:
            temp = 'I.'
            arguments+= str(temp) + argument[i] + "=" + argument[i+1]
        if((i+2) == len(argument)):
            break
        else:
            arguments+= " AND "
        i += 2
    print(arguments)
    sql = "SELECT * FROM Items I, CategoryOf C WHERE I.ItemID = C.ItemID AND " + str(arguments)
    cur = conn.cursor()
    cur.execute(sql)

    rows = cur.fetchall()

    for row in rows:
        print(row)
        if(sys.argv[1] != "search"):
            return row


def buy(conn,argument):
    i = 0
    userID = []
    itemID = []
    while i < len(argument):
        if(argument[i] == 'UserID'):
            userID.append(argument[i])
            userID.append(argument[i+1])
            del argument[i]
            del argument[i]
        elif(argument[i] == 'ItemID'):
            itemID.append(argument[i])
            itemID.append(argument[i+1])
        i += 1

    #search for ItemID
    print('Seaching for item identification number...')
    row = search(conn,argument)

    #place bid that links both Bids and Items table
    status = row[10]
    if status == 0:
        raise Exception("Bid of Item is Closed!")
    argument.append(userID[0])
    argument.append(userID[1])
    argument.append("Amount")
    argument.append(row[3])
    print('Entering bid...')
    bid(conn,argument)

    sql = "UPDATE Items SET Open = false WHERE " + itemID[0] + "=" + itemID[1]
    cur = conn.cursor()
    cur.execute(sql)
    print("Item has been bought!")


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
    print("Succesfully Bid!")
    print("Searching for Bid...")
    cur.execute("SELECT * FROM Bids WHERE UserID=%s" % (user,))

    rows = cur.fetchall()

    for row in rows:
        print(row)


def main():
    database = "auction.db"

    #create a database connection
    conn = create_connection(database)
    with conn:
        joinB = False;
        argument = split()
        function = sys.argv[1]

        if function == "search":
            for x in argument:
                if x == 'Category':
                    joinB = True;
            print("\nSearching...")
            if(joinB):
                join(conn,argument)
            else:
                search(conn,argument)
        elif function == "buy":
            buy(conn,argument)
        elif function == "bid":
            print("\nBidding...")
            bid(conn,argument)

if __name__ == "__main__":
    main()
