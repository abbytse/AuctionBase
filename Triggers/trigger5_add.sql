--14. Any new bid for a particular item must have a higher amount than any of the previous bids for that particular item.

PRAGMA foreign_keys = ON;
DROP TRIGGER IF EXISTS higher_bid;

CREATE TRIGGER higher_bid
before INSERT ON Bids
for each row
WHEN EXISTS (
        SELECT *
        FROM Items i
        WHERE i.ItemID=new.ItemID AND (i.Currently>=new.Amount)
    	)
BEGIN
  SELECT raise(ROLLBACK, 'Any new bid for a particular item must have a higher amount than any of the previous bids for that particular item.');
END;
