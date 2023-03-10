-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 24, 2021 at 02:12 PM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `eduardosdb`
--

-- --------------------------------------------------------

--
-- Table structure for table `employeetable`
--

CREATE TABLE `employeetable` (
  `employeeid` int(11) NOT NULL,
  `employeefirstname` varchar(250) NOT NULL,
  `employeemiddlename` varchar(250) NOT NULL,
  `employeelastname` varchar(250) NOT NULL,
  `employeecontact` varchar(11) NOT NULL,
  `employeeemail` varchar(250) NOT NULL,
  `employeerole` varchar(250) NOT NULL,
  `employeesalary` decimal(11,2) NOT NULL,
  `employeeavailability` varchar(250) NOT NULL DEFAULT 'Active',
  `employeedateactive` timestamp NOT NULL DEFAULT current_timestamp(),
  `employeedateinactive` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `has_account` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `employeetable`
--

INSERT INTO `employeetable` (`employeeid`, `employeefirstname`, `employeemiddlename`, `employeelastname`, `employeecontact`, `employeeemail`, `employeerole`, `employeesalary`, `employeeavailability`, `employeedateactive`, `employeedateinactive`, `has_account`) VALUES
(1, '', '', '', '', '', 'Owner', '0.00', 'Active', '2021-07-24 12:11:40', '2021-07-24 12:11:40', 1);

-- --------------------------------------------------------

--
-- Table structure for table `inventorytable`
--

CREATE TABLE `inventorytable` (
  `itemid` int(11) NOT NULL,
  `itemname` varchar(250) NOT NULL,
  `itemstock` int(11) NOT NULL,
  `itemunit` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `itemlogtable`
--

CREATE TABLE `itemlogtable` (
  `itemlogid` int(11) NOT NULL,
  `employeeid` int(11) NOT NULL,
  `itemid` int(11) NOT NULL,
  `pulledstock` int(11) NOT NULL,
  `logdate` timestamp NOT NULL DEFAULT current_timestamp(),
  `void` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `orderdetails`
--

CREATE TABLE `orderdetails` (
  `orderid` int(11) NOT NULL,
  `productid` int(11) NOT NULL,
  `itemquantity` int(11) NOT NULL,
  `itemtotalprice` decimal(11,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `ordertable`
--

CREATE TABLE `ordertable` (
  `orderid` int(11) NOT NULL,
  `ordertotalquantity` int(11) NOT NULL,
  `ordertotalprice` decimal(11,2) NOT NULL,
  `logdate` timestamp NOT NULL DEFAULT current_timestamp(),
  `employeeid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `producttable`
--

CREATE TABLE `producttable` (
  `productid` int(11) NOT NULL,
  `employeeid` int(11) NOT NULL,
  `productname` varchar(250) NOT NULL,
  `productprice` decimal(11,2) NOT NULL,
  `productavailability` varchar(250) NOT NULL DEFAULT 'Available',
  `productdateactive` timestamp NOT NULL DEFAULT current_timestamp(),
  `productdateinactive` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `suppliertable`
--

CREATE TABLE `suppliertable` (
  `supplierid` int(11) NOT NULL,
  `employeeid` int(11) NOT NULL,
  `suppliername` varchar(250) NOT NULL,
  `suppliercity` varchar(250) NOT NULL,
  `supplierstreet` varchar(250) NOT NULL,
  `supplierprovince` varchar(250) NOT NULL,
  `supplierzipcode` int(11) NOT NULL,
  `suppliercontact` varchar(250) NOT NULL,
  `supplieremail` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `supplylogtable`
--

CREATE TABLE `supplylogtable` (
  `supplylogid` int(11) NOT NULL,
  `employeeid` int(11) NOT NULL,
  `supplierid` int(11) NOT NULL,
  `itemid` int(11) NOT NULL,
  `itemname` varchar(250) NOT NULL,
  `stockadded` int(11) NOT NULL,
  `itemunit` varchar(250) NOT NULL,
  `logdate` timestamp NOT NULL DEFAULT current_timestamp(),
  `void` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `usertable`
--

CREATE TABLE `usertable` (
  `userid` int(11) NOT NULL,
  `employeeid` int(11) NOT NULL,
  `userpassword` varchar(250) NOT NULL,
  `usertype` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `usertable`
--

INSERT INTO `usertable` (`userid`, `employeeid`, `userpassword`, `usertype`) VALUES
(1, 1, '$2a$10$hdjppRHJ8LzHN42m6KXAN.3QGV4idZqDWYeH.LQfGQw3k6bDcQifC', 'Admin');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `employeetable`
--
ALTER TABLE `employeetable`
  ADD PRIMARY KEY (`employeeid`);

--
-- Indexes for table `inventorytable`
--
ALTER TABLE `inventorytable`
  ADD PRIMARY KEY (`itemid`);

--
-- Indexes for table `itemlogtable`
--
ALTER TABLE `itemlogtable`
  ADD PRIMARY KEY (`itemlogid`),
  ADD KEY `itemlog_fk1` (`employeeid`),
  ADD KEY `itemlog_fk2` (`itemid`);

--
-- Indexes for table `orderdetails`
--
ALTER TABLE `orderdetails`
  ADD KEY `details_fk1` (`orderid`),
  ADD KEY `details_fk2` (`productid`) USING BTREE;

--
-- Indexes for table `ordertable`
--
ALTER TABLE `ordertable`
  ADD PRIMARY KEY (`orderid`),
  ADD KEY `order_fk1` (`employeeid`);

--
-- Indexes for table `producttable`
--
ALTER TABLE `producttable`
  ADD PRIMARY KEY (`productid`),
  ADD KEY `product_fk1` (`employeeid`);

--
-- Indexes for table `suppliertable`
--
ALTER TABLE `suppliertable`
  ADD PRIMARY KEY (`supplierid`),
  ADD KEY `supplier_fk1` (`employeeid`);

--
-- Indexes for table `supplylogtable`
--
ALTER TABLE `supplylogtable`
  ADD PRIMARY KEY (`supplylogid`),
  ADD KEY `supplylog_fk1` (`employeeid`),
  ADD KEY `supplylog_fk2` (`supplierid`),
  ADD KEY `supplylog_fk3` (`itemid`);

--
-- Indexes for table `usertable`
--
ALTER TABLE `usertable`
  ADD PRIMARY KEY (`userid`),
  ADD KEY `user_fk1` (`employeeid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `employeetable`
--
ALTER TABLE `employeetable`
  MODIFY `employeeid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `inventorytable`
--
ALTER TABLE `inventorytable`
  MODIFY `itemid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `itemlogtable`
--
ALTER TABLE `itemlogtable`
  MODIFY `itemlogid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `producttable`
--
ALTER TABLE `producttable`
  MODIFY `productid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `suppliertable`
--
ALTER TABLE `suppliertable`
  MODIFY `supplierid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `supplylogtable`
--
ALTER TABLE `supplylogtable`
  MODIFY `supplylogid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `usertable`
--
ALTER TABLE `usertable`
  MODIFY `userid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `itemlogtable`
--
ALTER TABLE `itemlogtable`
  ADD CONSTRAINT `itemlog_fk1` FOREIGN KEY (`employeeid`) REFERENCES `employeetable` (`employeeid`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `itemlog_fk2` FOREIGN KEY (`itemid`) REFERENCES `inventorytable` (`itemid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `orderdetails`
--
ALTER TABLE `orderdetails`
  ADD CONSTRAINT `details_fk1` FOREIGN KEY (`orderid`) REFERENCES `ordertable` (`orderid`),
  ADD CONSTRAINT `details_fk2` FOREIGN KEY (`productid`) REFERENCES `producttable` (`productid`);

--
-- Constraints for table `ordertable`
--
ALTER TABLE `ordertable`
  ADD CONSTRAINT `order_fk1` FOREIGN KEY (`employeeid`) REFERENCES `employeetable` (`employeeid`);

--
-- Constraints for table `producttable`
--
ALTER TABLE `producttable`
  ADD CONSTRAINT `product_fk1` FOREIGN KEY (`employeeid`) REFERENCES `employeetable` (`employeeid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `suppliertable`
--
ALTER TABLE `suppliertable`
  ADD CONSTRAINT `supplier_fk1` FOREIGN KEY (`employeeid`) REFERENCES `employeetable` (`employeeid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `supplylogtable`
--
ALTER TABLE `supplylogtable`
  ADD CONSTRAINT `supplylog_fk1` FOREIGN KEY (`employeeid`) REFERENCES `employeetable` (`employeeid`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `supplylog_fk2` FOREIGN KEY (`supplierid`) REFERENCES `suppliertable` (`supplierid`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `supplylog_fk3` FOREIGN KEY (`itemid`) REFERENCES `inventorytable` (`itemid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `usertable`
--
ALTER TABLE `usertable`
  ADD CONSTRAINT `user_fk1` FOREIGN KEY (`employeeid`) REFERENCES `employeetable` (`employeeid`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
