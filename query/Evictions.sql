with
	cases as (
		select indexnumberid from oca_index
		where status != 'Active'
		and propertytype = 'Residential'
		and fileddate >= '2022-01-15'
		and (classification like '%Non-Payment%' or classification like '%Nonpayment%')
		and (court like 'New York County%' or court like 'Kings County%' or court like 'Bronx County%' or court like 'Richmond County%' or court like 'Queens County%')
	),
	
	warrants as (
		select indexnumberid from oca_warrants	
		where createdreason = 'Original Issuance'
	),
	
	combined as (
		select cases.indexnumberid as id
		from cases left join warrants on warrants.indexnumberid = cases.indexnumberid
	)
	
	select count(id) as number_eviction_warrants from combined