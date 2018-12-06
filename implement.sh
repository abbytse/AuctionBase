#!bin/bash

echo "Loading Database ..."
sleep 1s
sh createDatabase.sh
echo "Database Loaded!"
sleep 1s
clear
echo "Testing search functionality of commandLine.py ..."
sleep 2s
python commandLine.py search ItemID=1043374545
sleep 3s
clear
echo "Testing substring search functionality of commandLine.py ..."
sleep 2s
python commandLine.py search description=paypal
sleep 3s
clear
echo "Testing group search functionality of commandLine.py ..."
sleep 2s
python commandLine.py search category=decorative
sleep 3s
clear
echo "Testing bid functionality of commandLine.py ..."
sleep 2s
python commandLine.py bid itemID=1679480995 userID=007cowboy price=1009
sleep 3s
clear
echo "Testing INVALID bid functionality of commandLine.py ..."
sleep 2s
python commandLine.py bid itemID=1679480995 userID=007cowboy price=1009
sleep 3s
clear
echo "Testing buy functionality of commandLine.py ..."
sleep 2s
python commandLine.py buy itemID=1679386982 userID=1philster
sleep 3s
clear
echo "Testing INVALID buy functionality of commandLine.py ..."
sleep 2s
python commandLine.py buy itemID=1679386982 userID=007cowboy
sleep 3s
