insert into shopdb.product (ProductID, name, price, buy_price, ProviderID, update_date, CategoryID)
values 
        (14, 'Rubics Cube', 1500, 500, @mentalrelax, '2018-12-12 14:00', @entertainment)
on duplicate key update ProductID = ProductID;

insert into shopdb.order (OrderID, total_cost, creation_date)
values
		(8, 2185, '2018-12-18 8:40')
on duplicate key update OrderID = OrderID;

insert into shopdb.order_product(OrderProductID, quantity, sell_price, discount, ProductID, OrderID)
values 
        (13, 1425, 5, 14, 8),
        (14, 760, 5, 10, 8)
on duplicate key update OrderProductID = OrderProductID;