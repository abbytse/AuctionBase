--15. All new bids must be placed at the time which matches the current time of your AuctionBase system.

PRAGMA foreign_keys = ON;
DROP TRIGGER IF EXISTS match_time;

CREATE TRIGGER match_time
before INSERT ON Bids
for each row
WHEN EXISTS (
        SELECT *
        FROM CurrentTime c
        WHERE c.Curr_Time <> new.Time
    	)
BEGIN
  SELECT raise(ROLLBACK, 'All new bids must be placed at the time which matches the current time of your AuctionBase system.');
END;
