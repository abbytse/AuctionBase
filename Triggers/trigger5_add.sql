--14. Any new bid for a particular item must have a higher amount than any of the previous bids for that particular item.
PRAGMA foreign_keys = ON;
DROP TRIGGER IF EXISTS higher_bid;

CREATE TRIGGER higher_bid
BEFORE INSERT ON Bids
FOR EACH ROW
WHEN EXISTS (SELECT * FROM Items WHERE Items.ItemID = new.ItemID AND Items.Currently >= new.Amount)
BEGIN
  SELECT RAISE(ROLLBACK, 'Any new bid for a particular item must have a higher amount than any of the previous bids for that particular item.');
END;
