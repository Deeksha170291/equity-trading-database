-- created a equity trading database to store all the information about user ,transaction ,order ,market data and their portfolio.
create database equity_db;
use equity_db;
-- user table conatin all the information about user --
CREATE TABLE User (
    UserID INT PRIMARY KEY,
    Username VARCHAR(255),
    Email VARCHAR(255),
    PasswordHash VARCHAR(255),
    AccountType VARCHAR(255),
    CreatedAt TIMESTAMP
);
insert into user (userid ,username,Email,PasswordHash ,Accounttype,createdat)
values
(1,'deeksha','d@gmail.com','enteredpassword','individual','2024-01-01 10:00:00'),
(2,'dixa','ab@gmail.com','secretpassword','individual','2024-02-01 10:00:00'),
(3,'abc','abc@gmail.com','eedpassword','individual','2024-04-01 10:00:00'),
(4,'def','def@gmail.com','teredpassword','individual','2024-05-01 10:00:00'),
(5,'gef','gef@gmail.com', 'enredpassword','individual','2024-06-01 10:00:00');

select * from user;

-- Stock Table
CREATE TABLE Stock (
    StockID INT PRIMARY KEY,
    Symbol VARCHAR(255),
    CompanyName VARCHAR(255),
    Market VARCHAR(255),
    Sector VARCHAR(255)
);
insert into Stock (stockId , Symbol ,Companyname ,Market ,Sector)
values
(101,'AAPL', 'Apple Inc.', 'NSE','Technology'),
(102,'IEX', 'Indian energy exchange', 'NSE' ,'power'),
(103,'TCS' , 'Tata Consultancy Services' , 'NSE','INFORMATI0N TECHNOLOGY' ),
(104,'HDFCBANK' , 'Hdfc Bank', 'NSE' ,'BANKING' ),
(105,'RELAINCE' , 'Reliance ind' , 'NSE','REFINARY');

select * from stock;
-- Portfolio Table
CREATE TABLE Portfolio (
    PortfolioID INT PRIMARY KEY,
    UserID INT,
    TotalValue DECIMAL(18,2),
    CreatedAt TIMESTAMP,
    FOREIGN KEY (UserID) REFERENCES User(UserID)
);

insert into Portfolio
(PortfolioId , Userid,Totalvalue,createdAt)
values
(500, 1 ,0,'2024-01-01 10:00:00'),
(501, 2 ,0 ,'2024-02-01 10:00:00'),
(502, 3 ,0 ,'2020-01-01 10:00:00'),
(503, 4 ,0 ,'2021-01-01 10:00:00'),
(504, 5 ,0,'2024-01-01 10:00:00');

select * from portfolio;


-- Transaction Table
CREATE TABLE Transaction (
    TransactionID INT PRIMARY KEY,
    UserID INT,
    StockID INT,
    TransactionType VARCHAR(255),
    Quantity INT,
    Price DECIMAL(18,2),
    Timestamp TIMESTAMP,
    FOREIGN KEY (UserID) REFERENCES User(UserID),
    FOREIGN KEY (StockID) REFERENCES Stock(StockID)
);
insert into Transaction(Transactionid ,userid,stockid,TransactionType,Quantity,Price,Timestamp)
Values
(1001,1,101,'buy',500,250,'2024-01-01 10:00:00'),
(1002,2,101,'sell',500,250,'2024-01-01 10:00:00');


-- MarketData Table
CREATE TABLE MarketData (
    MarketDataID INT PRIMARY KEY,
    StockID INT,
    Price DECIMAL(18,2),
    Volume INT,
    Timestamp TIMESTAMP,
    FOREIGN KEY (StockID) REFERENCES Stock(StockID)
);

insert into MarketData (
MArketdataid ,Stockid , Price , volume ,timestamp )
values 
(1001 , 101 , 250 ,100000, '2024-01-01 10:00:00');

insert into marketdata 
values
(1002,102,50,20000,'2024-01-01 10:00:00'),
(1003,103,200,200000,'2024-01-01 10:00:00'),
(1004,104,200,20000,'2024-01-01 10:00:00'),
(1005,105,2000,500000,'2024-01-01 10:00:00');
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    UserID INT,
    StockID INT,
    OrderType VARCHAR(255),
    Quantity INT,
    Price DECIMAL(18,2),
    Status VARCHAR(255),
    Timestamp TIMESTAMP,
    FOREIGN KEY (UserID) REFERENCES User(UserID),
    FOREIGN KEY (StockID) REFERENCES Stock(StockID)
);

insert into orders (orderid ,userid ,stockid ,ordertype, quantity ,price, status,timestamp )
values
(123,1,101,'limit',1100 , 250 ,'pending' ,null ),
(122 ,1, 101 ,'market' ,1000 ,250 ,'executed' ,'2024-01-01 10:00:00');


insert into orders (orderid ,userid ,stockid ,ordertype, quantity ,price, status,timestamp )
values
(124 ,2, 103 ,'market' ,1000 ,250 ,'executed' ,'2024-01-01 10:00:00'),
(125 ,2, 103 ,'market' ,1000 ,250 ,'executed' ,'2024-01-01 10:00:00');

insert into orders (orderid ,userid ,stockid ,ordertype, quantity ,price, status,timestamp )
values
(126 ,3, 102 ,'market' ,1000 ,50 ,'executed' ,'2024-01-01 10:00:00'),
(127 ,3, 102 ,'market' ,1000 ,50 ,'executed' ,'2024-01-01 10:00:00'),
(128 ,4, 104 ,'market' ,1000 ,50 ,'executed' ,'2024-01-01 10:00:00'),
(129 ,4, 104 ,'market' ,1000 ,50 ,'executed' ,'2024-01-01 10:00:00'),
(121 ,5, 105 ,'market' ,1000 ,150 ,'executed' ,'2024-01-01 10:00:00'),
(120 ,5, 105 ,'market' ,1000 ,150 ,'executed' ,'2024-01-01 10:00:00');


-- join between table orders and users to find out the order status of users

SELECT Orders.OrderID, user.Username, Orders.ordertype,orders.status ,orders.timestamp
FROM Orders
INNER JOIN user ON Orders.userID = user.userID;
--- join portfolio table and user table to get the total value associated with user ----
select u.username ,p.totalvalue 
from user u
join portfolio  p on u.userid =p.userid;


-- nested query example--it will give the username and their account type with portfolio greater than 40000 ---


select
u.username , u.accounttype
from
USER u
where
u.userid in
(select
p.userid
from
portfolio p
where
p.totalvalue > 40000);

--- created a trigger whenever transactiontype is buy/sell it wiil be updated into the portfolio ---

DELIMITER //

CREATE TRIGGER updateportfolio
AFTER INSERT ON transaction
FOR EACH ROW
BEGIN
    DECLARE total_value DECIMAL(18, 2);

    -- Calculate the total value of the order
    SET total_value = NEW.Quantity * NEW.Price;

    -- Update the portfolio based on the order type
    IF NEW.transactionType = 'buy' THEN
        UPDATE Portfolio
        SET TotalValue = TotalValue + total_value
        WHERE UserID = NEW.UserID;
    ELSE IF NEW.transactionType = 'sell' THEN
        UPDATE Portfolio
        SET TotalValue = TotalValue - total_value
        WHERE UserID = NEW.UserID;
    END IF;
end if ;
end //
delimiter ;


select * from portfolio;
select * from transaction;

insert into transaction values( 1003 , 1 ,101 ,'buy',500 ,50 ,'2024-07-31 0:00:00');
insert into transaction values( 1004, 1 ,101 ,'buy',500 ,50 ,'2024-07-31 0:00:00');
insert into transaction values( 1005, 2 ,102,'buy',500 ,50 ,'2024-07-31 0:00:00');
insert into transaction values( 1006, 2 ,102,'sell',500 ,50 ,'2024-07-31 0:00:00');
insert into transaction values( 1007, 2 ,102,'buy',500 ,50 ,'2024-07-31 0:00:00');
insert into transaction values( 1008, 3 ,103,'buy',500 ,50 ,'2024-07-31 0:00:00');
insert into transaction values( 1009, 4 ,104,'sell',500 ,50 ,'2024-07-31 0:00:00');
insert into transaction values( 1010, 5 ,103,'buy',500 ,50 ,'2024-07-31 0:00:00');
insert into transaction values( 1011, 3 ,105,'sell',500 ,50 ,'2024-07-31 0:00:00');



-- procrdure to use all the order by using userid--

delimiter //
CREATE PROCEDURE GetUserOrders(IN userID INT)
BEGIN
    SELECT 
        Orders.OrderID,
        Orders.Quantity,
        Orders.Price,
        Orders.OrderType,
        Orders.timestamp,
        Stock.Symbol,
        Stock.CompanyName
    FROM 
        Orders
    JOIN 
        Stock ON Orders.StockID = Stock.StockID
    WHERE 
        Orders.UserID = userID;
END//
delimiter ;

 CALL GetUserOrders(2);

-- It groups the results by StockID and filters out any stocks that have more than 2 transaction.

SELECT StockID, COUNT(transactionid) AS NumberOftransaction
FROM transaction
GROUP BY StockID
HAVING COUNT(TransactionID) > 2;


-- this view is created to retrive username with ascending order with all the transaction details

CREATE VIEW UserOrderStockTransaction AS
SELECT 
    User.UserID, 
    User.UserName, 
    Orders.OrderID, 
    Orders.StockID, 
    Orders.Quantity, 
    Stock.Symbol, 
    Transaction.TransactionID, 
    Transaction.Price,
    transaction.transactiontype

FROM User
JOIN Orders ON User.UserID = Orders.UserID
JOIN Stock ON Orders.StockID = Stock.StockID
JOIN Transaction ON Orders.stockID = Transaction.stockID;


SELECT 
    UserName, 
    OrderID, 
    Symbol, 
    Quantity, 
    Price,
    transactiontype,
    price*quantity as total
FROM UserOrderStockTransaction
ORDER BY UserName ASC, OrderID ASC;


ALTER TABLE Orders
ADD COLUMN TotalValue DECIMAL(18, 2);
UPDATE Orders
SET TotalValue = Quantity * Price;

select * from orders;



-- function to create total order value of the given user id --
delimiter //
CREATE FUNCTION GetTotalOrderValue(UserID INT)
RETURNS DECIMAL(18,2)
BEGIN
    DECLARE totalValue DECIMAL(18,2);
    SELECT SUM(Orders.Quantity * orders.Price) INTO totalValue
    FROM Orders
    
    WHERE Orders.UserID = UserID;
    RETURN totalValue;
END//
delimiter ;


SELECT GetTotalOrderValue(1) AS totalValue;

















