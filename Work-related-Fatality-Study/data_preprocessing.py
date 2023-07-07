import pandas as pd
import numpy as np


# Task 1: Read the given dataset
def read_data_from_csv():
    # df =read the 'fatality.csv' file
    df = pd.read_csv('fatality.csv')
    return df


# Task 2: Clean the given dataset
def data_cleaning():
    # do not edit the predefined function name
    df = read_data_from_csv()
    # Remove the 'Unnamed' column
    df.drop(columns=['Unnamed'], inplace=True)
    return df


# Task 3: Export the cleaned dataset to "fatalities_cleaned.csv"
def export_the_dataset():
    # do not edit the predefined function name
    df = data_cleaning()
    # write your code to export the cleaned dataset and set the index=false and return the same as 'df'
    df.to_csv('fatalities_cleaned.csv', index=False)

