insert into shopdb.provider (ProviderID, name, contact, creation_date)
values 
		(1, 'Colors INC', 'Saint-Petersburg, New Street 18, tel: 212-22-15', '2016-05-24 14:00'),
        (2, 'New Horizons', 'Moscow, Old Street 45, tel: 243-33-12', '2017-03-17 14:00'),
        (3, 'War Machines', 'Krasnoyarsk, Cosmo Street 45a', '2015-02-11 14:00'),
        (4, 'Junk Food', 'Saint-Petersburg, Sennaya Ploshad 4', '2009-01-21 14:00'),
        (5, 'Musical Shop', 'Berlin, Main Street 1', '2018-11-03 14:00'),
        (6, 'Video Shop', 'Canada, Winter Street 31', '2018-03-07 14:00'),
        (7, 'Old Books', 'Minsk, Potato Street 7', '2014-05-24 14:00'),
        (8, 'Mental Relax', 'Sochi, New Street 14', '2012-12-12 14:00')
on duplicate key update ProviderID = ProviderID;

set @colorsinc = 1;
set @horizons = 2;
set @warmachines = 3;
set @junkfood = 4;
set @musicalshop = 5;
set @videoshop = 6;
set @oldbooks = 7;
set @mentalrelax = 8;

insert into shopdb.category (CategoryID, name, creation_date)
values 
		(1, 'dye', '2014-02-03 09:00'),
        (2, 'musical instruments', '2017-02-03 09:00'),
        (3, 'weapons', '2009-02-03 09:00'),
        (4, 'soothing', '2018-05-05 09:00'),
        (5, 'food', '2017-03-03 09:00'),
        (6, 'drinks', '2017-03-03 09:00'),
        (7, 'books', '2009-03-03 09:00'),
        (8, 'education', '2018-11-11 09:00'),
        (9, 'entertainment', '2017-11-12 09:00'),
        (10, 'sport', '2018-12-12 09:00')
on duplicate key update CategoryID = CategoryID;

set @dye = 1;
set @musical = 2;
set @weapons = 3;
set @soothing = 4;
set @food = 5;
set @drinks = 6;
set @books = 7;
set @education = 8;
set @entertainment = 9;
set @sport = 10;

insert into shopdb.order (OrderID, total_cost, creation_date)
values
		(1, 26125, '2018-03-03 13:40'),
        (2, 325000, '2018-04-04 11:43'),
        (3, 500, '2018-05-05 12:20'),
        (4, 1875, '2018-06-06 17:00'),
        (5, 3135, '2018-07-07 17:00'),
        (6, 2660, '2018-07-07 17:30'),
        (7, 3685.5, '2018-08-08 09:00')
on duplicate key update OrderID = OrderID;

set @guitarsbuyer = 1;
set @weaponbuyer = 2;
set @booksbuyer = 3;
set @junkbuyer = 4;
set @entertainmentbuyer = 5;
set @sportbuyer = 6;
set @complexbuyer = 7;

insert into shopdb.product (ProductID, name, price, buy_price, ProviderID, update_date, CategoryID)
values 
		(1, 'red dye - 10kg', 150, 50, @colorsinc, '2018-03-03 14:00', @dye),
        (2, 'acoustic guitar MS', 7500, 5000, @musicalshop, '2018-04-04 14:00', @musical),
        (3, 'electric guitar MS', 20000, 11000, @musicalshop, '2018-05-05 14:00', @musical),
        (4, 'UMP-45', 65000, 15000, @warmachines, '2018-06-06 14:00', @weapons),
        (5, 'fidget cube', 300, 50, @mentalrelax, '2018-06-07 14:00', @soothing),
        (6, 'burger', 375, 100, @junkfood, '2018-06-08 14:00', @food),
        (7, 'lemonade', 100, 50, @junkfood, '2018-06-09 14:00', @drinks),
        (8, 'Modern Programming Languages', 1095, 500, @oldbooks, '2018-07-10 14:00', @education),
        (9, 'Dictionary English-Computer', 500, 350, @oldbooks, '2018-11-07 14:00', @books),
        (10, 'Board game: Munchkin', 800, 500, @mentalrelax, '2018-12-12 14:00', @entertainment),
        (11, 'Body Bar 5kg', 1150, 500, @horizons, '2018-08-03 14:00', @sport),
        (12, 'jumping-rope 2m', 500, 300, @horizons, '2018-08-04 14:00', @sport),
        (13, 'New Lion King', 2500, 1000, @videoshop, '2018-11-11 14:00', @entertainment)
on duplicate key update ProductID = ProductID;

insert into shopdb.order_product(OrderProductID, quantity, sell_price, discount, ProductID, OrderID)
values 
		(1, 1, 7125, 5, 2, @guitarsbuyer),
        (2, 1, 19000, 5, 3, @guitarsbuyer),
        (3, 5, 65000, 0, 4, @weaponbuyer),
        (4, 1, 500, 0, 9, @booksbuyer),
        (5, 5, 375, 0, 6, @junkbuyer),
        (6, 1, 2375, 5, 13, @entertainmentbuyer),
        (7, 1, 760, 5, 10, @entertainmentbuyer),
        (8, 2, 1092.5, 5, 11, @sportbuyer),
        (9, 1, 475, 5, 12, @sportbuyer),
        (10, 1, 2250, 10, 13, @complexbuyer),
        (11, 1, 985.5, 10, 8, @complexbuyer),
        (12, 5, 90, 10, 7, @complexbuyer)
on duplicate key update OrderProductID = OrderProductID;