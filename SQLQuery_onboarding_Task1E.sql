---DISPLAYING current tenant name and rentalpayment
SELECT pro.Name AS PropertyName,
       p.FirstName AS TenantFirstName,
	   p.LastName AS TenantLastName,
	   tpf.Name AS payments_per
FROM dbo.Person AS p
INNER JOIN dbo.Tenant AS t ON p.Id=t.Id
INNER JOIN dbo.TenantProperty AS tp ON tp.TenantId=t.Id
INNER JOIN dbo.TenantPaymentFrequencies AS tpf ON tp.PaymentFrequencyId=tpf.Id
INNER JOIN dbo.Property AS pro ON pro.Id=tp.PropertyId
WHERE t.IsActive=1 AND pro.Id IN (select o.PropertyId from dbo.Property as p 
INNER JOIN dbo.OwnerProperty as o on p.Id=o.PropertyId
where OwnerId=1426)