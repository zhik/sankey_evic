import sqlalchemy as sa
from sqlalchemy import text
import pandas as pd
from dotenv import load_dotenv
import os

load_dotenv()
ENGINE = sa.create_engine(os.environ["DATABASE_URL"])

steps = {
    'pentiton': {
        'step2a':
        'step2b': {
            
        }
    }
}

query = f"""
    select * from (
	select indexnumberid, fileddate, status, disposedreason from oca_index
	where fileddate >= '2023-07-04'
	and 
	propertytype = 'Residential'
	and 
	(classification in ('Holdover', 'Non-Payment'))
	and
	status != 'Active'
	and
	disposedreason not LIKE 'Withdrawn%' ) as a 
	left join (select * from oca_appearances where appearancereason != 'New Appearance') as b on  a.indexnumberid = b.indexnumberid
"""
df = pd.read_sql(text(query), con = ENGINE)

print(df)
