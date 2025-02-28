import psycopg2
from psycopg2.extras import execute_values
import pandas as pd

from common.config import settings


def execute_db_action(query, values=None, fetch=False):
    """Execute a database action and return results if fetch is True."""
    with ExecuteQuery() as executor:
        if fetch:
            return executor.execute_query_and_fetch_data(query, values)
        else:
            executor.execute_query(query, values)


def perform_bulk_operation(query, data):
    with ExecuteQuery() as executor:
        executor.bulk_insert_to_db(query, data)


class ExecuteQuery:
    def __enter__(self):
        self.conn = psycopg2.connect(connect_timeout=10, **settings.database_config)
        self.cursor = self.conn.cursor()
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        if self.conn:
            self.conn.close()

    def execute_query_with_df_output(self, query, params=None):
        try:
            return pd.read_sql_query(query, con=self.conn, params=params)
        except psycopg2.Error as e:
            raise Exception(f"Error when executing query: {e}")

    def execute_query_and_fetch_data(self, query, params=None):
        try:
            self.cursor.execute(query, params)
            return self.cursor.fetchall()
        except psycopg2.Error as e:
            raise Exception(f"Error when executing query: {e}")

    def execute_query_and_fetch_one(self, query, params=None):
        try:
            self.cursor.execute(query, params)
            return self.cursor.fetchone()
        except psycopg2.Error as e:
            raise Exception(f"Error when executing query: {e}")

    def execute_query(self, query, params=None):
        try:
            self.cursor.execute(query, params)
            self.conn.commit()
        except psycopg2.Error as e:
            self.conn.rollback()
            raise Exception(f"Error when executing query: {e}")

    def bulk_insert_to_db(self, query, data):
        try:
            # Correctly use execute_values from psycopg2.extras
            execute_values(self.cursor, query, data)
            self.conn.commit()
        except psycopg2.Error as e:
            self.conn.rollback()
            raise Exception(f"Error when executing query: {e}")

