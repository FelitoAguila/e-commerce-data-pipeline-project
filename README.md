# Sprint project 01
> E-Commerce Data Pipeline

## The Business problem

You are working for one of the largest E-commerce sites in Latam and they requested the Data Science team to analyze company data to understand better their performance in specific metrics during the years 2016-2018.

They are two main areas they want to explore, those are **Revenue** and *Delivery*.

Basically, they would like to understand how much revenue by year they got, which were the most and less popular product categories, and the revenue by state. On the other hand, it's also important to know how well the company is delivering the products sold in time and form to their users. For example, seeing how much takes to deliver a package depends on the month and the difference between the estimated delivery date and the real one.

## About the data

You will consume and use data from two sources.

The first one is a Brazilian e-commerce public dataset of orders made at the Olist Store, provided as CSVs files. This is real commercial data, that has been anonymized. The dataset has information on 100k orders from 2016 to 2018 made at multiple marketplaces in Brazil. Its features allow viewing orders from multiple dimensions: from order status, price, payment, and freight performance to customer location, product attributes and finally reviews written by customers. You will find an image showing the database schema at `images/data_schema.png`. To get the dataset please download it from this [link](https://drive.google.com/file/d/1HIy4LNNQESuXUj-u_mNJTCGCRrCeSbo-/view?usp=share_link), extract the `dataset` folder from the `.zip` file and place it into the root project folder. See **Project Structure**  section to validate you've placed the dataset as it's needed.

The second source is a public API: https://date.nager.at. You will use it to retrieve information about Brazil's Public Holidays and correlate that with certain metrics about the delivery of products.

## Technical aspects

Because the team knows the data will come from different sources and formats, also, probably you will have to provide these kinds of reports on a monthly or annual basis. They decided to build a data pipeline (ELT) they can execute from time to time to produce the results.

The technologies involved are:
- Python as the main programming language
- Pandas for consuming data from CSVs files
- Requests for querying the public holidays API
- SQLite as a database engine
- SQL as the main language for storing, manipulating, and retrieving data in our Data Warehouse
- Matplotlib and Seaborn for the visualizations
- Jupyter notebooks to make the report an interactive way

## Instalation

A `requirements.txt` file is provided with all the needed Python libraries for running this project. For installing the dependencies just run:

```console
$ pip install -r requirements.txt
```

*Note:* We encourage you to install those inside a virtual environment.

## Code Style

Following a style guide keeps the code's aesthetics clean and improves readability, making contributions and code reviews easier. Automated Python code formatters make sure your codebase stays in a consistent style without any manual work on your end. If adhering to a specific style of coding is important to you, employing an automated to do that job is the obvious thing to do. This avoids bike-shedding on nitpicks during code reviews, saving you an enormous amount of time overall.

We use [Black](https://black.readthedocs.io/) for automated code formatting in this project, you can run it with:

```console
$ black --line-length=88 .
```

Wanna read more about Python code style and good practices? Please see:
- [The Hitchhiker’s Guide to Python: Code Style](https://docs.python-guide.org/writing/style/)
- [Google Python Style Guide](https://google.github.io/styleguide/pyguide.html)

## Tests

We provide unit tests along with the project that you can run and check from your side the code meets the minimum requirements of correctness needed to approve. To run just execute:

```console
$ pytest tests/
```

If you want to learn more about testing Python code, please read:
- [Effective Python Testing With Pytest](https://realpython.com/pytest-python-testing/)
- [The Hitchhiker’s Guide to Python: Testing Your Code](https://docs.python-guide.org/writing/tests/)

# Instructions

## 1. Extract

For the pipeline data extraction phase, you will use the functions inside the `src/extract.py` module.

To check the code, you can test that particular module simply by running:

```console
$ pytest tests/test_extract.py
```

## 2. Load

Now you have all the data from different sources, it's time to store that in a Data Warehouse. We will use SQLite as our database engine to keep things simpler but, in larger companies, Snowflake is one of the most popular options for Data Warehouses these days.

Use the ``load()`` function inside the `src/load.py` module.

## 3. Transform

Having the data inside our Data Warehouse, we can start making queries and transformations.

All SQL queries are inside the `queries/` folder.

You can make use of other tools like DBeaver to write and test the queries in a more interactive way. Lastly, you can check if the queries meets the requirements by running the provided tests with:

```console
$ pytest tests/test_transform.py
```

You can also validate how the output from the query should look like checking the `.json` file under `tests/query_results` with the same name as the `.sql` file.

## 4. Visualize your results

Finally, having all the results from our queries, it's time to start making some visualization for the presentation.

For this, you should open the `AnyoneAI - Sprint Project 01.ipynb` Jupyter notebook provided.

## Project Structure

Let's take a deep overview of the project structure and each module inside:

```console
├── dataset
│   ├── olist_customers_dataset.csv
│   ├── olist_geolocation_dataset.csv
│   ├── olist_order_items_dataset.csv
│   ├── olist_order_payments_dataset.csv
│   ├── olist_order_reviews_dataset.csv
│   ├── olist_orders_dataset.csv
│   ├── olist_products_dataset.csv
│   ├── olist_sellers_dataset.csv
│   └── product_category_name_translation.csv
├── images
│   ├── data_schema.png
│   ├── freight_value_weight_relationship.png
│   └── orders_per_day_and_holidays.png
├── queries
│   ├── delivery_date_difference.sql
│   ├── global_ammount_order_status.sql
│   ├── real_vs_estimated_delivered_time.sql
│   ├── revenue_by_month_year.sql
│   ├── revenue_per_state.sql
│   ├── top_10_least_revenue_categories.sql
│   └── top_10_revenue_categories.sql
├── src
│   ├── __init__.py
│   ├── config.py
│   ├── extract.py
│   ├── load.py
│   ├── plots.py
│   └── transform.py
└── tests
│   ├── __init__.py
│   ├── query_results/
│   ├── test_extract.py
│   └── test_transform.py
├── ASSIGNMENT.md
├── AnyoneAI - Sprint Project 01.ipynb
├── README.md
└── requirements.txt
```

Now let's look at the main components:

### dataset

It has all the .csvs with the information that will be used in the project.

- `dataset/olist_customers_dataset.csv`: csv with info regarding the location of the customers.
- `dataset/olist_order_items_dataset.csv`: csv with info regarding the shipping.
- `dataset/olist_order_payments_dataset.csv`: csv with info regarding the payment.
- `dataset/olist_order_reviews_dataset.csv`: csv with info regarding the clients' reviews.
- `dataset/olist_orders_dataset.csv`: csv with info regarding the different dates of each sale's process.
- `dataset/olist_products_dataset.csv`: csv with info regarding the details of each product.
- `dataset/olist_sellers_dataset.csv`: csv with info regarding the location of the sellers.
- `dataset/product_category_name_translation.csv`: csv with info regarding the translation of each category from Portuguese to English.

### queries

It contains all the SQL queries to later create tables and plots.

- `queries/delivery_date_difference.sql`: This query will return a table with two columns; State, and Delivery_Difference. The first one will have the letters that identify the states, and the second one the average difference between the estimated delivery date and the date when the items were actually delivered to the customer.
- `queries/global_ammount_order_status.sql`: This query will return a table with two columns; order_status, and Amount. The first one will have the different order status classes and the second one the total amount of each.
- `queries/real_vs_estimated_delivered_time.sql`: This query will return a table with the differences between the real and estimated delivery times by month and year. It will have different columns: month_no, with the month numbers going from 01 to 12; month, with the 3 first letters of each month (e.g. Jan, Feb); Year2016_real_time, with the average delivery time per month of 2016 (NaN if it doesn't exist); Year2017_real_time, with the average delivery time per month of 2017 (NaN if it doesn't exist); Year2018_real_time, with the average delivery time per month of 2018 (NaN if it doesn't exist); Year2016_estimated_time, with the average estimated delivery time per month of 2016 (NaN if it doesn't exist); Year2017_estimated_time, with the average estimated delivery time per month of 2017 (NaN if it doesn't exist) and Year2018_estimated_time, with the average estimated delivery time per month of 2018 (NaN if it doesn't exist).
- `queries/revenue_by_month_year.sql`: This query will return a table with the revenue by month and year. It will have different columns: month_no, with the month numbers going from 01 to 12; month, with the 3 first letters of each month (e.g. Jan, Feb); Year2016, with the revenue per month of 2016 (0.00 if it doesn't exist); Year2017, with the revenue per month of 2017 (0.00 if it doesn't exist) and Year2018, with the revenue per month of 2018 (0.00 if it doesn't exist).
- `queries/revenue_per_state.sql`: This query will return a table with two columns; customer_state, and Revenue. The first one will have the letters that identify the top 10 states with the most revenue and the second one the total revenue of each.
- `queries/top_10_least_revenue_categories.sql`: This query will return a table with the top 10 least revenue categories in English, the number of orders, and their total revenue. The first column will be Category, which will contain the top 10 least revenue categories; the second one will be Num_order, with the total amount of orders of each category; and the last one will be Revenue, with the total revenue of each category.
- `queries/top_10_revenue_catgories.sql`: This query will return a table with the top 10 revenue categories in English, the number of orders, and their total revenue. The first column will be Category, which will contain the top 10 revenue categories; the second one will be Num_order, with the total amount of orders of each category; and the last one will be Revenue, with the total revenue of each category.

### src

The source that contains different files needed for the whole project to work.

- `src/_init__.py`: File required to make Python treat directories containing the other files in the folder as a package.
- `src/config.py`: File that contains the configuration of root paths.
- `src/extract.py`: File that extracts the data from the .csv and API files and loads them into dataframes.
- `src/load.py`: File that loads the dataframes into the SQLite databases.
- `src/plots.py`: File where all the plotting functions are.
- `src/transform.py`: File that transforms the queries into tables.

### tests

Folder with the necessary files to test the project.

- query_results: This folder contains all the .json files that will be used to test the queries you created.
- `tests/_init__.py`: File required to make Python treat directories containing the other files in the folder as a package.
- `tests/test_extract.py`: File that tests if the query functions have been extracted properly.
- `tests/test_transform.py`: File that tests if the query functions have been created in the proper tables.

### Others

- `requirements.txt`: File that contains all the libraries that need to be installed.
