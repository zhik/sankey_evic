with
	cases as (
		select indexnumberid from oca_index
		where status != 'Active'
		and propertytype = 'Residential'
		and fileddate >= '2022-01-15'
		and (classification like '%Non-Payment%' or classification like '%Nonpayment%')
		and (court like 'New York County%' or court like 'Kings County%' or court like 'Bronx County%' or court like 'Richmond County%' or court like 'Queens County%')
	),
	
	default_judgments as (
		select indexnumberid from oca_judgments
		where (judgmenttype like '%Default%' or judgmenttype like '%Failure%')
		and sequence = 1
	),
	
	combined as (
		select cases.indexnumberid as id
		from cases left join default_judgments on default_judgments.indexnumberid = cases.indexnumberid
	)
	
	select count(id) as number_default_judgments from combined