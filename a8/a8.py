#!/usr/bin/python3
# -*- coding: utf-8 -*-

# %% MySQL database queries

import mysql.connector as connector
from mysql.connector import errorcode


def query(cnx):
    cur = cnx.cursor()
    curOut = []
    cur.execute("select character_name from lotr_character")
    result = cur.fetchall()
    for row in result:
        curOut.append(''.join(row))
    cur.close()
    characterName = input(
        f"Legal characters: {', '.join(curOut)}. Enter character name: ")
    while characterName not in curOut:
        print("Invalid character name. Please try again.")
        characterName = input(
            f"Legal characters: {', '.join(curOut)}. Enter character name: ")
    cur2 = cnx.cursor()
    cur2.callproc('track_character', args=[characterName])
    cur2.close()
    for result in cur2.stored_results():
        print(result.fetchall())


def main():
    print('Connecting to DB...')
    user = input('Enter DB user: ')
    password = input('Enter DB password: ')
    config = {
        'host': 'localhost',
        'port': 3306,
        'database': 'lotrfinal_1',
        'user': user,
        'password': password,
        'charset': 'utf8',
        'use_unicode': True,
        'get_warnings': True
    }
    try:
        cnx = connector.connect(**config)
        print('Successfully connected to DB')
        try:
            query(cnx)
        except connector.Error as e:
            print(f"Error. {e}")
        finally:
            cnx.close()
            print("Closed DB connection.")
    except connector.Error as e:
        if e.errno == errorcode.ER_ACCESS_DENIED_ERROR:
            print("Incorrect credentials")
        elif e.errno == errorcode.ER_BAD_DB_ERROR:
            print("Couldn't find database \"%s\"" % config['database'])
        else:
            print(e)


if __name__ == '__main__':
    main()
