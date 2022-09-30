--Display the current home value for each  property id’s for Owner Id: 1426


SELECT o.PropertyId,
       o.OwnerId,
       p.Name as PropertyName,
	   h.value 
FROM dbo.Property AS p 
inner join dbo.OwnerProperty AS o ON p.Id=o.PropertyId
inner join dbo.PropertyHomeValue AS h ON p.Id=h.PropertyId 
WHERE OwnerId=1426 AND h.IsActive=1 


