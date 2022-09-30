--ALL available jobs--taking open,pending and in-progress status into consideration 
--and also active jobs from job media
SELECT ProviderId,
       j.PropertyId, 
	   OwnerId,
	   PaymentAmount,
	   JobStartDate,
	   JobEndDate,
      JobDescription,
	  js.Status
FROM dbo.Job AS j 
INNER JOIN  dbo.JobStatus AS js ON JS.Id=j.JobStatusId
WHERE js.Id =1
