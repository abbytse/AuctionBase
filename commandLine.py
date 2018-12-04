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

def select_all(conn):
    cur = conn.cursor()
    cur.execute("SELECT * FROM Bids WHERE ItemID = 1043402767")

    rows = cur.fetchall()

    for row in rows:
        print(row)

def split():
    argument = []
    for x in sys.argv[1:]:
        argument.append(x.split("="))
    # text = sys.argv[1:].split("=")
    print(argument)

#DISREGARD UNTIL FURTHER TESTING
# def select(conn):
#     cur = conn.cursor()
#     cur.execute("SELECT * FROM Bids WHERE %s = %s")

def main():
    database = "auction.db"

    #create a database connection
    conn = create_connection(database)
    with conn:
        print("1.Select one row")
        select_all(conn)
        print("\nArgument List:", str(sys.argv[1:]))
        split()

if __name__ == "__main__":
    main()
