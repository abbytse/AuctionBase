--13. In every auction, the Number of Bids attribute corresponds to the actual number of bids for that particular item.

PRAGMA foreign_keys = ON;
DROP TRIGGER IF EXISTS number_of_bids;

CREATE TRIGGER number_of_bids
after INSERT ON Bids
for each row
BEGIN
  UPDATE Items SET Number_of_Bids = Number_of_Bids + 1
  WHERE ItemID = new.ItemID;
END;
