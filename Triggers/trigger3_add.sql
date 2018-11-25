--11. No auction may have a bid before its start time or after its end time.
PRAGMA foreign_keys = ON;
DROP TRIGGER IF EXISTS invalid_bid;

--Catch any instance of bid's time occuring before the start or after the end time and ROLLBACK
CREATE TRIGGER invalid_bid
BEFORE INSERT ON Bids
FOR EACH ROW
WHEN EXISTS (
	SELECT * 
	FROM Items 
	WHERE Items.ItemID = new.ItemID AND (Items.Started > new.Time OR Items.Ends < new.Time)
)
BEGIN
	SELECT RAISE(ROLLBACK, 'No auction may have a bid before its start time or after its end time!');
END;
