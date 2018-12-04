#!/usr/bin/python

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

def status(conn):
    cur = conn.cursor()
    cur.execute("ALTER TABLE Items ADD COLUMN Open VARCHAR(50)")
    cur.execute("UPDATE Items SET Open = 'True' WHERE Currently < Buy_Price OR Buy_Price IS NULL")
    cur.execute("UPDATE Items SET Open = 'False' WHERE Currently >= Buy_Price AND Buy_Price IS NOT NULL")

    return None



def main():
    database = "auction.db"

    #create a database connection
    conn = create_connection(database)
    with conn:
        status(conn)
        print("Successfully added Open attribute")

if __name__ == "__main__":
    main()
