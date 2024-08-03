CREATE DATABASE  IF NOT EXISTS `equity_db` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `equity_db`;
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: equity_db
-- ------------------------------------------------------
-- Server version	5.7.44-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `marketdata`
--

DROP TABLE IF EXISTS `marketdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `marketdata` (
  `MarketDataID` int(11) NOT NULL,
  `StockID` int(11) DEFAULT NULL,
  `Price` decimal(18,2) DEFAULT NULL,
  `Volume` int(11) DEFAULT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`MarketDataID`),
  KEY `StockID` (`StockID`),
  CONSTRAINT `marketdata_ibfk_1` FOREIGN KEY (`StockID`) REFERENCES `stock` (`StockID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `marketdata`
--

LOCK TABLES `marketdata` WRITE;
/*!40000 ALTER TABLE `marketdata` DISABLE KEYS */;
INSERT INTO `marketdata` VALUES (1001,101,250.00,100000,'2024-01-01 10:00:00');
/*!40000 ALTER TABLE `marketdata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `OrderID` int(11) NOT NULL,
  `UserID` int(11) DEFAULT NULL,
  `StockID` int(11) DEFAULT NULL,
  `OrderType` varchar(255) DEFAULT NULL,
  `Quantity` int(11) DEFAULT NULL,
  `Price` decimal(18,2) DEFAULT NULL,
  `Status` varchar(255) DEFAULT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `TotalValue` decimal(18,2) DEFAULT NULL,
  PRIMARY KEY (`OrderID`),
  KEY `UserID` (`UserID`),
  KEY `StockID` (`StockID`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `user` (`UserID`),
  CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`StockID`) REFERENCES `stock` (`StockID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (120,5,105,'market',1000,150.00,'executed','2024-08-01 13:35:46',150000.00),(121,5,105,'market',1000,150.00,'executed','2024-08-01 13:35:46',150000.00),(122,1,101,'market',1000,250.00,'executed','2024-08-01 13:35:46',250000.00),(123,1,101,'limit',1100,250.00,'pending','2024-08-01 13:35:46',275000.00),(124,2,103,'market',1000,250.00,'executed','2024-08-01 13:35:46',250000.00),(125,2,103,'market',1000,250.00,'executed','2024-08-01 13:35:46',250000.00),(126,3,102,'market',1000,50.00,'executed','2024-08-01 13:35:46',50000.00),(127,3,102,'market',1000,50.00,'executed','2024-08-01 13:35:46',50000.00),(128,4,104,'market',1000,50.00,'executed','2024-08-01 13:35:46',50000.00),(129,4,104,'market',1000,50.00,'executed','2024-08-01 13:35:46',50000.00);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `portfolio`
--

DROP TABLE IF EXISTS `portfolio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `portfolio` (
  `PortfolioID` int(11) NOT NULL,
  `UserID` int(11) DEFAULT NULL,
  `TotalValue` decimal(18,2) DEFAULT NULL,
  `CreatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`PortfolioID`),
  KEY `UserID` (`UserID`),
  CONSTRAINT `portfolio_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `user` (`UserID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `portfolio`
--

LOCK TABLES `portfolio` WRITE;
/*!40000 ALTER TABLE `portfolio` DISABLE KEYS */;
INSERT INTO `portfolio` VALUES (500,1,50000.00,'2024-08-01 13:15:10'),(501,2,25000.00,'2024-08-01 13:15:10'),(502,3,0.00,'2024-08-01 13:15:10'),(503,4,-25000.00,'2024-08-01 13:15:10'),(504,5,25000.00,'2024-08-01 13:15:10');
/*!40000 ALTER TABLE `portfolio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stock`
--

DROP TABLE IF EXISTS `stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock` (
  `StockID` int(11) NOT NULL,
  `Symbol` varchar(255) DEFAULT NULL,
  `CompanyName` varchar(255) DEFAULT NULL,
  `Market` varchar(255) DEFAULT NULL,
  `Sector` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`StockID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stock`
--

LOCK TABLES `stock` WRITE;
/*!40000 ALTER TABLE `stock` DISABLE KEYS */;
INSERT INTO `stock` VALUES (101,'AAPL','Apple Inc.','NSE','Technology'),(102,'IEX','Indian energy exchange','NSE','power'),(103,'TCS','Tata Consultancy Services','NSE','INFORMATI0N TECHNOLOGY'),(104,'HDFCBANK','Hdfc Bank','NSE','BANKING'),(105,'RELAINCE','Reliance ind','NSE','REFINARY');
/*!40000 ALTER TABLE `stock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction`
--

DROP TABLE IF EXISTS `transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaction` (
  `TransactionID` int(11) NOT NULL,
  `UserID` int(11) DEFAULT NULL,
  `StockID` int(11) DEFAULT NULL,
  `TransactionType` varchar(255) DEFAULT NULL,
  `Quantity` int(11) DEFAULT NULL,
  `Price` decimal(18,2) DEFAULT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`TransactionID`),
  KEY `UserID` (`UserID`),
  KEY `StockID` (`StockID`),
  CONSTRAINT `transaction_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `user` (`UserID`),
  CONSTRAINT `transaction_ibfk_2` FOREIGN KEY (`StockID`) REFERENCES `stock` (`StockID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction`
--

LOCK TABLES `transaction` WRITE;
/*!40000 ALTER TABLE `transaction` DISABLE KEYS */;
INSERT INTO `transaction` VALUES (1001,1,101,'buy',500,250.00,'2024-01-01 10:00:00'),(1002,2,101,'sell',500,250.00,'2024-01-01 10:00:00'),(1003,1,101,'buy',500,50.00,'2024-07-30 23:00:00'),(1004,1,101,'buy',500,50.00,'2024-07-30 23:00:00'),(1005,2,102,'buy',500,50.00,'2024-07-30 23:00:00'),(1006,2,102,'sell',500,50.00,'2024-07-30 23:00:00'),(1007,2,102,'buy',500,50.00,'2024-07-30 23:00:00'),(1008,3,103,'buy',500,50.00,'2024-07-30 23:00:00'),(1009,4,104,'sell',500,50.00,'2024-07-30 23:00:00'),(1010,5,103,'buy',500,50.00,'2024-07-30 23:00:00'),(1011,3,105,'sell',500,50.00,'2024-07-30 23:00:00');
/*!40000 ALTER TABLE `transaction` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER updateportfolio
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
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `UserID` int(11) NOT NULL,
  `Username` varchar(255) DEFAULT NULL,
  `Email` varchar(255) DEFAULT NULL,
  `PasswordHash` varchar(255) DEFAULT NULL,
  `AccountType` varchar(255) DEFAULT NULL,
  `CreatedAt` date DEFAULT NULL,
  PRIMARY KEY (`UserID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'deeksha','d@gmail.com','enteredpassword','individual','2024-01-01'),(2,'dixa','ab@gmail.com','secretpassword','individual','2024-02-01'),(3,'abc','abc@gmail.com','eedpassword','individual','2024-04-01'),(4,'def','def@gmail.com','teredpassword','individual','2024-05-01'),(5,'gef','gef@gmail.com','enredpassword','individual','2024-06-01');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `userorderstocktransaction`
--

DROP TABLE IF EXISTS `userorderstocktransaction`;
/*!50001 DROP VIEW IF EXISTS `userorderstocktransaction`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `userorderstocktransaction` AS SELECT 
 1 AS `UserID`,
 1 AS `UserName`,
 1 AS `OrderID`,
 1 AS `StockID`,
 1 AS `Quantity`,
 1 AS `Symbol`,
 1 AS `TransactionID`,
 1 AS `Price`,
 1 AS `transactiontype`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'equity_db'
--

--
-- Dumping routines for database 'equity_db'
--
/*!50003 DROP FUNCTION IF EXISTS `GetTotalOrderValue` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `GetTotalOrderValue`(UserID INT) RETURNS decimal(18,2)
BEGIN
    DECLARE totalValue DECIMAL(18,2);
    SELECT SUM(Orders.Quantity * orders.Price) INTO totalValue
    FROM Orders
    
    WHERE Orders.UserID = UserID;
    RETURN totalValue;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `GetUserPortfolioValue` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `GetUserPortfolioValue`(UserID INT) RETURNS decimal(18,2)
BEGIN
    DECLARE totalValue DECIMAL(18,2);
    SELECT SUM(Orders.Quantity * orders.Price) INTO totalValue
    FROM Orders
    
    WHERE Orders.UserID = UserID;
    RETURN totalValue;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetUserOrders` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetUserOrders`(IN userID INT)
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `userorderstocktransaction`
--

/*!50001 DROP VIEW IF EXISTS `userorderstocktransaction`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `userorderstocktransaction` AS select `user`.`UserID` AS `UserID`,`user`.`Username` AS `UserName`,`orders`.`OrderID` AS `OrderID`,`orders`.`StockID` AS `StockID`,`orders`.`Quantity` AS `Quantity`,`stock`.`Symbol` AS `Symbol`,`transaction`.`TransactionID` AS `TransactionID`,`transaction`.`Price` AS `Price`,`transaction`.`TransactionType` AS `transactiontype` from (((`user` join `orders` on((`user`.`UserID` = `orders`.`UserID`))) join `stock` on((`orders`.`StockID` = `stock`.`StockID`))) join `transaction` on((`orders`.`StockID` = `transaction`.`StockID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-08-01 15:46:16
