--8. The Current Price of an item must always match the Amount of the most recent bid for that item.
PRAGMA foreign_keys = ON;
DROP TRIGGER IF EXISTS watch_price;

CREATE TRIGGER watch_price
AFTER INSERT ON Bids
FOR EACH ROW
BEGIN
  UPDATE Items SET Currently = new.Amount WHERE ItemID = new.ItemID;
END;
