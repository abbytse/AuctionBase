--8. The Current Price of an item must always match the Amount of the most recent bid for that item.
PRAGMA foreign_keys = ON;
DROP TRIGGER IF EXISTS bid_price;

--Ensure that an item's current price is up to ate with the most recent bid. 
CREATE TRIGGER bid_price
AFTER INSERT ON Bids
FOR EACH ROW
BEGIN
  UPDATE Items SET Currently = new.Amount WHERE ItemID = new.ItemID;
END;
