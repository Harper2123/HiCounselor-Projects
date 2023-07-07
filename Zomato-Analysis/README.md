# Zomato-Analysis



## Background

This project is offered by [HiCounselor](https://hicounselor.com/projects). In this project, we work on a real-world dataset of Zomato,
one of the most used food ordering platform.
This project aims on cleaning the dataset, analyze the given dataset, and mining informational quality insights.


## Flow of Project

We start with a csv file named `zomato.csv`.
We then use the `data_preprocessing.py` to wrangle with the raw dataset and process it upto some extent.
The python script returns us a processed dataset `zomato_cleaned_before_excel`.

Now we use Excel to further process the dataset. We perform two steps:-
1. Removing the duplicate values.
2. Some of the rows at last, only contains ID, and every other column is empty, so we deleted those rows.

Now, we have a clean dataset `zomato_cleaned.csv`.

We then use MySQL to analyze the dataset and gain some insights. The SQL file `ZomatoAnalysis.sql` contains all the insights derived from the dataset within the scope of the project.
