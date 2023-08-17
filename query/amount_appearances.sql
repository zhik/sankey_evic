select classification, 
	count(indexnumberid) as total,
	count(indexnumberid) filter (where appearances_num = 1) as app_1,
	count(indexnumberid) filter (where appearances_num > 1 and appearances_num < 8) as app_2_8,
	count(indexnumberid) filter (where appearances_num > 8) as app_8_plus
	from (
		select *, filed_date as fileddate from oca_case_summary
	) as a
	where appearances_num > 0
	and status != 'Active'
	<<<PLACEHOLDER FOR QUERY>>>
	and (classification like '%Holdover%' or classification like '%Non-Payment%' or classification like '%Non-Payment%')
	and (court like 'New York County%' or court like 'Kings County%' or court like 'Bronx County%' or 
	court like 'Richmond County%' or court like 'Queens County%')
	
group by classification