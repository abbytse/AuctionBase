--1. No two items can share the same User ID.
SELECT * FROM Users GROUP BY UserID HAVING COUNT(*) > 1;

--2. All sellers and bidders must already exists as users.
SELECT * FROM Items I, Bids B WHERE I.SellerID NOT IN (SELECT UserID FROM Users) AND B.UserID NOT IN (SELECT UserID FROM Users);

--3. No two items can share the same Item ID.
SELECT * FROM Items GROUP BY ItemID HAVING COUNT(*) > 1;

--4. Every bid must correspond to an actual item.
SELECT ItemID FROM Bids WHERE ItemID NOT IN (SELECT ItemID FROM Items);

--5. The items for a given category must all exist.
SELECT ItemID FROM CategoryOf WHERE ItemID NOT IN (SELECT ItemID FROM Items);

--6. An item cannot belong to a particular category more than once.
SELECT * FROM CategoryOf GROUP BY ItemID,Category HAVING COUNT(*) > 1;

--7. The end time for an auction must always be after its start time.
SELECT * FROM Items WHERE Started >= Ends;

--8. The [Current Price] of an item must always match the Amount of the most recent bid for that item.
SELECT * FROM Items I, (SELECT B1.ItemID, B1.Amount, MAX(B1.Time) FROM Bids B1, Bids B2 WHERE B1.ItemID = B2.ItemID GROUP BY B1.ItemID) X
WHERE I.ItemID = X.ItemID AND I.Currently <> X.Amount;

--9. A user may not bid on an item he or she is also selling.
SELECT * FROM Items I, Bids B WHERE I.ItemID =  B.ItemID AND I.SellerID = B.UserID;

--10. No auction may have two bids at the exact same time.
SELECT * FROM Bids GROUP BY ItemID,Time HAVING COUNT(*) > 1;

--11. No auction may have a bid before its start time or after its end time.
SELECT * FROM Items I, Bids B WHERE I.ItemID = B.ItemID AND (I.Started>B.Time OR I.Ends<B.Time);

--12. No user can make a bid of the same amount to the same item more than once.
SELECT * FROM Bids GROUP BY ItemID,UserID,Amount HAVING COUNT(*) > 1;

--13. In every auction, the Number of Bids attribute corresponds to the actual number of bids for that particular item.
SELECT * FROM Items I, Bids B1 WHERE I.ItemID = B1.ItemID AND I.Number_of_Bids <>
	(SELECT COUNT(*) FROM Bids B2 WHERE I.ItemID = B2.ItemID);

--14. Any new bid for a particular item must have a higher amount than any of the previous bids for that particular item.
SELECT * FROM Bids B1, Bids B2 WHERE B1.ItemID = B2.ItemID AND B1.Time > B2.Time AND B1.Amount <= B2.Amount;

--Constraints 15 and 16 cannot be tested at this time
