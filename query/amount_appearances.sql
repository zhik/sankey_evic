select classification, 
	count(indexnumberid) as total,
	count(indexnumberid) filter (where appearances_num = 1) as one_appearance,
	count(indexnumberid) filter (where appearances_num > 1 and appearances_num < 8) as less_than_median,
	count(indexnumberid) filter (where appearances_num > 8) as greater_than_median
	from (
		select *, filed_date as fileddate from oca_case_summary
	) as a
	where appearances_num > 0
	and status != 'Active'
	<<<PLACEHOLDER FOR QUERY>>>
	and (classification like '%Holdover%' or classification like '%Non-Payment%' or classification like '%NonPayment%')
	and (court like 'New York County%' or court like 'Kings County%' or court like 'Bronx County%' or 
	court like 'Richmond County%' or court like 'Queens County%')
	
group by classification