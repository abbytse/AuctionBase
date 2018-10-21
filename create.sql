DROP TABLE IF EXISTS Items;
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS CategoryOf;
DROP TABLE IF EXISTS Category;
DROP TABLE IF EXISTS Bids;

CREATE TABLE Items(
  ItemID INT PRIMARY KEY,
  SellerID INT,
  Name VARCHAR(50),
  Buy_Price FLOAT,
  First_Bid FLOAT,
  Currently FLOAT,
  Number_of_Bids INT,
  Started TIME,
  Ends TIME,
  Description VARCHAR(10000),
  FOREIGN KEY(SellerID) REFERENCES Users
);

CREATE TABLE Users(
  UserID INT PRIMARY KEY,
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
  UserID INT,
  Time TIME,
  Amount FLOAT,
  PRIMARY KEY(ItemID, UserID, Time),
  FOREIGN KEY(ItemID) REFERENCES Items,
  FOREIGN KEY(UserID) REFERENCES Users
);
