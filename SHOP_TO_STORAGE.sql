use storagedb;

insert into storagedb.category_dim (CategoryID, name)
select CategoryID, name from shopdb.category
where CategoryID not in (select CategoryID from storagedb.category_dim);

insert into storagedb.product_dim (ProductID, name, update_date, buy_price)
select p.ProductID, p.name, p.update_date, p.buy_price from shopdb.product p
where p.ProductID not in (select ProductID from storagedb.product_dim)
on duplicate key update update_date = p.update_date;

insert into storagedb.provider_dim (ProviderID, name, contact)
select ProviderID, name, contact from shopdb.provider
where ProviderID not in (select ProviderID from storagedb.provider_dim);

insert into storagedb.order_dim(ShopOrderID, total_cost, creation_date)
select OrderID, total_cost, creation_date from shopdb.order
where OrderID not in (select ShopOrderID from storagedb.order_dim);

insert into storagedb.shop_dim(ShopID, name, city, address, contact)
values 
		(1, 'AllInclusiveShop', 'Saint-Petersburg', 'Deep Web Address', 'www.test.com')
on duplicate key update ShopID = ShopID;

drop function if exists IsHolidayDate;
create function IsHolidayDate (dDate DATE)
	returns tinyint
	return DATE_FORMAT(dDate, "%d-%m") in (
		"01-01", "02-01", "03-01", 
		"04-01", "05-01", "06-01", 
		"07-01", "08-01", "23-02", 
		"08-03", "01-05", "09-05", 
		"12-06", "04-11"
	);

insert into storagedb.date_dim (year, month, day_of_month, weekend, holiday, date_time)
select YEAR(od.creation_date) as yr, MONTH(od.creation_date) as mt, DAY(od.creation_date) as dy, WEEKDAY(od.creation_date) > 4, IsHolidayDate(od.creation_date), od.creation_date from storagedb.order_dim od
where od.creation_date not in (select date_time from storagedb.date_dim);

drop function IsHolidayDate;

insert into storagedb.sales_fact (product_dim_productID, provider_dim_providerID, category_dim_categoryID, order_dim_orderID, quantity, sell_price, product_price, shop_dim_shopID, date_dim_dateID, order_productID)
(select p.ProductID, pr.ProviderID, cat.CategoryID, ord.OrderID, op.quantity, op.sell_price, p.price, 1, dd.DateID, op.OrderProductID
from shopdb.order_product op 
inner join shopdb.product p on op.ProductID = p.ProductID
inner join shopdb.order ord on ord.OrderID = op.OrderID
inner join shopdb.provider pr on pr.ProviderID = p.ProviderID
inner join shopdb.category cat on cat.CategoryID = p.CategoryID
inner join storagedb.date_dim dd on ord.creation_date = dd.date_time)
on duplicate key update product_dim_productID = product_dim_productID;









