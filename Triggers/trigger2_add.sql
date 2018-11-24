--9. A user may not bid on an item he or she is also selling.
PRAGMA foreign_keys = ON;
DROP TRIGGER IF EXISTS seller_bid;

CREATE TRIGGER seller_bid
BEFORE INSERT ON Bids
FOR EACH ROW
WHEN EXISTS(SELECT * FROM Items WHERE Items.ItemID = new.ItemID AND Items.SellerID = new.UserID)
BEGIN
	SELECT RAISE(ROLLBACK, 'A user may not bid on an item he or she is also selling');
END;
