--1. No two items can share the same User ID.
--Count any multiples of Users with the same ID.
SELECT * FROM Users GROUP BY UserID HAVING COUNT(*) > 1;

--2. All sellers and bidders must already exists as users.
--Select every instance of a seller or bidder not also being a User.
SELECT * FROM Items I, Bids B WHERE I.SellerID NOT IN (SELECT UserID FROM Users) AND B.UserID NOT IN (SELECT UserID FROM Users);

--3. No two items can share the same Item ID.
--Count any multiples of Items with the same ID.
SELECT * FROM Items GROUP BY ItemID HAVING COUNT(*) > 1;

--4. Every bid must correspond to an actual item.
--Select any ItemID from Bids which does not appear as an ID in Items.
SELECT ItemID FROM Bids WHERE ItemID NOT IN (SELECT ItemID FROM Items);

--5. The items for a given category must all exist.
--Select any ItemID from CategoryOf which does not appear as an ID in Items.
SELECT ItemID FROM CategoryOf WHERE ItemID NOT IN (SELECT ItemID FROM Items);

--6. An item cannot belong to a particular category more than once.
--Count any multiples of items in each category.
SELECT * FROM CategoryOf GROUP BY ItemID,Category HAVING COUNT(*) > 1;

--7. The end time for an auction must always be after its start time.
--Select every instance of an item which had a start time after its end time.
SELECT * FROM Items WHERE Started >= Ends;

--8. The [Current Price] of an item must always match the Amount of the most recent bid for that item.
--Select any instance of an item's most recent bid price being inconsistent with its Currently
--attribute.
SELECT * FROM Items I, (SELECT B1.ItemID, B1.Amount, MAX(B1.Time) FROM Bids B1, Bids B2 WHERE B1.ItemID = B2.ItemID GROUP BY B1.ItemID) X
WHERE I.ItemID = X.ItemID AND I.Currently <> X.Amount;

--9. A user may not bid on an item he or she is also selling.
--Select every instance of an Item and Bid with the same seller and bidder IDs.
SELECT * FROM Items I, Bids B WHERE I.ItemID =  B.ItemID AND I.SellerID = B.UserID;

--10. No auction may have two bids at the exact same time.
--Select every instance in which the multiple bids on a single item are counted for a given time.
SELECT * FROM Bids GROUP BY ItemID,Time HAVING COUNT(*) > 1;

--11. No auction may have a bid before its start time or after its end time.
--Select every instance of a Bid with a time less than the Item's Started or greater than the item's
--Ends.
SELECT * FROM Items I, Bids B WHERE I.ItemID = B.ItemID AND (I.Started>B.Time OR I.Ends<B.Time);

--12. No user can make a bid of the same amount to the same item more than once.
--Select any instance of duplicate Bids for the same amount from the same user on a single given
--Item.
SELECT * FROM Bids GROUP BY ItemID,UserID,Amount HAVING COUNT(*) > 1;

--13. In every auction, the Number of Bids attribute corresponds to the actual number of bids for that particular item.
--Select any instance of the Number_of_Bids attribute being inconsistent with the actual counted
--number of Bids.
SELECT * FROM Items I, Bids B1 WHERE I.ItemID = B1.ItemID AND I.Number_of_Bids <>
	(SELECT COUNT(*) FROM Bids B2 WHERE I.ItemID = B2.ItemID);

--14. Any new bid for a particular item must have a higher amount than any of the previous bids for that particular item.
--Select any instance of a Bid being placed for a given item with an Amount less than or equal to an
--Amount on a previous bid for that item.
SELECT * FROM Bids B1, Bids B2 WHERE B1.ItemID = B2.ItemID AND B1.Time > B2.Time AND B1.Amount <= B2.Amount;

--Constraints 15 and 16 cannot be tested at this time
