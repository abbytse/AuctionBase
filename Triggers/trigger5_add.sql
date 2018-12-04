--14. Any new bid for a particular item must have a higher amount than any of the previous bids for that particular item.
PRAGMA foreign_keys = ON;
DROP TRIGGER IF EXISTS higher_bid;

--Catch any instance of a bid being placed for a lower amount than a previous bid and ROLLBACK
CREATE TRIGGER higher_bid
BEFORE INSERT ON Bids
FOR EACH ROW
WHEN EXISTS (
	SELECT * 
	FROM Items 
	WHERE Items.ItemID = new.ItemID AND Items.Currently >= new.Amount
)
BEGIN
  SELECT RAISE(ROLLBACK, 'Any new bid for a particular item must have a higher amount than any of the previous bids for that particular item.');
END;
