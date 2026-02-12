from typing import Dict
import pandas as pd
from sqlalchemy.engine.base import Engine

def load(data_frames: Dict[str, pd.DataFrame], database: Engine):
    """Load the dataframes into the sqlite database.

    Args:
        data_frames (Dict[str, DataFrame]): A dictionary with keys as the table names
        and values as the dataframes.
    """

    for names, df in data_frames.items():
        df.to_sql(name = names, con = database, if_exists='replace')

