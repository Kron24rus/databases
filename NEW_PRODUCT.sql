set @mentalrelax = 8;

insert into shopdb.product (ProductID, name, price, buy_price, ProviderID, update_date, CategoryID)
values 
        (14, 'Rubics Cube', 1500, 500, @mentalrelax, '2018-12-12 14:00', @entertainment)
on duplicate key update ProductID = ProductID;

insert into shopdb.order (OrderID, total_cost, creation_date)
values
		(8, 2185, '2018-12-18 8:40')
on duplicate key update OrderID = OrderID;

insert into shopdb.order_product(OrderProductID, sell_price, quantity, discount, ProductID, OrderID)
values 
        (13, 1425, 1, 5, 14, 8),
        (14, 760, 1, 5, 10, 8)
on duplicate key update OrderProductID = OrderProductID;


-- delete from shopdb.order_product where OrderProductID = 13;
-- delete from shopdb.order_product where OrderProductID = 14;
-- delete from shopdb.order where OrderID = 8;
-- delete from shopdb.product where ProductID = 14;
