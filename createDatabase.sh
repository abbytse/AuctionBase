#!bin/bash

echo "Running create.sql..."
sqlite3 auction.db < create.sql
echo "Running load.txt..."
sqlite3 auction.db < load.txt
echo "Running constraints_verify.sql..."
sqlite3 auction.db < constraints_verify.sql
echo "Running trigger1_add.sql..."
sqlite3 auction.db < ./Triggers/trigger1_add.sql
echo "Running trigger2_add.sql..."
sqlite3 auction.db < ./Triggers/trigger2_add.sql
echo "Running trigger3_add.sql..."
sqlite3 auction.db < ./Triggers/trigger3_add.sql
echo "Running trigger4_add.sql..."
sqlite3 auction.db < ./Triggers/trigger4_add.sql
echo "Running trigger5_add.sql..."
sqlite3 auction.db < ./Triggers/trigger5_add.sql
echo "Running trigger6_add.sql..."
sqlite3 auction.db < ./Triggers/trigger6_add.sql
echo "Running trigger7_add.sql..."
sqlite3 auction.db < ./Triggers/trigger7_add.sql
