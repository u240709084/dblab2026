use company
DELIMITER $$
CREATE PROCEDURE SelectCustomerByCountry( IN c varchar(45))
BEGIN
SELECT * FROM Customers
Where Country = c;
END $$
DELIMITER $$

Set @country = "Spain";
Select @country;
Call SelectCustomerByCountry(@country);
Select @country

DELIMITER $$
CREATE procedure GetOrderCountByShipper( IN shipper varchar(45), OUT count INT)
BEGIN
select COUNT(OrderID) INTO count
from Orders
Join Shippers On Orders.ShipperID = Shippers.ShipperID
Where ShipperName = shipper;
END $$
DELIMITER ;

select ShipperName from Shippers;
set @order_cnt = 0;
select @order_cnt;
call GetOrderCountByShipper("United Package", @order_cnt);
select @order_cnt;

DELIMITER $$
CREATE procedure GetCustomerSalesOut(
IN inCustomerID INT,
out outName varchar(255),
out outSales float)
BEGIN
select CustomerName into outName
from Customers
where CustomerID = inCustomerID;

select ifnull(sum(p.Price * od.Quantity), 0) INTO outSales
from Orders o
join orderdetails od on o.OrderID = od.OrderID
join Products p on p.ProductID = od.ProductID
where o.CustomerID = inCustomerID;
END $$ 
DELIMITER $$

call GetCustomerSalesOut(5, @name, @sales); select @name, @sales;


