# AuctionBase
Database management project that bulk loads historic eBay data in JSON format into a SQLite Database via a python parser. Searches, bids, and purchases are made using commandLine.py, which takes command line arguments and converts those into a query in the SQlite Database. Triggers were implemented to avoid collisions or invalid data entries.

Technologies and tools used: **Python**, **SQLite**, **Shell Scripting*

Author: Zachary Dulac, Trung Nguyen, Abby Tse
*****

##### Part 1.A: Design relational schema
- **Users(<u>User_ID</u>, Rating, Location, Country)**
- **Items(<u>Item_ID</u>, Seller_ID, Name, Buy_Price, First_Bid, Currently, Number_of_Bids, Started, Ends, Description, Open)**
- **CategoriesOf(<u>Item_ID</u>, <u>Category</u>)**
- **Categories(<u>Category</u>)**
- **Bids(<u>Item_ID</u>, <u>User_ID</u>, <u>Time</u>, Amount)**

##### Part 1.B: Implement parser
- Finish ```parser.py```. Use Command:
```Bash
python zat_parser.py ./ebay_data/items-*.json
```
- Clean .dat files - remove duplicates and sorts. Use Commands:
```Bash
sort -k1 -u -o items.dat items.dat
sort -k1 -u -o categoryOf.dat category.dat
sort -k1 -u -o users.dat users.dat
sort -k1 -u -o bids.dat bids.dat

cat categoryOf.dat | awk -F"|" '{print $2}' > category.dat
sort -k1 -u -o category.dat category.dat
```
- Automate Part1.A + B: ```sh runParser.sh```

##### Part 2: Load eBay data into SQLite and test SQL database
- Use Command: ```sh createDatabase.sh```

##### Part 3: Implement command line query
- Use Command: ```python commandLine.py <option> <argument>```
+ Ability to browse auction of interest based on the following input parameters:
    - item ID
    - category
    - item description
    - price
    - open/closed status
- Test implementation using: ```sh implement.sh```
