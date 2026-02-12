from typing import Dict

import requests
import pandas as pd
from requests.exceptions import RequestException


def get_public_holidays(public_holidays_url: str, year: str, timeout: float = 10.0) -> pd.DataFrame:
    """Get the public holidays for the given year for Brazil.

    Args:
        public_holidays_url (str): url to the public holidays.
        year (str): The year to get the public holidays for.
        timeout (float): The timeout for the request in seconds.

    Raises:
        requests.exceptions.HTTPError: If the request to the public holidays API fails
        requests.exceptions.RequestException: For other request-related errors.
        ValueError: If the year seems invalid or the data has an unexpected format

    Returns:
        DataFrame: A dataframe with the public holidays.
    """

    # Basic year validation
    if not year.isdigit() or not (1900 <= int(year) <= 2100):
        raise ValueError(f"Invalid year: {year!r}")

    # URL construction
    url = f"{public_holidays_url.rstrip('/')}/{year}/BR"

    
    # connecting and calling to the API.
    try:
        response = requests.get(url, timeout=timeout)
        response.raise_for_status()           

        data = response.json()

        # Validating the response data format
        if not isinstance(data, list):
            raise ValueError("Unexpected data format received from the public holidays API.")

        if not data:
            return pd.DataFrame(columns=["date", "localName", "name", "countryCode"])

        df = pd.DataFrame(data)

        # Validating expected columns
        expected_cols = {"date", "localName", "name", "countryCode"}
        if not expected_cols.issubset(df.columns):
            raise ValueError(f"Missing expected columns. Found: {list(df.columns)}")

        # Converting the 'date' string type to a datetime data type.
        df["date"] = pd.to_datetime(df["date"], format="%Y-%m-%d", errors="coerce")

        # Dropping unused columns.
        cols_to_drop = ["counties", "types"]
        df = df.drop(columns=[c for c in cols_to_drop if c in df.columns])

        return df.sort_values("date").reset_index(drop=True)

    except requests.exceptions.HTTPError as e:
        raise requests.exceptions.HTTPError(f"Error fetching public holidays for year ({year}): {e}") from e
    except RequestException as e:
        raise RequestException(f"Error connecting to public holidays API: {e}") from e
    


def extract(
    csv_folder: str, csv_table_mapping: Dict[str, str], public_holidays_url: str
) -> Dict[str, pd.DataFrame]:
    """Extract the data from the csv files and load them into the dataframes.
    Args:
        csv_folder (str): The path to the csv's folder.
        csv_table_mapping (Dict[str, str]): The mapping of the csv file names to the
        table names.
        public_holidays_url (str): The url to the public holidays.
    Returns:
        Dict[str, DataFrame]: A dictionary with keys as the table names and values as
        the dataframes.
    """
    dataframes = {
        table_name: pd.read_csv(f"{csv_folder}/{csv_file}")
        for csv_file, table_name in csv_table_mapping.items()
    }

    holidays = get_public_holidays(public_holidays_url, "2017")

    dataframes["public_holidays"] = holidays

    return dataframes
