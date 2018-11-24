--16. The current time of your AuctionBase system can only advance forward in time, not backward in time.
PRAGMA foreign_keys = ON;
DROP TRIGGER IF EXISTS forward_time;

CREATE TRIGGER forward_time
BEFORE UPDATE ON CurrentTime
FOR EACH ROW
WHEN (old.Curr_Time >= new.currentTime)
BEGIN
  SELECT RAISE(ROLLBACK, 'The current time of your AuctionBase system can only advance forward in time, not backward in time.');
END;
