#!/usr/bin/python
#python script to add the open/closed status to the database 

import sys
import sqlite3
from sqlite3 import Error

#opens connection to database file
def create_connection(db_file):
    try:
        conn = sqlite3.connect(db_file)
        return conn
    except Error as e:
        print(e)

    return None

#defines what an open and closed status means 
#based on currently and buy_price
#if currently matches or exceeds buy_price, the auction is closed
#if currently is less than buy_price or the buy_price is Null, the auction is opened 
def status(conn):
    cur = conn.cursor()
    cur.execute("ALTER TABLE Items ADD COLUMN Open VARCHAR(50)")
    cur.execute("UPDATE Items SET Open = 'True' WHERE Currently < Buy_Price OR Buy_Price IS NULL")
    cur.execute("UPDATE Items SET Open = 'False' WHERE Currently >= Buy_Price AND Buy_Price IS NOT NULL")

    return None

#main to implement the updates status 
def main():
    database = "auction.db"

    #create a database connection
    conn = create_connection(database)
    with conn:
        status(conn)
        print("Successfully added Open attribute")

if __name__ == "__main__":
    main()
