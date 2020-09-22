## It's Mahvel Baby!! ##

![When's Mahvel?](https://i.kym-cdn.com/entries/icons/facebook/000/032/791/maxresdefault_(1).jpg)


For these questions, we will be using the Marvel Developer APIs. You will need to register for a new account toget an API key. https://developer.marvel.com/. The interactive documentation is helpful to see some sample results https://developer.marvel.com/docs. 

1. Retrieve a list of all characters. Loop through all pages and store these results 

### Complete in the fetch_all_characters fetch_all_characters function ###


2. Question: Who is featured in the most number of comics?


### Spider-Man with 3947 Comics ###


3. Create a CharacterFinder class that can accept the input/argument of a primary character (ex -Carnage) and will use the /v1/public/characters/{characterId} endpoint to populate all of their details and comics. The Marvel Universe often has many variations of each character so use exact text matching.

### Done -- get_by_names function ###

4. Build a new method of CharacterFinder that can take another secondary character's name and return the list of comics that both characters are in.

### Done -- get_by_names function ###


5. Instantiate one object of your CharacterFinder class using the characters Storm and Emma Frost(ordering does not matter). Use this object's method developed in Question 4 above. How many comics do these two characters appear together in?

### Done -- Storm and Emma Frost appear in 98 Comics together ###