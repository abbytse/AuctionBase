--11. No auction may have a bid before its start time or after its end time.

PRAGMA foreign_keys = ON;
DROP TRIGGER IF EXISTS invalid_bid;

CREATE TRIGGER invalid_bid
before INSERT ON Bids
for each row
WHEN EXISTS (
	SELECT *
	FROM Items i
	WHERE i.ItemID = new.ItemID AND (i.Started>new.Time OR i.Ends<new.Time)
	)
BEGIN
	SELECT raise(ROLLBACK, 'No auction may have a bid before its start time or after its end time.');
END;
