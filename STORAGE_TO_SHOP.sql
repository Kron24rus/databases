insert into shopdb.category (CategoryID, name)
select cd.CategoryID, cd.name from storagedb.category_dim cd
on duplicate key update CategoryID = cd.CategoryID;

insert into shopdb.order (OrderID, creation_date, total_cost)
select od.ShopOrderID, od.creation_date, od.total_cost from storagedb.order_dim od
on duplicate key update OrderID = od.ShopOrderID; 

insert into shopdb.product (ProductID, name, price, buy_price, ProviderID, update_date, CategoryID)
select pd.ProductID, pd.name, sf.sell_price, pd.buy_price, sf.provider_dim_providerID, pd.update_date, sf.category_dim_categoryID from storagedb.product_dim pd 
inner join storagedb.sales_fact sf on pd.ProductID = sf.product_dim_productID
on duplicate key update ProductID = pd.ProductID;

insert into shopdb.provider (ProviderID, name, contact)
select prd.ProviderID, prd.name, prd.contact from storagedb.provider_dim prd
on duplicate key update ProviderID = prd.ProviderID;


insert into shopdb.order_product (OrderProductID, quantity, sell_price, discount, ProductID, OrderID)
select sf.order_productID, sf.quantity, sf.sell_price, sf.discount, sf.product_dim_productID, 
		(select od.ShopOrderID from storagedb.order_dim od where od.OrderID = sf.order_dim_orderID) 
from storagedb.sales_fact sf
on duplicate key update OrderProductID = sf.order_productID;