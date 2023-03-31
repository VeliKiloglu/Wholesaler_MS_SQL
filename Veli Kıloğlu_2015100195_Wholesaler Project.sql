CREATE DATABASE WHOLESALER_2

CREATE TABLE tblCategory(
CategoryID int PRIMARY KEY NOT NULL identity (1,1),
CategoryName nvarchar(100)
);

CREATE TABLE tblSuppliers(
SupplierID int PRIMARY KEY identity(1,1),
CompanyName nvarchar(200),
HomePage nvarchar(200),
ContactName nvarchar(100),
City varchar(100),
Addres nvarchar(max),
Phone nvarchar(100)
);

CREATE TABLE tblStock(
ProductID int PRIMARY KEY not null identity(1,1),
ProductName nvarchar(200),
SupplierID int foreign key references tblSuppliers(SupplierID),
StockPiece int,
EnterPrice float,
CategoryID int foreign key references tblCategory(CategoryID),
NumberInPackages nvarchar(100),
Photo nvarchar(1000),
Location nvarchar(100)
);

ALTER TABLE tblStock
ALTER COLUMN ProductName nvarchar(max);

CREATE TABLE tblSalesR (
SalesRID int PRIMARY KEY not null identity(1,1),
FirstName nvarchar(200),
LastName nvarchar(200),
BirthDate DATE,
HireDate DATE,
Address nvarchar(max),
Phone nvarchar(100),
Photo nvarchar(1000),
InsuranceNuber nvarchar(100),
VehicleID nvarchar(100)
);

CREATE TABLE tblVehicle(
VehicleID int Primary Key not null identity(1,1),
SalesRID int foreign key references tblSalesR(SalesRID),
Plate nvarchar(100),
Model nvarchar(100),

KM integer,
MKM integer
);

ALTER TABLE tblVehicle
ADD CarYear int;

CREATE TABLE tblSalary(
SalaryID int primary key not null identity(1,1),
SalesRID int foreign key references tblSalesR(SalesRID),
SMonth TIMESTAMP,
BasicSalary int,
Bonus int,
TotalSalary int
);

alter table tblSalary
Add Smonth nvarchar(100);

CREATE TABLE tblCustomer(
CustomerID int primary key not null identity(1,1),
FirstName nvarchar(200),
ContactName nvarchar(200),
Phone nvarchar(100),
RegistryNumber nvarchar(100),
City nvarchar(200),
Township nvarchar(200),
SalesRID int foreign key references tblSalesR(SalesRID),
Address nvarchar(max)
);

create table tblCustomerD(
CustomerID int foreign key references tblCustomer(CustomerID),
HighestCategory nvarchar(100),
CategoryID int foreign key references tblCategory(CategoryID),
Discountrate float
);

create table tblOrder(
OrderID int primary key not null identity (1,1),
SaleRID int foreign key references tblSalesR(SalesRID),
CustomerID int foreign key references tblCustomer(CustomerID),
OrderDate DATE,
DeliveryDate DATE,
VehicleID int,
City nvarchar(200)
);

create table tblBill(
BillID int primary key not null identity (1,1),
OrderID int foreign key references tblOrder(OrderID),
CustomerID int,
SalesRID int,
BillPrice float,
RegistryNumber nvarchar(100)
);

create table OrderDetails(
OrderID int foreign key references tblOrder(OrderID),
ProductID int foreign key references tblStock(ProductID),
ProductName nvarchar(max),
NumberInPackages nvarchar(100),
EnterPrice float,
SalePrice float,
Amount int,
TotalPrice float
);

create table GiveBack(
GiveBackID int primary key not null identity(1,1),
OrderID int foreign key references tblOrder(OrderID),
SalesRID int foreign key references tblSalesR(salesRID),
ProductID int foreign key references tblStock(ProductID),
ProductName nvarchar(max),
Amount int,
SalePrice float
);


insert into tblSuppliers
values('palmolive', 'www.palmolive.com', 'Ahmet', 'Düzce', 'Düzce OSB 77', '444 1 777');
insert into tblSuppliers
values('nescafe', 'www.nescafe.com', 'Mehmet', 'Ýzmir', 'Ýzmir OSB 35', '444 0 673');

insert into tblCategory
values('Þampuan');
insert into tblCategory
values('Kahve');

insert into tblStock
values('Ýpek Þampuan 600ml','1','120','8.75','1','1','C:\Users\pc\Desktop\ipeksampuan','A2');
insert into tblStock
values('Nescafe 3in1 48li','2','480','50.75','2','48','C:\Users\pc\Desktop\nescafe3in1','C8');

SELECT * FROM GiveBack



/* CategoryID ile kategorideki ürünlerin ismini getiren sorgu */
select ProductName from tblStock
where CategoryID = 2 ;

/* Ürün adý ile alýþ fiyatýný saðlayan sorgu */
select EnterPrice from tblStock
where ProductName = 'Ýpek Þampuan 600ml' ;


/* Bakýmýna 4000 kilometreden az kalan araçlarýn plakasýný veren sorgu */
select Plate from tblVehicle
where MKM - KM <= 4000;

/* 2 numaralý aracý kullanan satýþ temsilcisinin adý ve numarasýný getiren sorgu */
SELECT tblSalesR.Phone, tblSalesR.FirstName, tblVehicle.VehicleID
From tblSalesR
inner join tblVehicle on tblSalesR.SalesRID = tblVehicle.SalesRID
where tblVehicle.VehicleID = 2;

/*Stok adedi 200'ün altýna inen ürünlerin satýcýlarýnýn telefon numrasý ve temsilci isimlerini getiren sorgu */
select tblSuppliers.Phone, tblSuppliers.ContactName , tblStock.ProductID
from tblSuppliers
inner join tblStock on tblSuppliers.SupplierID = tblStock.SupplierID
where tblStock.StockPiece <= 200;

/* ProductID ile herhangi bir ürünün stok adedini sorgulamamýzý saðlayan sorgu */
select StockPiece from tblStock
where ProductID = 1;