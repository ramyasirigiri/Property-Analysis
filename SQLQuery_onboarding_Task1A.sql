
--Display a list of all property names and their property id’s for Owner Id: 1426. 

SELECT o.PropertyId,
	   p.Name as PropertyName 
FROM dbo.Property as p 
Inner join dbo.OwnerProperty as o on p.Id=o.PropertyId
WHERE o.OwnerId=1426