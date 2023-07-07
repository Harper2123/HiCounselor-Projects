import pandas as pd
import numpy as np
import warnings
warnings.filterwarnings("ignore")

def read_data_from_csv():
    hotels=pd.read_csv('zomato.csv')
    return hotels


def remove_unwanted_columns():
    #DO NOT REMOVE FOLLOWING LINE
    #call read_data_from_csv() function to get dataframe
    hotels=read_data_from_csv()
    
    #Columns which are to be deleted
    columns = ['address', 'phone']
    
    #Dropping the columns
    hotels.drop(columns, inplace=True, axis=1)
    
    return hotels


def rename_columns():
    #DO NOT REMOVE FOLLOWING LINE
    #call remove_unwanted_columns() function to get dataframe
    hotels = remove_unwanted_columns()
    
    #task2: rename columns,  only these columns are allowed in the dataset
    # 1.	Id
    # 2.	Name
    # 3.	online_order
    # 4.	book_table
    # 5.	rating
    # 6.	votes
    # 7.	location
    # 8.	rest_type
    # 9.	dish_liked
    # 10.	cuisines
    # 11.	approx_cost
    # 12.	type
    
    #Making the required changes
    hotels.rename(columns={'rate':'rating','approx_cost(for two people)':'approx_cost','listed_in(type)':'type'}, inplace=True)
    
    return hotels


#task3: handle  null values of each column
def null_value_check():
    #DO NOT REMOVE FOLLOWING LINE
    #call rename_columns() function to get dataframe
    hotels=rename_columns()
    
    #deleting null values of name column
    hotels.dropna(subset=['name'], inplace=True)
    
    #handling null values of online_order
    hotels['online_order'].fillna('NA', inplace=True)
    hotels['book_table'].fillna('NA', inplace=True)
    hotels['location'].fillna('NA', inplace=True)
    hotels['rest_type'].fillna('NA', inplace=True)
    hotels['cuisines'].fillna('NA', inplace=True)
    hotels['type'].fillna('NA', inplace=True)
    hotels['approx_cost'].fillna(0, inplace=True)
    hotels['rating'].fillna(0, inplace=True)
    hotels['votes'].fillna(0, inplace=True)
    hotels['dish_liked'].fillna('NA', inplace=True)
    
    return hotels


#task4 #find duplicates in the dataset
def find_duplicates():
    #DO NOT REMOVE FOLLOWING LINE
    #call null_value_check() function to get dataframe
    hotels=null_value_check()
    
    #droping the duplicates value keeping the first
    hotels.drop_duplicates(inplace=True)
    
    return hotels


#task5 removing irrelevant text from all the columns
def removing_irrelevant_text():
    #DO NOT REMOVE FOLLOWING LINE
    #call find_duplicates() function to get dataframe
    hotels= find_duplicates()
    
    hotels = hotels[hotels['name'].str.contains('RATED|Rated') == False]
    hotels = hotels[hotels['online_order'].str.contains('RATED|Rated') == False]
    hotels = hotels[hotels['book_table'].str.contains('RATED|Rated') == False]
    hotels = hotels[hotels['rating'].str.contains('RATED|Rated') == False]
    hotels = hotels[hotels['votes'].str.contains('RATED|Rated') == False]
    hotels = hotels[hotels['location'].str.contains('RATED|Rated') == False]
    hotels = hotels[hotels['rest_type'].str.contains('RATED|Rated') == False]
    hotels = hotels[hotels['dish_liked'].str.contains('RATED|Rated') == False]
    hotels = hotels[hotels['cuisines'].str.contains('RATED|Rated') == False]
    hotels = hotels[hotels['approx_cost'].str.contains('RATED|Rated') == False]
    hotels = hotels[hotels['type'].str.contains('RATED|Rated') == False]
    
    return hotels


#task6: check for unique values in each column and handle the irrelevant values
def check_for_unique_values():
    #DO NOT REMOVE FOLLOWING LINE
    #call removing_irrelevant_text() function to get dataframe
    hotels=removing_irrelevant_text()
    hotels = hotels[hotels['online_order'].str.contains('Yes|No') == True]
    hotels['rating'].replace('NEW',0,inplace=True)
    hotels['rating'].replace('-',0,inplace=True)
    hotels['rating'] = hotels['rating'].str.split('/').str[0]
    hotels['rating'].fillna(0, inplace=True)
    return hotels


#task7: remove the unknown character from the dataset and export it to "zomatocleaned.csv"
def remove_the_unknown_character():
    #DO NOT REMOVE FOLLOWING LINE
    #call check_for_unique_values() function to get dataframe
    dataframe=check_for_unique_values()
    dataframe['name'] = dataframe['name'].str.replace('[Ãx][^A-Za-z]+', '')


    #remove unknown character from dataset
    
    #export cleaned Dataset to newcsv file named "zomatocleaned.csv"
    dataframe.to_csv('zomato_cleaned_before_excel.csv')
    return dataframe


def main():
    remove_the_unknown_character()


if __name__ == '__main__':
    main()
