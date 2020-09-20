# Price Variation based on Store Locations #


## Question ##

- Suppose you were redesigning the model for these tables. Let's say that we were expanding and nowneed to support variations in pricing and availability across locations. For example:item 1 at store 1 is $2.99item 1 at store 2 is $2.50If we were to simply add a store_location column to the items table, we would end up duplicating alot of data. This could cause issues when scaling. Similarly, the orders table has a lot of duplicateddata.We're looking more for discussion and diagrams for this question and not necessarily SQL


## Answer ##

> Since prices can be different at different retailers and even different locations at the same retailer we need to seperate price from the item level. For simplicity in the example I created a stores table that is that contains a retailer id and a name. In reality we would need to have a store_locations table as well so we could have different prices at each location vs. each retailer. Then we need to make a store_item_settings table that connects an item_id with a store_id that can have variations of price and availability. We would need to make sure there is no duplication of item_id and store_id in the table so we don't have duplicate data. 

![Diagram of Schema Relationships]
