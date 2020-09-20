
# Importing Product Categorizations #

## Questions ##

1. On every import, the data pipeline inserts the parent and child categories to a product_categorizations table for each product_id. A Shipt Catalog Analyst discovers that the Oranges are being listed with Vegetables instead of Fruits and added the correct mapping to the product_categorizations table. The new Partner says this is a common issue and it may take several weeks to correct the data feed. How would you address this issue? What modifications wouldyou make? You may edit any functions and/or create & modify tables.


2. Shipt Engineering just launched a new feature to support taxonomies that are now 3 tiers instead of a 2tier parent-child. Some product mappings will stay two levels, but others will now get grandchildcategories (example: Vegetables can be "Regular" and "Organic"). How would you structure the datamodel or imports to support this? What would a query to look like to find mappings for a product?



3. One of the products ("Organic Apples") doesn't have a category mapping. Without a mapping, the itemwon't appear in the Shipt catalog. How would you solve this problem, knowing that new productcategories regularly appear in the pipeline without warning?We're looking more for discussion and diagrams for these questions and not necessarily blocks of SQL.