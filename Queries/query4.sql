SELECT ItemID FROM Items WHERE Currently = (SELECT MAX(Currently) from Items);
