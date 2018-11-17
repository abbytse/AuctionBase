--16. The current time of your AuctionBase system can only advance forward in time, not backward in time.

PRAGMA foreign_keys = ON;
DROP TRIGGER IF EXISTS forward_time;

CREATE TRIGGER forward_time
before UPDATE ON CurrentTime
for each row
WHEN new.Curr_Time<old.Curr_Time
BEGIN
  SELECT raise(ROLLBACK, 'The current time of your AuctionBase system can only advance forward in time, not backward in time.');
END;
