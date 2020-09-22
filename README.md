# ETL Test #

I've broken each of the individual parts into their respective folder with SQL files where those are used and python in the question_3 folder. Discussion and answers to the questions are in the README.md for each specific part


## To Run Python File ##


``` 
Pipenv Install --dev
Pipenv shell
python question_3/marvel.py -p Storm -s Emma-Frost
```
If a character has a space in their name replace the space with a `-`


At this point all of the data is printing to the terminal. I'm working on schemas for the data or considering a faster approach of writing to CSV. 