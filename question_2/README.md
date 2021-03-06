
# Importing Product Categorizations #

## Questions ##

1. On every import, the data pipeline inserts the parent and child categories to a product_categorizations table for each product_id. A Shipt Catalog Analyst discovers that the Oranges are being listed with Vegetables instead of Fruits and added the correct mapping to the product_categorizations table. The new Partner says this is a common issue and it may take several weeks to correct the data feed. How would you address this issue? What modifications wouldyou make? You may edit any functions and/or create & modify tables.

### Answer ###
> My first thought is on each import check if that upc still has the same category (3_PRODUCE_VEGETABLES). If it has not been updated, then after the file import runs, override the category id to write to the product_categorizations table. A new table can be created called `invalid_retailer_categorizations` that can hold products that products that are identified as invalid categorizations. Once the product has an updated category from the retailer, it can be deleted from the `invalid_retailer_categorizations` table and just use the category_map that is linked to a shipt category. 


2. Shipt Engineering just launched a new feature to support taxonomies that are now 3 tiers instead of a 2tier parent-child. Some product mappings will stay two levels, but others will now get grandchildcategories (example: Vegetables can be "Regular" and "Organic"). How would you structure the datamodel or imports to support this? What would a query to look like to find mappings for a product?

### Answer ###
> The retailer category should be mapped to the most granual category possible. So if grandchild is possible it would be the preferred category. Sometimes though the retail categories are too generic and require that is higher in the taxonomy. The inserts into the `product_categorizations` table needs to have one entry for each category in the heirarchy. So in the `categories` table, there will be a category_id and parent_id. If parent_id is not null insert the current product_id and category_id to `product_categorizations`, then perform another query on the parent_id. Repeat until parent_id is null , inserting the category_id there. This would need to be a recuirsive function.

```
WITH base_data AS (SELECT 
    ip.product_id,
    ip.category,
    cm.terminal_category_id
    FROM
    test.imported_products ip
    JOIN test.category_map cm on cm.category_key = ip.category
    ORDER BY product_id ASC)
SELECT * FROM base_data;
```

```
for index, row in df.iterrows():
    query = """
        SELECT category_id, parent_category_id FROM test.categories
        WHERE category_id = {row['terminal_category_id]}
        """
        ..... execute above query.... return result df

    if result.parent_category_id == NONE:
        insert_statement = """
        INSERT INTO product_categorizations
        (product_id, category_id)
        VALUES(row['product_id], row['category_id]);
        """

        ...... execute insert_statment.....

        continue
    else:
        insert_statement = """
        INSERT INTO product_categorizations
        (product_id, category_id)
        VALUES(row['product_id], row['category_id]);
        """

        ..... execute insert_statement .....

        ...execute query again, but replace row['terminal_category_id`] with result['parent_category_id'].....

        insert_statment = """
        INSERT INTO product_categorizations 
        (product_id, category_id)
        VALUES
        (row['product_id'], result['category_id]),
        (row['product_id']), result['parent_id']();

        ..... execute final insert for category_id, iterate through dataframe....



```


3. One of the products ("Organic Apples") doesn't have a category mapping. Without a mapping, the item won't appear in the Shipt catalog. How would you solve this problem, knowing that new product categories regularly appear in the pipeline without warning? We're looking more for discussion and diagrams for these questions and not necessarily blocks of SQL.

### Answer ###
> A little out of my knowledge here but I would try and set up a repo to predict where products should be categorized based off what our catalog team has already performed. Find data that they say is pristine (Golden Products is a good example) and then perform matching on incoming products to existing products. If the match is above 75% we can feel pretty confident that it belongs in that category, just higher up in the taxonomy. Maybe place in parent, child vs going to the most terminal possible. 