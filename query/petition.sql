with
	cases as (
		select * from oca_index
		where status != 'Active'
		and propertytype = 'Residential'
		and fileddate >= '2022-01-15'
		and (classification like '%Holdover%' or classification like '%Non-Payment%' or classification like '%Non-Payment%')
		and (court like 'New York County%' or court like 'Kings County%' or court like 'Bronx County%' or court like 'Richmond County%' or court like 'Queens County%')
	),
	
	parties as (
		select oca_parties.indexnumberid,
		max((role = 'Respondent' and representationtype != 'No Appearance')::int)::boolean as respondent_appeared
		from cases left join oca_parties on cases.indexnumberid = oca_parties.indexnumberid
		group by oca_parties.indexnumberid
	),
	
	appearance_cases as (
		select cases.indexnumberid as id , *
		from cases left join parties on cases.indexnumberid = parties.indexnumberid
		),
	query as (
			select 
			classification, 
			count(id) as total,
			count(id) filter (where respondent_appeared = true) as appeared,
			count(id) filter (where respondent_appeared = false) as no_appeared
		
		from appearance_cases
		group by classification
	)
	
select *, no_appeared/ total::float as percent_no_appear, appeared/total::float as percent_appeared  from query