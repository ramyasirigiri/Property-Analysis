--Returning sum of all payments and Display the yeild--onboard task C

WITH Cte_Sum(PropertyId,startDate,EndDate,PaymentFrequencyId,PaymentAmount,sum_of_payments)
AS
(
---calculating the sum of all payments in between the start and end date 
 SELECT PropertyId,startDate,EndDate,PaymentFrequencyId,PaymentAmount,
  CASE PaymentFrequencyId
	WHEN 1 THEN PaymentAmount*(DATEDIFF(WW,startDate,EndDate))
	WHEN 2 THEN PaymentAmount*(DATEDIFF(WW,startDate,EndDate)/2)
	WHEN 3 THEN PaymentAmount* (DATEDIFF(MONTH,startDate,EndDate)-1)
  END AS sum_of_payments
FROM dbo.TenantProperty
WHERE PropertyId IN (SELECT o.PropertyId FROM dbo.Property AS p 
inner join dbo.OwnerProperty AS o ON p.Id=o.PropertyId
WHERE OwnerId=1426)
),---eliminating the null values after join operation 
Cte_replace_null(PropertyId,CurrentHomeValue,Amount)
AS
(
SELECT pf.PropertyId,pf.CurrentHomeValue,ISNULL(pe.Amount,0)
FROM Cte_Sum 
INNER JOIN dbo.PropertyFinance AS pf ON pf.PropertyId=Cte_Sum.PropertyId
LEFT OUTER JOIN dbo.PropertyExpense AS pe ON pe.PropertyId=Cte_Sum.PropertyId
)---calculating the yeild
SELECT cy.PropertyId,cy.sum_of_payments,cr.CurrentHomeValue,cr.Amount AS Expenses,
  ((cy.sum_of_payments-cr.Amount)/cr.CurrentHomeValue)*100 AS Yeild
FROM Cte_Sum  AS cy
INNER JOIN Cte_replace_null AS cr ON cy.PropertyId= cr.PropertyId