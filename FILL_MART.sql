insert into storagedb.shop_popular_categories (shop_name, shop_address, category_name, quantity)
select sd.address, sd.name, (select name from storagedb.category_dim cd where cd.CategoryID = sf.category_dim_categoryID) categoryName, sf.quantity
from storagedb.shop_dim sd
inner join storagedb.sales_fact sf on sd.ShopID = sf.shop_dim_shopID;
