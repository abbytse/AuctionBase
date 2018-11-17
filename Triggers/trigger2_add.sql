--9. A user may not bid on an item he or she is also selling.
PRAGMA foreign_keys = ON;
DROP TRIGGER IF EXISTS seller_bid;

CREATE TRIGGER seller_bid
before INSERT ON Bids
for each row
WHEN EXISTS(
	SELECT *
	FROM Items i
	WHERE i.ItemID = new.ItemID AND i.SellerID = new.UserID
	)
BEGIN
	SELECT raise(ROLLBACK, 'User may not bid on his/her own item.');
END;
