--16. The current time of your AuctionBase system can only advance forward in time, not backward in time.
PRAGMA foreign_keys = ON;
DROP TRIGGER IF EXISTS time_flow;

CREATE TRIGGER time_flow
BEFORE UPDATE ON CurrentTime
FOR EACH ROW
WHEN (old.currentTime >= new.currentTime)
BEGIN
  SELECT RAISE(ROLLBACK, 'The current time of your AuctionBase system can only advance forward in time, not backward in time.');
END;
