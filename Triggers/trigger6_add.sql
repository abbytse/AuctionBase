--15. All new bids must be placed at the time which matches the current time of your AuctionBase system.
PRAGMA foreign_keys = ON;
DROP TRIGGER IF EXISTS match_time;

CREATE TRIGGER match_time
BEFORE INSERT ON Bids
FOR EACH ROW
WHEN EXISTS (SELECT * FROM CurrentTime WHERE CurrentTime.currentTime <> new.Time)
BEGIN
  SELECT RAISE(ROLLBACK, 'All new bids must be placed at the time which matches the current time of your AuctionBase system.');
END;
