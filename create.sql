DROP TABLE IF EXISTS Items;
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS CategoryOf;
DROP TABLE IF EXISTS Category;
DROP TABLE IF EXISTS Bids;
DROP TABLE IF EXISTS CurrentTime;

CREATE TABLE Items(
  ItemID INT PRIMARY KEY,
  SellerID VARCHAR(50),
  Name VARCHAR(50),
  Buy_Price FLOAT,
  First_Bid FLOAT,
  Currently FLOAT,
  Number_of_Bids INT,
  Started DATETIME,
  Ends DATETIME CHECK(Ends>Started),
  Description VARCHAR(10000),
  FOREIGN KEY(SellerID) REFERENCES Users
);

CREATE TABLE Users(
  UserID VARCHAR(50) PRIMARY KEY,
  Rating FLOAT,
  Location VARCHAR(80),
  Country VARCHAR(50)
);

CREATE TABLE CategoryOf(
  ItemID INT,
  Category VARCHAR(50),
  PRIMARY KEY(ItemID, Category),
  FOREIGN KEY(ItemID) REFERENCES Items,
  FOREIGN KEY(Category) REFERENCES Category
);

CREATE TABLE Category(
  Category VARCHAR(50) PRIMARY KEY
);

CREATE TABLE Bids(
  ItemID INT,
  UserID VARCHAR(50),
  Time TIME,
  Amount FLOAT,
  UNIQUE(ItemID, Time),
  UNIQUE(UserID, Amount, Time),
  PRIMARY KEY(ItemID, UserID, Time),
  FOREIGN KEY(ItemID) REFERENCES Items,
  FOREIGN KEY(UserID) REFERENCES Users
);

CREATE TABLE CurrentTime(
	currentTime DATETIME PRIMARY KEY
);

INSERT into CurrentTime VALUES ('2001-12-20 00:00:01');
SELECT * FROM CurrentTime;
