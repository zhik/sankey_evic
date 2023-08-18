import sqlalchemy as sa
from sqlalchemy import text
import pandas as pd
from dotenv import load_dotenv
import os

load_dotenv()
ENGINE = sa.create_engine(os.environ["DATABASE_URL"])

queries = [
	{'id': 'petition', 'next': 'amount_appearances'},
	{'id': 'amount_appearances', 'next': 'default_judgments'},
	{'id': 'default_judgments', 'next': None}
]

for query in queries:
	file_name = f'./query/{query["id"]}.sql'
	with open(file_name, 'r') as file:
		query = file.read().replace('<<<PLACEHOLDER FOR QUERY>>>', "and fileddate >= '2023-03-01'")
	df = pd.read_sql(text(query), con = ENGINE)

	print(df.transpose)

