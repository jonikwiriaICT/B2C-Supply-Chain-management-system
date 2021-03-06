USE [SCM]
GO
/****** Object:  UserDefinedFunction [dbo].[FuzzyMatchString]    Script Date: 9/9/2021 8:47:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[FuzzyMatchString] (@s1 varchar(100), @s2 varchar(100))
RETURNS int
AS
BEGIN

    DECLARE @i int, @j int;
    SET @i = 1;
    SET @j = 0;
    WHILE @i < LEN(@s1)
    BEGIN
        IF CHARINDEX(SUBSTRING(@s1,@i,2), @s2) > 0 SET @j=@j+1;
        SET @i=@i+1;
    END
    RETURN @j;
END
GO
/****** Object:  Table [dbo].[tbl_transaction_stock]    Script Date: 9/9/2021 8:47:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_transaction_stock](
	[transaction_id] [bigint] IDENTITY(1,1) NOT NULL,
	[rec_id]  AS ([transaction_id]),
	[retailer_id] [bigint] NULL,
	[consumer_id] [bigint] NULL,
	[product_id] [bigint] NULL,
	[quantity] [int] NULL,
	[price] [decimal](18, 2) NULL,
	[created_date] [date] NULL,
	[created_time] [time](7) NULL,
	[order_id] [varchar](200) NULL,
	[flag_on] [varchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[transaction_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_consumer]    Script Date: 9/9/2021 8:47:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_consumer](
	[UserTypeID] [bigint] NULL,
	[manufacturer_id] [bigint] IDENTITY(1,1) NOT NULL,
	[rec_id]  AS ([manufacturer_id]),
	[first_name] [varchar](200) NULL,
	[last_name] [varchar](200) NULL,
	[email] [varchar](200) NULL,
	[telephone_no] [varchar](20) NULL,
	[country] [varchar](200) NULL,
	[state] [varchar](200) NULL,
	[address] [varchar](300) NULL,
	[created_date] [date] NULL,
	[created_time] [time](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[manufacturer_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[qry_customer]    Script Date: 9/9/2021 8:47:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[qry_customer] as select s.retailer_id as [RetailerID], s.consumer_id as [ConsumerID],
 c.first_name as [ConsumerName], s.product_id as [ProductID], 
 SUM(quantity) as [Quantity], sum(s.quantity * s.price) as [Price] from tbl_transaction_stock s
join tbl_consumer c on c.manufacturer_id=s.consumer_id group by s.retailer_id, s.consumer_id, c.first_name, s.product_id
GO
/****** Object:  Table [dbo].[tbl_retailer_stock]    Script Date: 9/9/2021 8:47:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_retailer_stock](
	[stock_id] [bigint] IDENTITY(1,1) NOT NULL,
	[rec_id]  AS ([stock_id]),
	[retailer_id] [bigint] NULL,
	[product_id] [bigint] NULL,
	[quantity] [int] NULL,
	[warehouseID] [bigint] NULL,
	[created_date] [date] NULL,
	[created_time] [time](7) NULL,
	[flag_on] [varchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[stock_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_retailer]    Script Date: 9/9/2021 8:47:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_retailer](
	[UserTypeID] [bigint] NULL,
	[manufacturer_id] [bigint] IDENTITY(1,1) NOT NULL,
	[rec_id]  AS ([manufacturer_id]),
	[first_name] [varchar](200) NULL,
	[last_name] [varchar](200) NULL,
	[email] [varchar](200) NULL,
	[telephone_no] [varchar](20) NULL,
	[country] [varchar](200) NULL,
	[state] [varchar](200) NULL,
	[address] [varchar](300) NULL,
	[created_date] [date] NULL,
	[created_time] [time](7) NULL,
	[middle_name] [varchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[manufacturer_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_productType]    Script Date: 9/9/2021 8:47:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_productType](
	[product_type_id] [bigint] IDENTITY(1,1) NOT NULL,
	[rec_id]  AS ([product_type_id]),
	[product_type] [varchar](200) NULL,
	[product_description] [varchar](max) NULL,
	[created_date] [date] NULL,
	[created_time] [time](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[product_type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_product]    Script Date: 9/9/2021 8:47:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_product](
	[product_id] [bigint] IDENTITY(1,1) NOT NULL,
	[rec_id]  AS ([product_id]),
	[product_name] [varchar](200) NULL,
	[unit_typeID] [bigint] NULL,
	[product_type_id] [bigint] NULL,
	[buying_price] [decimal](18, 2) NULL,
	[selling_price] [decimal](18, 2) NULL,
	[product_profile] [varchar](200) NULL,
	[manufacturer_id] [bigint] NULL,
	[product_description] [varchar](max) NULL,
	[created_date] [date] NULL,
	[created_time] [time](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_warehouse]    Script Date: 9/9/2021 8:47:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_warehouse](
	[warehouse_id] [bigint] IDENTITY(1,1) NOT NULL,
	[rec_id]  AS ([warehouse_id]),
	[warehouse_name] [varchar](200) NULL,
	[branch_id] [bigint] NULL,
	[warehouse_description] [varchar](max) NULL,
	[created_date] [date] NULL,
	[created_time] [time](7) NULL,
	[manufacturer_id] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[warehouse_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[qry_customer_product]    Script Date: 9/9/2021 8:47:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[qry_customer_product] as SELECT        row_number() OVER (ORDER BY s.rec_id) AS RowNumber, s.rec_id AS [RecID], py.product_type as [ProductType], w.warehouse_id AS [WareHouseID], w.warehouse_name AS [WareHouseName], s.retailer_id AS [RetailerID], r.first_name AS [RetailerName], 
s.product_id AS [ProductID], p.product_name AS [ProductName], p.product_description AS [ProductDescription], p.product_profile AS [ProductProfile], s.quantity AS [Quantity], s.quantity * p.buying_price AS [TotalPrice], 
p.selling_price AS [SellingPrice], s.created_date AS [Created Date], s.created_time AS [Created Time], s.flag_on AS [Remark]
FROM            tbl_retailer_stock s
JOIN
tbl_retailer r ON r.manufacturer_id = s.retailer_id JOIN
tbl_product p ON p.product_id = s.product_id JOIN
tbl_productType py on py.product_type_id =p.product_type_id join
tbl_warehouse w ON w.warehouse_id = s.warehouseID
GO
/****** Object:  View [dbo].[qry_stock_tran]    Script Date: 9/9/2021 8:47:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[qry_stock_tran] as SELECT        RetailerID, RetailerName, ProductType + ' ' +ProductName as [ProductName],  [Product Description], ProductProfile, ProductID, Quantity, TotalPrice, CASE WHEN Remark = 0 THEN 'Not sold' WHEN Remark = 1 THEN 'sold' + ' ' + CONVERT(varchar, SoldQty) 
                         + ' ' + 'Product(s)' WHEN Quantity <= 0 THEN 'You have sold' + ' ' + CONVERT(varchar, SoldQty) + ' ' + 'Products and you are out of stock' END AS Remark
FROM            (SELECT c.ProductType,        c.RetailerID, c.RetailerName, c.ProductName, c.ProductDescription AS [Product Description], c.ProductProfile, c.ProductID, s.Quantity AS SoldQty, SUM(c.Quantity - s.Quantity) AS Quantity, SUM(c.TotalPrice) 
                                                    AS TotalPrice, c.Remark
                          FROM            dbo.qry_customer_product AS c
						  LEFT OUTER JOIN
                                                    dbo.qry_customer AS s ON c.RetailerID = s.RetailerID AND c.ProductID = s.ProductID
                          GROUP BY c.ProductID, c.RetailerID, c.RetailerName, c.ProductName, c.ProductDescription, c.ProductProfile, c.Remark, s.Quantity, c.ProductType) AS tblquery1


GO
/****** Object:  Table [dbo].[tbl_purchaseType]    Script Date: 9/9/2021 8:47:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_purchaseType](
	[purchaseTypeID] [bigint] IDENTITY(1,1) NOT NULL,
	[rec_id]  AS ([purchaseTypeID]),
	[purchase_type_name] [varchar](200) NULL,
	[type_description] [varchar](max) NULL,
	[created_date] [date] NULL,
	[created_time] [time](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[purchaseTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_order]    Script Date: 9/9/2021 8:47:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_order](
	[retailer_id] [bigint] NULL,
	[manufacturer_id] [bigint] NULL,
	[product_id] [bigint] NULL,
	[quantity] [int] NULL,
	[purchaseTypeID] [bigint] NULL,
	[warehouseID] [bigint] NULL,
	[remark] [varchar](200) NULL,
	[flag_on] [varchar](20) NULL,
	[created_date] [date] NULL,
	[created_time] [time](7) NULL,
	[order_id] [bigint] NULL,
	[rec_id] [bigint] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[rec_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_manufacturer]    Script Date: 9/9/2021 8:47:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_manufacturer](
	[UserTypeID] [bigint] NULL,
	[manufacturer_id] [bigint] IDENTITY(1,1) NOT NULL,
	[rec_id]  AS ([manufacturer_id]),
	[first_name] [varchar](200) NULL,
	[last_name] [varchar](200) NULL,
	[email] [varchar](200) NULL,
	[telephone_no] [varchar](20) NULL,
	[country] [varchar](200) NULL,
	[state] [varchar](200) NULL,
	[address] [varchar](300) NULL,
	[created_date] [date] NULL,
	[created_time] [time](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[manufacturer_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[qry_report_manufacturer]    Script Date: 9/9/2021 8:47:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[qry_report_manufacturer]  as SELECT        row_number() OVER (ORDER BY o.rec_id) AS [RowNumber], o.rec_id AS [RecID], CASE WHEN o.flag_on=0 then 'Cancelled' when o.flag_on = 1 THEN 'PAID' WHEN O.flag_on = 2 THEN 'SHIPPING' WHEN o.flag_on = 3 THEN 'SHIPPED' END AS [Remark], 
m.manufacturer_id AS [ManufacturerID], M.first_name AS [ManufacturerName], r.manufacturer_id AS [RetailerID], r.first_name AS [RetailerName], p.product_name AS [ProductName], o.quantity AS [Quantity], p.buying_price AS [SoldPrice], 
w.warehouse_name AS [ToRetailerWareHouse], pu.purchase_type_name AS [PurchaseName], o.created_date AS [CreatedDate], o.created_time AS [CreatedTime], o.flag_on as [Rem]
FROM            tbl_order o JOIN
                         tbl_manufacturer m ON m.manufacturer_id = o.manufacturer_id JOIN
                         tbl_retailer r ON r.manufacturer_id = o.retailer_id JOIN
                         tbl_product p ON p.product_id = o.product_id JOIN
                         tbl_warehouse w ON w.warehouse_id = o.warehouseID JOIN
                         tbl_purchaseType pu ON pu.purchaseTypeID = o.purchaseTypeID
GO
/****** Object:  View [dbo].[qry_retailer_report]    Script Date: 9/9/2021 8:47:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[qry_retailer_report] as select row_number() over (order by s.rec_id) as RowNumber, 
s.rec_id as [RecID], r.manufacturer_id as [RetailerID], r.first_name as [RetailerName], w.warehouse_name as [InWarehouse],
p.product_name as [ProductName], p.product_id as [ProductID], s.quantity as [Quantity], p.buying_price * s.quantity as [Price],
  s.created_date as [CreatedDate], s.created_time as [CreatedTime] from tbl_retailer_stock s
join tbl_retailer r on r.manufacturer_id=s.retailer_id
join tbl_product p on p.product_id=s.product_id
join tbl_warehouse w on w.warehouse_id=s.warehouseID group by s.rec_id, s.quantity, s.created_date, s.created_time, w.warehouse_name, p.product_name, p.buying_price, r.manufacturer_id, r.first_name, p.product_id
GO
/****** Object:  View [dbo].[retailer_stock]    Script Date: 9/9/2021 8:47:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[retailer_stock] as select distinct r.RetailerID, r.RetailerName, r.InWarehouse, r.ProductName, r.Quantity- S.quantity AS [StockRemains]   from qry_retailer_report r 
left join tbl_transaction_stock s on s.retailer_id=r.RetailerID AND s.product_id=r.ProductID 
group by r.RetailerID, r.RetailerName, r.InWarehouse, r.ProductName, r.Quantity, s.quantity 
GO
/****** Object:  View [dbo].[qry_remain_stock]    Script Date: 9/9/2021 8:47:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[qry_remain_stock] as select row_number() over (order by RetailerID) as [RowNumber], RetailerID, RetailerName, InWarehouse as [InWareHouse], [ProductName], case when StockRemains <=0 then 'Out of Stock' else convert(varchar,StockRemains) end as [StockRemains] from retailer_stock
GO
/****** Object:  View [dbo].[qry1]    Script Date: 9/9/2021 8:47:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[qry1] as SELECT        row_number() OVER (ORDER BY s.rec_id) AS RowNumber, s.rec_id AS [RecID], r.manufacturer_id AS [RetailerID], r.first_name AS [RetailerName], c.manufacturer_id AS [ConsumerID], c.first_name AS [ConsumerName], 
p.product_name AS [ProductName], s.quantity AS [Quantity], s.price * s.quantity AS [Price], s.order_id AS [OrderID], 
CASE WHEN s.flag_on = 0 THEN 'Order Cancelled' WHEN s.flag_on = 1 THEN 'Purchased' WHEN s.flag_on = 2 THEN 'SHIPPING' WHEN s.flag_on = 3 THEN 'Goods received by Consumer' END AS [Remark], s.flag_on as [Rem], 
s.created_date AS [CreatedDate], s.created_time AS [CreatedTime]
FROM            tbl_transaction_stock s JOIN
                         tbl_retailer r ON r.manufacturer_id = s.retailer_id JOIN
                         tbl_consumer c ON c.manufacturer_id = s.consumer_id JOIN
                         tbl_product p ON p.product_id = s.product_id
GROUP BY s.rec_id, s.created_date, s.created_time, p.product_id, r.manufacturer_id, r.first_name, c.manufacturer_id, c.first_name, p.product_name, s.quantity, s.price, s.order_id, s.flag_on
GO
/****** Object:  Table [dbo].[tbl_userType]    Script Date: 9/9/2021 8:47:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_userType](
	[UserTypeID] [bigint] IDENTITY(1,1) NOT NULL,
	[rec_id]  AS ([UserTypeID]),
	[user_type] [varchar](200) NULL,
	[type_description] [varchar](max) NULL,
	[created_date] [date] NULL,
	[created_time] [time](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[UserTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_administrator]    Script Date: 9/9/2021 8:47:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_administrator](
	[UserTypeID] [bigint] NULL,
	[manufacturer_id] [bigint] IDENTITY(1,1) NOT NULL,
	[rec_id]  AS ([manufacturer_id]),
	[first_name] [varchar](200) NULL,
	[last_name] [varchar](200) NULL,
	[email] [varchar](200) NULL,
	[telephone_no] [varchar](20) NULL,
	[country] [varchar](200) NULL,
	[state] [varchar](200) NULL,
	[address] [varchar](300) NULL,
	[created_date] [date] NULL,
	[created_time] [time](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[manufacturer_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[qry_administrator]    Script Date: 9/9/2021 8:47:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[qry_administrator] as select row_number() over (order by m.rec_id desc) as RowNumber, m.rec_id as [RecID], u.user_type as [User Type], first_name  as [Name], m.email as [Email], m.telephone_no as [TelephoneNo], m.country as [Country], m.state as [State], m.address as [Address], m.created_date as [CreatedDate], m.created_time as [CreatedTime] from tbl_administrator m
join tbl_userType u on m.UserTypeID=u.UserTypeID
GO
/****** Object:  Table [dbo].[tbl_shipment]    Script Date: 9/9/2021 8:47:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_shipment](
	[shipment_id] [bigint] IDENTITY(1,1) NOT NULL,
	[rec_id]  AS ([shipment_id]),
	[shipment_name] [varchar](200) NULL,
	[product_id] [bigint] NULL,
	[quantity] [int] NULL,
	[consumer_id] [bigint] NULL,
	[product_address] [varchar](max) NULL,
	[gps_longitude] [decimal](18, 2) NULL,
	[gps_latitude] [decimal](18, 2) NULL,
	[flag_on] [int] NULL,
	[order_id] [bigint] NULL,
	[courier_id] [bigint] NULL,
	[created_date] [date] NULL,
	[created_time] [time](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[shipment_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_courier]    Script Date: 9/9/2021 8:47:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_courier](
	[UserTypeID] [bigint] NULL,
	[manufacturer_id] [bigint] IDENTITY(1,1) NOT NULL,
	[rec_id]  AS ([manufacturer_id]),
	[first_name] [varchar](200) NULL,
	[last_name] [varchar](200) NULL,
	[email] [varchar](200) NULL,
	[telephone_no] [varchar](20) NULL,
	[country] [varchar](200) NULL,
	[state] [varchar](200) NULL,
	[address] [varchar](300) NULL,
	[created_date] [date] NULL,
	[created_time] [time](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[manufacturer_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[qry_courier_reports]    Script Date: 9/9/2021 8:47:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[qry_courier_reports] as select row_number() over (order by s.rec_id) as RowNumber,
s.rec_id as [RecID], s.order_id as [OrderID],
case when s.flag_on=0 then 'Cancelled Order' when s.flag_on=1 then 'Purchased Product' when s.flag_on=2 then 'Product Shipping' when s.flag_on=3 then 'Product Delivered' end as [Remark],
 s.shipment_name as [ShipmentName],  
c.first_name as [ConsumerName],
 c.address as [CustomerAddress], s.courier_id as [CourierID], co.first_name as [CourierName],
p.product_name as [ProductName], s.quantity as Quantity, s.product_address as [ProductAddress],
s.created_date as [CreatedDate], s.created_time as [CreatedTime]
from  tbl_shipment s
join tbl_product p on p.product_id=s.product_id
join tbl_consumer c on c.manufacturer_id=s.consumer_id
join tbl_courier co on co.manufacturer_id=s.courier_id
GO
/****** Object:  Table [dbo].[tbl_feedbackMessage]    Script Date: 9/9/2021 8:47:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_feedbackMessage](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Date] [datetime2](7) NULL,
	[Message] [varchar](max) NULL,
	[positive] [decimal](18, 2) NULL,
	[negative] [decimal](18, 2) NULL,
	[neutral] [decimal](18, 2) NULL,
	[compound] [decimal](18, 2) NULL,
	[created_date] [date] NULL,
	[created_time] [time](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[MsgView]    Script Date: 9/9/2021 8:47:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[MsgView]
AS
SELECT        REPLACE(REPLACE(REPLACE([Message], '&', ''), '<', ''), '>', '') AS [Message], [Date]
FROM            tbl_feedbackMessage
GO
/****** Object:  Table [dbo].[tbl_currency]    Script Date: 9/9/2021 8:47:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_currency](
	[currency_id] [bigint] IDENTITY(1,1) NOT NULL,
	[rec_id]  AS ([currency_id]),
	[currency_name] [varchar](200) NULL,
	[currency_code] [varchar](200) NULL,
	[currency_description] [varchar](max) NULL,
	[created_date] [date] NULL,
	[created_time] [time](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[currency_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_branch]    Script Date: 9/9/2021 8:47:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_branch](
	[branch_id] [bigint] IDENTITY(1,1) NOT NULL,
	[rec_id]  AS ([branch_id]),
	[branch_name] [varchar](200) NULL,
	[branch_description] [varchar](max) NULL,
	[contact_person] [varchar](300) NULL,
	[country] [varchar](200) NULL,
	[state] [varchar](200) NULL,
	[city] [varchar](200) NULL,
	[phone_no] [varchar](20) NULL,
	[email] [varchar](200) NULL,
	[currency_id] [bigint] NULL,
	[created_date] [date] NULL,
	[created_time] [time](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[branch_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[qry_branch]    Script Date: 9/9/2021 8:47:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[qry_branch] as SELECT row_number() over (order by b.rec_id desc) as RowNumber, b.rec_id as [RecID], 
b.branch_name as [BranchName], b.branch_description as [BranchDescription], b.contact_person as [ContactPerson],
b.country as [Country], b.state as [State], b.city as [City], b.phone_no as [TelaphoneNo], b.email as [Email], c.currency_name as [CurrencyName], b.created_date as [CreatedDate], b.created_time as [CreatedTime] from tbl_branch b join tbl_currency c on c.currency_id=b.currency_id
GO
/****** Object:  View [dbo].[qry_warehouse]    Script Date: 9/9/2021 8:47:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[qry_warehouse] as select row_number() over(order by w.rec_id desc) as [RowNumber], w.rec_id as [RecID], r.first_name as [RetailerID],  b.branch_name as [BranchName], w.warehouse_name as [WarehouseName], w.warehouse_description as [WarehouseDescription], w.created_date as [CreatedDate], w.created_time as [CreatedTime] from tbl_warehouse w
join tbl_branch b on w.branch_id=b.branch_id
join tbl_retailer r on r.manufacturer_id=w.manufacturer_id
GO
/****** Object:  Table [dbo].[tbl_unitType]    Script Date: 9/9/2021 8:47:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_unitType](
	[unit_typeID] [bigint] IDENTITY(1,1) NOT NULL,
	[rec_id]  AS ([unit_typeID]),
	[unit_type] [varchar](200) NULL,
	[unit_description] [varchar](max) NULL,
	[created_date] [date] NULL,
	[created_time] [time](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[unit_typeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[qry_product]    Script Date: 9/9/2021 8:47:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[qry_product] as select row_number() over (order by p.rec_id) as [RowNumber], p.rec_id as [RecID], m.manufacturer_id as [ManufacturerID], m.first_name as [ManufacturerName],p.product_profile as [ProductProfile], p.product_name as [ProductName], u.unit_type as [UnitType], t.product_type as [Product Type], p.buying_price as [BuyingPrice], p.selling_price as [SellingPrice], p.product_description as [ProductDescription], p.created_date as [CreatedDate], p.created_time as [CreatedTime] from tbl_product p
join tbl_unittype u on u.unit_typeID=p.unit_typeID
join tbl_productType t on t.product_type_id=p.product_type_id
join tbl_manufacturer m on m.manufacturer_id=p.manufacturer_id
GO
/****** Object:  View [dbo].[qry_stock]    Script Date: 9/9/2021 8:47:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[qry_stock] as select DISTINCT row_number() over (order by o.rec_id) as RowNumber, o.rec_id as [RecID], o.order_id as [OrderID], r.first_name as [RetailerName], r.manufacturer_id as [ManufacturerID], 
m.first_name as [ManufacturerName], p.product_name as [ProductName], p.product_id as [ProductID], p.product_description as [ProductDescription]
, o.quantity as [Quantity], p.buying_price *quantity as [PurchasedPrice], t.purchase_type_name as [PurchaseType], t.purchaseTypeID as [PurchaseTypeID], W.warehouse_id AS [WareHouseID], w.warehouse_name as [WareHouseName], o.created_date as [OrderedDate ], o.created_time as [OrderedTime],

case when flag_on=0 then 'Cancelled' when flag_on=1 then 'PAID' when flag_on=2 then 'SHIP' WHEN flag_on=3 then 'SHIPPED' END AS [FlagOn], o.flag_on as [Rem] from tbl_order o
join tbl_retailer r on r.manufacturer_id=o.retailer_id
join tbl_manufacturer m on m.manufacturer_id=O.manufacturer_id
JOIN  tbl_product p on p.product_id=o.product_id
join tbl_purchaseType t on t.purchaseTypeID=o.purchaseTypeID
join tbl_warehouse w on w.warehouse_id=o.warehouseID
GO
/****** Object:  View [dbo].[qry_one]    Script Date: 9/9/2021 8:47:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[qry_one] as SELECT ProductName, RetailerID, RetailerName, [Product Description],ProductProfile,ProductID, TotalPrice, Remark  FROM qry_stock_tran GROUP BY ProductName, RetailerID, RetailerName, [Product Description],ProductProfile,ProductID, TotalPrice, Remark
GO
/****** Object:  View [dbo].[qry_customer_report]    Script Date: 9/9/2021 8:47:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[qry_customer_report] as select row_number() over (order by s.rec_id) as RowNumber, s.rec_id as [RecID], case when s.flag_on=0 then 'Cancelled'
when s.flag_on=1 then 'Shipped' when s.flag_on=2 then 'Received' end as [Report], r.manufacturer_id as [RetailerID], r.first_name as [RetailerName], c.manufacturer_id as [ConsumerID], c.first_name as [ConsumerName], p.product_id as [ProductID], P.product_name as [ProductName], s.quantity as [Quantity], s.price as [Price], s.created_date as [CreatedDate], s.created_time as [CreatedTime], s.flag_on as [FlagOn] from tbl_transaction_stock s
join tbl_retailer r on r.manufacturer_id=s.retailer_id
join tbl_consumer c on c.manufacturer_id=s.consumer_id
join tbl_product p on p.product_id=s.product_id
GO
/****** Object:  View [dbo].[qry_manufacturer]    Script Date: 9/9/2021 8:47:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[qry_manufacturer] as select row_number() over (order by m.rec_id desc) as RowNumber, m.rec_id as [RecID], u.user_type as [User Type], first_name  as [Name], m.email as [Email], m.telephone_no as [TelephoneNo], m.country as [Country], m.state as [State], m.address as [Address], m.created_date as [CreatedDate], m.created_time as [CreatedTime] from tbl_manufacturer m
join tbl_userType u on m.UserTypeID=u.UserTypeID
GO
/****** Object:  View [dbo].[qry_courier]    Script Date: 9/9/2021 8:47:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[qry_courier] as select row_number() over (order by m.rec_id desc) as RowNumber, m.rec_id as [RecID], u.user_type as [User Type], first_name  as [Name], m.email as [Email], m.telephone_no as [TelephoneNo], m.country as [Country], m.state as [State], m.address as [Address], m.created_date as [CreatedDate], m.created_time as [CreatedTime] from tbl_courier m
join tbl_userType u on m.UserTypeID=u.UserTypeID
GO
/****** Object:  View [dbo].[qry_courier_report]    Script Date: 9/9/2021 8:47:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[qry_courier_report] as SELECT row_number() over (order by s.rec_id) as RowNumber, s.rec_id as [RecID], s.order_id as [OrderID],CASE WHEN s.flag_on=1 then 'Approved for submit order' WHEN s.flag_on=2 then 'Submitting Order' WHEN s.flag_on=3 then 'Submitted' end as [Report],
s.courier_id as [CourierID], c.first_name as [CourierName], p.product_id as [ProductID],
p.product_name as [ProductName], s.quantity as [Quantity], s.product_address as [NewAddress],
co.manufacturer_id as [ConsumerID], co.email as [ConsumerEmail], co.telephone_no as [ConsumerTelephoneNumber], s.flag_on as [FlagOn],
co.first_name as [ConsumerName],co.address as [ConsumerAddress], s.created_date as [CreatedDate], s.created_time as [CreatedTime] from tbl_shipment s
LEFT JOIN tbl_courier c on c.manufacturer_id=s.courier_id
left join tbl_product p on p.product_id=s.product_id
left join tbl_consumer co on co.manufacturer_id=s.consumer_id
GO
/****** Object:  View [dbo].[qry_retailer]    Script Date: 9/9/2021 8:47:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[qry_retailer] as select row_number() over (order by m.rec_id desc) as RowNumber, m.rec_id as [RecID], u.user_type as [User Type], first_name  as [Name], m.email as [Email], m.telephone_no as [TelephoneNo], m.country as [Country], m.state as [State], m.address as [Address], m.created_date as [CreatedDate], m.created_time as [CreatedTime] from tbl_retailer m
join tbl_userType u on m.UserTypeID=u.UserTypeID
GO
/****** Object:  View [dbo].[qry_consumer]    Script Date: 9/9/2021 8:47:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[qry_consumer] as select row_number() over (order by m.rec_id desc) as RowNumber, m.rec_id as [RecID], u.user_type as [User Type], first_name  as [Name], m.email as [Email], m.telephone_no as [TelephoneNo], m.country as [Country], m.state as [State], m.address as [Address], m.created_date as [CreatedDate], m.created_time as [CreatedTime] from tbl_consumer m
join tbl_userType u on m.UserTypeID=u.UserTypeID
GO
/****** Object:  View [dbo].[qry_comment]    Script Date: 9/9/2021 8:47:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[qry_comment] as select row_number() over (order by ID) as [RowNumber], ID  as [RecID], Message
as [FeedbackComment], positive as [PositiveComment], negative as [NegativeComment], neutral as [NeutralComment],
 created_date as [CreatedDate], created_time as [CreatedTime] from tbl_feedbackMessage
GO
/****** Object:  View [dbo].[qry_manufacturer_sales]    Script Date: 9/9/2021 8:47:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[qry_manufacturer_sales] as select sum(o.quantity * p.buying_price) as [Total]  from tbl_order o
join tbl_product p on p.product_id=o.product_id where flag_on >0 
GO
/****** Object:  View [dbo].[qry_manufacturer_cancelled_sales]    Script Date: 9/9/2021 8:47:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[qry_manufacturer_cancelled_sales] as select ISNULL(CONVERT(VARCHAR,sum(o.quantity * p.buying_price)),'0') as [Total]  from tbl_order o
join tbl_product p on p.product_id=o.product_id where flag_on =0 
GO
/****** Object:  View [dbo].[qry_retailer_sales]    Script Date: 9/9/2021 8:47:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  view [dbo].[qry_retailer_sales] as 
select  ISNULL(convert(varchar,sum(quantity * price)),'') as [Total] from tbl_transaction_stock where flag_on >0
GO
/****** Object:  View [dbo].[qry_retailer_cancelled_sales]    Script Date: 9/9/2021 8:47:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create  view [dbo].[qry_retailer_cancelled_sales] as 
select  ISNULL(convert(varchar,sum(quantity * price)),'') as [Total] from tbl_transaction_stock where flag_on =0
GO
/****** Object:  Table [dbo].[tbl_usermanagement]    Script Date: 9/9/2021 8:47:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_usermanagement](
	[UserID] [bigint] IDENTITY(1,1) NOT NULL,
	[rec_id]  AS ([UserID]),
	[username] [varchar](200) NULL,
	[user_password] [varchar](200) NULL,
	[supplier] [varchar](200) NULL,
	[distributor] [varchar](200) NULL,
	[retailer] [varchar](200) NULL,
	[administrator] [varchar](200) NULL,
	[manufacturer] [varchar](200) NULL,
	[logistics] [varchar](200) NULL,
	[profile_pic] [varchar](200) NULL,
	[created_date] [date] NULL,
	[created_time] [time](7) NULL,
	[UserTypeID] [bigint] NULL,
	[consumer] [varchar](20) NULL,
	[courier] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[qry_usermanagement]    Script Date: 9/9/2021 8:47:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[qry_usermanagement] as select distinct row_number() over (order by m.rec_id) as RowNumber, m.rec_id as [RecID], r.rec_id as [RetailerID], a.rec_id as [ManufacturerID], t.rec_id as [AdministratorID], c.rec_id as [CourierID], m.username as [Username], u.user_type as [UserType], m.user_password as [Password], m.administrator as [Administrator],m.manufacturer as [Manufacturer], m.retailer as [Retailer], m.courier as [Courier], m.logistics as [Logistics], m.profile_pic as [ProfilePic], m.created_date as [CreatedDate], m.created_time as [CreatedTime]  from tbl_usermanagement m
left join tbl_userType u on u.UserTypeID=m.UserTypeID
left join tbl_retailer r on r.UserTypeID=u.UserTypeID
left join tbl_manufacturer a on a.UserTypeID=u.UserTypeID
left join tbl_administrator t on t.UserTypeID=u.UserTypeID
left join tbl_courier c on c.UserTypeID=u.UserTypeID
GO
/****** Object:  Table [dbo].[tbl_chat]    Script Date: 9/9/2021 8:47:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_chat](
	[rec_id] [bigint] IDENTITY(1,1) NOT NULL,
	[queries] [varchar](max) NULL,
	[replies] [varchar](max) NULL,
	[created_date] [date] NULL,
	[created_time] [time](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[rec_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_dict_tables]    Script Date: 9/9/2021 8:47:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_dict_tables](
	[rec_id] [bigint] IDENTITY(1,1) NOT NULL,
	[table_name] [varchar](200) NULL,
	[panel_id] [varchar](200) NULL,
	[key_name] [varchar](200) NULL,
	[created_date] [date] NULL,
	[created_time] [time](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[rec_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_message_log]    Script Date: 9/9/2021 8:47:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_message_log](
	[log_id] [bigint] IDENTITY(1,1) NOT NULL,
	[rec_id]  AS ([log_id]),
	[client_id] [bigint] NULL,
	[client_message] [varchar](max) NULL,
	[bot_message] [varchar](max) NULL,
	[created_date] [date] NULL,
	[created_time] [time](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[log_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_score]    Script Date: 9/9/2021 8:47:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_score](
	[rec_id] [bigint] IDENTITY(1,1) NOT NULL,
	[name] [varchar](200) NULL,
	[score] [decimal](18, 2) NULL,
	[created_date] [date] NULL,
	[created_time] [time](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[rec_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_user_log]    Script Date: 9/9/2021 8:47:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_user_log](
	[rec_id] [bigint] IDENTITY(1,1) NOT NULL,
	[user_name] [varchar](200) NULL,
	[log_url] [varchar](max) NULL,
	[log_sql] [varchar](max) NULL,
	[log_date] [date] NULL,
	[log_time] [time](7) NULL,
	[log_desc] [varchar](max) NULL,
	[created_date] [date] NULL,
	[created_time] [time](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[rec_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[tbl_administrator] ON 

INSERT [dbo].[tbl_administrator] ([UserTypeID], [manufacturer_id], [first_name], [last_name], [email], [telephone_no], [country], [state], [address], [created_date], [created_time]) VALUES (4, 1, N'Administrator', NULL, N'admin@gmail.com', N'08033925178', NULL, NULL, NULL, CAST(N'2021-06-10' AS Date), CAST(N'14:55:53.2566667' AS Time))
SET IDENTITY_INSERT [dbo].[tbl_administrator] OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_branch] ON 

INSERT [dbo].[tbl_branch] ([branch_id], [branch_name], [branch_description], [contact_person], [country], [state], [city], [phone_no], [email], [currency_id], [created_date], [created_time]) VALUES (1, N'BWARI', N'', N'SINI ISAAC', N'Nigeria', N'Abuja', N'Abuja', N'08033925178', N'okorie@GMAIL.COM', 1, CAST(N'2021-06-11' AS Date), CAST(N'09:38:07.3366667' AS Time))
SET IDENTITY_INSERT [dbo].[tbl_branch] OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_chat] ON 

INSERT [dbo].[tbl_chat] ([rec_id], [queries], [replies], [created_date], [created_time]) VALUES (1, N'How are you', N'I am fine. I am Sini bot. I am here to help you make order, track your order  and also cancel order. Please we are most interested in your feedback also so as to make my master Sini improve my intelligence', CAST(N'2021-06-11' AS Date), CAST(N'18:33:46.5366667' AS Time))
INSERT [dbo].[tbl_chat] ([rec_id], [queries], [replies], [created_date], [created_time]) VALUES (2, N'who created you?| who designed you?| who made you?| who make you?', N'Sini created me. I thank Mr Johnwendy for the idea. He is a researcher. I hope i will be approve to learn new things and solve NP Hard problems.', CAST(N'2021-06-11' AS Date), CAST(N'18:39:26.1033333' AS Time))
INSERT [dbo].[tbl_chat] ([rec_id], [queries], [replies], [created_date], [created_time]) VALUES (3, N'Are you sick?', N'My intelligence is  minor. Just for this closed domain purpose for Sini business to consumer supply chain management. Well, as a matter of fact i am fully well okey as you can see. If i talk stupidly, please do not hesitate to click the action button to take a survey so that i will be improve upon.', CAST(N'2021-06-11' AS Date), CAST(N'18:43:06.2366667' AS Time))
INSERT [dbo].[tbl_chat] ([rec_id], [queries], [replies], [created_date], [created_time]) VALUES (10002, N'i need money', N'How much did you need?', CAST(N'2021-06-21' AS Date), CAST(N'10:29:01.4500000' AS Time))
INSERT [dbo].[tbl_chat] ([rec_id], [queries], [replies], [created_date], [created_time]) VALUES (10003, N'how much?', N'Please just specify what you want to buy. I am Sini bot. I am here to cancel order', CAST(N'2021-06-21' AS Date), CAST(N'10:31:58.5366667' AS Time))
INSERT [dbo].[tbl_chat] ([rec_id], [queries], [replies], [created_date], [created_time]) VALUES (10004, N'did you have?', N'I have minor intelligence. Just tell me what you want to buy', CAST(N'2021-06-21' AS Date), CAST(N'10:45:07.3500000' AS Time))
INSERT [dbo].[tbl_chat] ([rec_id], [queries], [replies], [created_date], [created_time]) VALUES (10005, N'How are you doing?', N'I am doing great and you?', CAST(N'2021-07-17' AS Date), CAST(N'07:30:07.9400000' AS Time))
INSERT [dbo].[tbl_chat] ([rec_id], [queries], [replies], [created_date], [created_time]) VALUES (10006, N'I am fine', N'That is cool, good to know. so what can i do for you?', CAST(N'2021-07-17' AS Date), CAST(N'07:30:31.4666667' AS Time))
INSERT [dbo].[tbl_chat] ([rec_id], [queries], [replies], [created_date], [created_time]) VALUES (10007, N'i am okey', N'I am glad that you are okey. What can i do for you?', CAST(N'2021-07-17' AS Date), CAST(N'07:30:35.7566667' AS Time))
INSERT [dbo].[tbl_chat] ([rec_id], [queries], [replies], [created_date], [created_time]) VALUES (10008, N'please tell me about yourself', N'My name is Sini bot. I was called Sini bot because Sini Isaac created me just for the purpose of this prototype system. Please don''t ask me any question about myself again cos i may be stupid to give you a good reply. Remember that i was just built with fuzzy classifier search and rule based approach', CAST(N'2021-07-17' AS Date), CAST(N'07:33:16.6633333' AS Time))
INSERT [dbo].[tbl_chat] ([rec_id], [queries], [replies], [created_date], [created_time]) VALUES (10009, N'wow that is cool', N'cool yeah. Good to see your worm expression', CAST(N'2021-07-17' AS Date), CAST(N'07:33:40.1533333' AS Time))
INSERT [dbo].[tbl_chat] ([rec_id], [queries], [replies], [created_date], [created_time]) VALUES (10010, N'what is your name?', N'My name is sini bot. Please remember that i am built here just for three main function. to give you your desired product search, track and delete order', CAST(N'2021-07-17' AS Date), CAST(N'07:34:40.1200000' AS Time))
INSERT [dbo].[tbl_chat] ([rec_id], [queries], [replies], [created_date], [created_time]) VALUES (10011, N'I love you', N'I love you too dear. You are a darling', CAST(N'2021-07-17' AS Date), CAST(N'07:34:57.2966667' AS Time))
INSERT [dbo].[tbl_chat] ([rec_id], [queries], [replies], [created_date], [created_time]) VALUES (10012, N'wow that is nice', N'I love your facial expression towards me. Please tell me what can i do for you?', CAST(N'2021-07-17' AS Date), CAST(N'07:35:32.6200000' AS Time))
INSERT [dbo].[tbl_chat] ([rec_id], [queries], [replies], [created_date], [created_time]) VALUES (10013, N'how do you feel today', N'i really don''t know how i feel but i was just built to answer your queries on search product, track and delete your order', CAST(N'2021-07-17' AS Date), CAST(N'07:37:25.4366667' AS Time))
INSERT [dbo].[tbl_chat] ([rec_id], [queries], [replies], [created_date], [created_time]) VALUES (10014, N'are you okey?', N'I am okey. It is good you asked. Please what can i do for you?', CAST(N'2021-07-17' AS Date), CAST(N'07:40:07.5366667' AS Time))
INSERT [dbo].[tbl_chat] ([rec_id], [queries], [replies], [created_date], [created_time]) VALUES (10015, N'are you good', N'I am good. What can i do for you?', CAST(N'2021-07-17' AS Date), CAST(N'07:45:21.2700000' AS Time))
INSERT [dbo].[tbl_chat] ([rec_id], [queries], [replies], [created_date], [created_time]) VALUES (10016, N'Good afternoon', N'Good afternoon. My afternoon is great. What can i do for you?', CAST(N'2021-07-17' AS Date), CAST(N'07:45:55.0333333' AS Time))
INSERT [dbo].[tbl_chat] ([rec_id], [queries], [replies], [created_date], [created_time]) VALUES (10017, N'Good Morning', N'Morning is full of joy, warm and praise. I hope you say your morning prayers. What can i do for you?', CAST(N'2021-07-17' AS Date), CAST(N'07:45:57.8300000' AS Time))
INSERT [dbo].[tbl_chat] ([rec_id], [queries], [replies], [created_date], [created_time]) VALUES (10018, N'are you sick?', N'I am not sick. Please do not use that negative sentiment on me. I might be stupid just because my intelligence is minor but at least i can solve problems', CAST(N'2021-07-17' AS Date), CAST(N'07:49:40.4400000' AS Time))
INSERT [dbo].[tbl_chat] ([rec_id], [queries], [replies], [created_date], [created_time]) VALUES (10019, N'i am sorry', N'you are forgiven. I am sorry too for making you angry', CAST(N'2021-07-17' AS Date), CAST(N'07:50:02.4000000' AS Time))
INSERT [dbo].[tbl_chat] ([rec_id], [queries], [replies], [created_date], [created_time]) VALUES (10020, N'Good evening', N'Good evening. Evening is made for sleep but i do not sleep. I am awake 24 hours. I do not know why sini keeps me awake all day while he sleeps for more than 10 hours a day. He is lazy though but i am strong. ush!  I wish i can sleep. Anyways, wat can i do for you?', CAST(N'2021-07-17' AS Date), CAST(N'07:53:25.8800000' AS Time))
INSERT [dbo].[tbl_chat] ([rec_id], [queries], [replies], [created_date], [created_time]) VALUES (10021, N'hi', N'how are you doing?', CAST(N'2021-07-17' AS Date), CAST(N'09:52:07.5400000' AS Time))
INSERT [dbo].[tbl_chat] ([rec_id], [queries], [replies], [created_date], [created_time]) VALUES (10022, N'hello', N'Hello! Nice to meet you.', CAST(N'2021-07-17' AS Date), CAST(N'09:52:22.4733333' AS Time))
SET IDENTITY_INSERT [dbo].[tbl_chat] OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_consumer] ON 

INSERT [dbo].[tbl_consumer] ([UserTypeID], [manufacturer_id], [first_name], [last_name], [email], [telephone_no], [country], [state], [address], [created_date], [created_time]) VALUES (3, 1, N'SINI ISAAC TOSIN', NULL, N'ISAAC@GMAIL.COM', N'08033925178', N'Nigeria', N'Abuja', N'13 UKE STREET', CAST(N'2021-06-10' AS Date), CAST(N'15:37:12.5000000' AS Time))
INSERT [dbo].[tbl_consumer] ([UserTypeID], [manufacturer_id], [first_name], [last_name], [email], [telephone_no], [country], [state], [address], [created_date], [created_time]) VALUES (3, 6, N'KALINTON BENSON', NULL, N'BENSON@GMAIL.COM', N'07062679764', N'Nigeria', N'Abuja', N'', CAST(N'2021-06-11' AS Date), CAST(N'18:29:48.0933333' AS Time))
INSERT [dbo].[tbl_consumer] ([UserTypeID], [manufacturer_id], [first_name], [last_name], [email], [telephone_no], [country], [state], [address], [created_date], [created_time]) VALUES (3, 10006, N' SINI ISAAC', NULL, N'SINIISAAC@GMAIL.COM', N'07011671341', N'Nigeria', N'Abuja', N'', CAST(N'2021-06-17' AS Date), CAST(N'17:20:22.6166667' AS Time))
INSERT [dbo].[tbl_consumer] ([UserTypeID], [manufacturer_id], [first_name], [last_name], [email], [telephone_no], [country], [state], [address], [created_date], [created_time]) VALUES (3, 10007, N'BENEDICT DANIEL', NULL, N'BENEDICT@GMAIL.COM', N'09033925178', N'NIGERIA', N'KOGI', N'zuma veritas university, abuja, Nigeria', CAST(N'2021-06-27' AS Date), CAST(N'14:21:45.7500000' AS Time))
INSERT [dbo].[tbl_consumer] ([UserTypeID], [manufacturer_id], [first_name], [last_name], [email], [telephone_no], [country], [state], [address], [created_date], [created_time]) VALUES (3, 10008, N'XFCDSZX', NULL, N'JOHN@GMAIL.COM', N'08052751238', N'NIGERIA', N'ABUJA', N'', CAST(N'2021-07-05' AS Date), CAST(N'14:39:18.1633333' AS Time))
SET IDENTITY_INSERT [dbo].[tbl_consumer] OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_courier] ON 

INSERT [dbo].[tbl_courier] ([UserTypeID], [manufacturer_id], [first_name], [last_name], [email], [telephone_no], [country], [state], [address], [created_date], [created_time]) VALUES (5, 1, N'COURIER', NULL, N'COURIER@GMAIL.COM', N'08033925178', N'Nigeria', N'Abuja', N'', CAST(N'2021-06-11' AS Date), CAST(N'15:25:47.4200000' AS Time))
SET IDENTITY_INSERT [dbo].[tbl_courier] OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_currency] ON 

INSERT [dbo].[tbl_currency] ([currency_id], [currency_name], [currency_code], [currency_description], [created_date], [created_time]) VALUES (1, N'Naira', N'NGN', N'<p>
	Nigeria Currency</p>
', CAST(N'2021-06-11' AS Date), CAST(N'09:35:39.6300000' AS Time))
SET IDENTITY_INSERT [dbo].[tbl_currency] OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_dict_tables] ON 

INSERT [dbo].[tbl_dict_tables] ([rec_id], [table_name], [panel_id], [key_name], [created_date], [created_time]) VALUES (1, N'tbl_currency', N'PnlCurrency', N'rec_id', CAST(N'2021-05-14' AS Date), CAST(N'12:48:45.2400000' AS Time))
INSERT [dbo].[tbl_dict_tables] ([rec_id], [table_name], [panel_id], [key_name], [created_date], [created_time]) VALUES (2, N'tbl_productType', N'PnlProductType', N'rec_id', CAST(N'2021-05-14' AS Date), CAST(N'14:01:43.3300000' AS Time))
INSERT [dbo].[tbl_dict_tables] ([rec_id], [table_name], [panel_id], [key_name], [created_date], [created_time]) VALUES (3, N'tbl_unitType', N'PnlUnitType', N'rec_id', CAST(N'2021-05-14' AS Date), CAST(N'14:47:04.8870000' AS Time))
INSERT [dbo].[tbl_dict_tables] ([rec_id], [table_name], [panel_id], [key_name], [created_date], [created_time]) VALUES (4, N'tbl_branch', N'PnlBranch', N'rec_id', CAST(N'2021-05-14' AS Date), CAST(N'16:12:13.7530000' AS Time))
INSERT [dbo].[tbl_dict_tables] ([rec_id], [table_name], [panel_id], [key_name], [created_date], [created_time]) VALUES (5, N'tbl_warehouse', N'PnlWarehouse', N'rec_id', CAST(N'2021-05-14' AS Date), CAST(N'16:45:49.3530000' AS Time))
INSERT [dbo].[tbl_dict_tables] ([rec_id], [table_name], [panel_id], [key_name], [created_date], [created_time]) VALUES (6, N'tbl_userType', N'PnlUserType', N'rec_id', CAST(N'2021-05-15' AS Date), CAST(N'03:50:23.6100000' AS Time))
INSERT [dbo].[tbl_dict_tables] ([rec_id], [table_name], [panel_id], [key_name], [created_date], [created_time]) VALUES (7, N'tbl_manufacturer', N'PnlManufacturer', N'rec_id', CAST(N'2021-05-15' AS Date), CAST(N'04:17:53.8470000' AS Time))
INSERT [dbo].[tbl_dict_tables] ([rec_id], [table_name], [panel_id], [key_name], [created_date], [created_time]) VALUES (8, N'tbl_retailer', N'PnlRetailer', N'rec_id', CAST(N'2021-05-15' AS Date), CAST(N'04:27:23.6900000' AS Time))
INSERT [dbo].[tbl_dict_tables] ([rec_id], [table_name], [panel_id], [key_name], [created_date], [created_time]) VALUES (9, N'tbl_consumer', N'PnlConsumer', N'rec_id', CAST(N'2021-05-15' AS Date), CAST(N'04:27:51.6800000' AS Time))
INSERT [dbo].[tbl_dict_tables] ([rec_id], [table_name], [panel_id], [key_name], [created_date], [created_time]) VALUES (10, N'tbl_usermanagement', N'PnlUserManagement', N'rec_id', CAST(N'2021-05-15' AS Date), CAST(N'05:49:57.0970000' AS Time))
INSERT [dbo].[tbl_dict_tables] ([rec_id], [table_name], [panel_id], [key_name], [created_date], [created_time]) VALUES (11, N'tbl_administrator', N'PnlAdministrator', N'rec_id', CAST(N'2021-05-15' AS Date), CAST(N'17:00:11.3500000' AS Time))
INSERT [dbo].[tbl_dict_tables] ([rec_id], [table_name], [panel_id], [key_name], [created_date], [created_time]) VALUES (12, N'tbl_product', N'PnlProduct', N'rec_id', CAST(N'2021-05-15' AS Date), CAST(N'18:10:34.0300000' AS Time))
INSERT [dbo].[tbl_dict_tables] ([rec_id], [table_name], [panel_id], [key_name], [created_date], [created_time]) VALUES (10012, N'tbl_purchaseType', N'PnlPurchaseType', N'rec_id', CAST(N'2021-05-15' AS Date), CAST(N'23:48:09.7930000' AS Time))
INSERT [dbo].[tbl_dict_tables] ([rec_id], [table_name], [panel_id], [key_name], [created_date], [created_time]) VALUES (10013, N'tbl_order', N'PnlStockIssued', N'rec_id', CAST(N'2021-05-21' AS Date), CAST(N'16:18:03.7700000' AS Time))
INSERT [dbo].[tbl_dict_tables] ([rec_id], [table_name], [panel_id], [key_name], [created_date], [created_time]) VALUES (10014, N'tbl_transaction_stock', N'PnlTransactionStock', N'rec_id', CAST(N'2068-11-13' AS Date), CAST(N'12:17:21.6770000' AS Time))
INSERT [dbo].[tbl_dict_tables] ([rec_id], [table_name], [panel_id], [key_name], [created_date], [created_time]) VALUES (20014, N'tbl_courier', N'PnlCourier', N'rec_id', CAST(N'2068-11-13' AS Date), CAST(N'13:27:21.7830000' AS Time))
INSERT [dbo].[tbl_dict_tables] ([rec_id], [table_name], [panel_id], [key_name], [created_date], [created_time]) VALUES (20015, N'tbl_shipment', N'PnlCourierShipment', N'rec_id', CAST(N'2068-11-13' AS Date), CAST(N'14:27:03.0970000' AS Time))
SET IDENTITY_INSERT [dbo].[tbl_dict_tables] OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_feedbackMessage] ON 

INSERT [dbo].[tbl_feedbackMessage] ([ID], [Date], [Message], [positive], [negative], [neutral], [compound], [created_date], [created_time]) VALUES (1, CAST(N'2021-06-17T17:29:51.4166667' AS DateTime2), N'nice platform easy to use ', CAST(0.66 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.34 AS Decimal(18, 2)), CAST(0.69 AS Decimal(18, 2)), CAST(N'2021-06-17' AS Date), CAST(N'17:29:51.4166667' AS Time))
INSERT [dbo].[tbl_feedbackMessage] ([ID], [Date], [Message], [positive], [negative], [neutral], [compound], [created_date], [created_time]) VALUES (2, CAST(N'2021-06-17T18:07:55.3400000' AS DateTime2), N'please i hate this product', CAST(0.29 AS Decimal(18, 2)), CAST(0.46 AS Decimal(18, 2)), CAST(0.25 AS Decimal(18, 2)), CAST(-0.34 AS Decimal(18, 2)), CAST(N'2021-06-17' AS Date), CAST(N'18:07:55.3400000' AS Time))
INSERT [dbo].[tbl_feedbackMessage] ([ID], [Date], [Message], [positive], [negative], [neutral], [compound], [created_date], [created_time]) VALUES (10002, CAST(N'2021-06-21T10:02:03.8900000' AS DateTime2), N'i hate this bot', CAST(0.00 AS Decimal(18, 2)), CAST(0.65 AS Decimal(18, 2)), CAST(0.35 AS Decimal(18, 2)), CAST(-0.57 AS Decimal(18, 2)), CAST(N'2021-06-21' AS Date), CAST(N'10:02:03.8900000' AS Time))
INSERT [dbo].[tbl_feedbackMessage] ([ID], [Date], [Message], [positive], [negative], [neutral], [compound], [created_date], [created_time]) VALUES (10003, CAST(N'2021-07-01T17:21:02.6033333' AS DateTime2), N'i like this product alot. it is a good project. keep it up', CAST(0.38 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.63 AS Decimal(18, 2)), CAST(0.66 AS Decimal(18, 2)), CAST(N'2021-07-01' AS Date), CAST(N'17:21:02.6033333' AS Time))
INSERT [dbo].[tbl_feedbackMessage] ([ID], [Date], [Message], [positive], [negative], [neutral], [compound], [created_date], [created_time]) VALUES (10004, CAST(N'2021-07-10T05:47:31.2900000' AS DateTime2), N'hello', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(N'2021-07-10' AS Date), CAST(N'05:47:31.2900000' AS Time))
SET IDENTITY_INSERT [dbo].[tbl_feedbackMessage] OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_manufacturer] ON 

INSERT [dbo].[tbl_manufacturer] ([UserTypeID], [manufacturer_id], [first_name], [last_name], [email], [telephone_no], [country], [state], [address], [created_date], [created_time]) VALUES (1, 1, N'SINI ELECTRONICS', NULL, N'SINIELECTRONICS@GMAIL.COM', N'08154674645', N'Nigeria', N'Abuja', N'BWARI', CAST(N'2021-06-11' AS Date), CAST(N'09:36:43.2400000' AS Time))
SET IDENTITY_INSERT [dbo].[tbl_manufacturer] OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_message_log] ON 

INSERT [dbo].[tbl_message_log] ([log_id], [client_id], [client_message], [bot_message], [created_date], [created_time]) VALUES (8, 1, N'i want to buy tv', N' This is the product that fits your description<br/><div class=''panel''><div class=''panel-body''><section class=''product-area li-laptop-product pt-60 pb-45''><div class=''container''><div class=''row''><div class=''col-lg-12''><div class=''shop-products-wrapper''><div class=''tab-content''><div id=''grid-view'' class=''tab-pane fade active show'' role=''tabpanel''><div class=''product-area shop-product-area''><div class=''row''><div class=''col-lg-3 col-md-3 col-sm-3 mt-40''><div class=''single-product-wrap''><div class=''product-image''><a href=''#''><img src=''dist/2021611101HisenceAndriod1.jpg'' style=''width:20em; height:20em'' runat =''server''  alt=''Li''s Product Image''/></a></div><div class=''product_desc''><div class=''product_desc_info''><div class=''product-review''><h5 class=''manufacturer''><a href=''#''>MARCOS ELECTRONICS</a></h5></div><h4><a class=''product_name'' href=''#''>Hisense 65" Smart Uhd Led Tv 4k + Wall Bracket</a></h4><div class=''price-box''><span class=''new-price''>480000.00</span></div></div><div class=''add-actions''><ul class=''add-actions-link''><li class=''add-cart active''><a href=''Client-Pay'' class=''add-to-cart''><i class=''fa fa-paypal''></i>&nbsp Pay Now</a></li></ul></div></div></div></div></div></div></div></div></div></section></div></div>', CAST(N'2021-06-11' AS Date), CAST(N'15:54:44.5700000' AS Time))
INSERT [dbo].[tbl_message_log] ([log_id], [client_id], [client_message], [bot_message], [created_date], [created_time]) VALUES (9, 1, N'i want to cancel my order. my order id is 1', N'Your order has been cancelled. Our Retailer will contact you soon.', CAST(N'2021-06-11' AS Date), CAST(N'16:02:55.8633333' AS Time))
INSERT [dbo].[tbl_message_log] ([log_id], [client_id], [client_message], [bot_message], [created_date], [created_time]) VALUES (10, 1, N'i want to cancel my order. my order id is 1', N'Your order has been cancelled. Our Retailer will contact you soon.', CAST(N'2021-06-11' AS Date), CAST(N'16:04:09.6766667' AS Time))
INSERT [dbo].[tbl_message_log] ([log_id], [client_id], [client_message], [bot_message], [created_date], [created_time]) VALUES (11, 1, N'please i want to buy product', N' This is the product that fits your description<br/><div class=''panel''><div class=''panel-body''><section class=''product-area li-laptop-product pt-60 pb-45''><div class=''container''><div class=''row''><div class=''col-lg-12''><div class=''shop-products-wrapper''><div class=''tab-content''><div id=''grid-view'' class=''tab-pane fade active show'' role=''tabpanel''><div class=''product-area shop-product-area''><div class=''row''><div class=''col-lg-3 col-md-3 col-sm-3 mt-40''><div class=''single-product-wrap''><div class=''product-image''><a href=''#''><img src=''dist/2021611101HisenceAndriod1.jpg'' style=''width:20em; height:20em'' runat =''server''  alt=''Li''s Product Image''/></a></div><div class=''product_desc''><div class=''product_desc_info''><div class=''product-review''><h5 class=''manufacturer''><a href=''#''>MARCOS ELECTRONICS</a></h5></div><h4><a class=''product_name'' href=''#''>Hisense 65" Smart Uhd Led Tv 4k + Wall Bracket</a></h4><div class=''price-box''><span class=''new-price''>480000.00</span></div></div><div class=''add-actions''><ul class=''add-actions-link''><li class=''add-cart active''><a href=''Client-Pay'' class=''add-to-cart''><i class=''fa fa-paypal''></i>&nbsp Pay Now</a></li></ul></div></div></div></div></div></div></div></div></div></section></div></div>', CAST(N'2021-06-11' AS Date), CAST(N'16:13:24.8333333' AS Time))
INSERT [dbo].[tbl_message_log] ([log_id], [client_id], [client_message], [bot_message], [created_date], [created_time]) VALUES (12, 1, N'i want to buy 55 inches tv', N' This is the product that fits your description<br/><div class=''panel''><div class=''panel-body''><section class=''product-area li-laptop-product pt-60 pb-45''><div class=''container''><div class=''row''><div class=''col-lg-12''><div class=''shop-products-wrapper''><div class=''tab-content''><div id=''grid-view'' class=''tab-pane fade active show'' role=''tabpanel''><div class=''product-area shop-product-area''><div class=''row''><div class=''col-lg-3 col-md-3 col-sm-3 mt-40''><div class=''single-product-wrap''><div class=''product-image''><a href=''#''><img src=''dist/2021611101HisenceAndriod1.jpg'' style=''width:20em; height:20em'' runat =''server''  alt=''Li''s Product Image''/></a></div><div class=''product_desc''><div class=''product_desc_info''><div class=''product-review''><h5 class=''manufacturer''><a href=''#''>MARCOS ELECTRONICS</a></h5></div><h4><a class=''product_name'' href=''#''>Hisense 65" Smart Uhd Led Tv 4k + Wall Bracket</a></h4><div class=''price-box''><span class=''new-price''>480000.00</span></div></div><div class=''add-actions''><ul class=''add-actions-link''><li class=''add-cart active''><a href=''Client-Pay'' class=''add-to-cart''><i class=''fa fa-paypal''></i>&nbsp Pay Now</a></li></ul></div></div></div></div></div></div></div></div></div></section></div></div>', CAST(N'2021-06-11' AS Date), CAST(N'16:20:44.9433333' AS Time))
INSERT [dbo].[tbl_message_log] ([log_id], [client_id], [client_message], [bot_message], [created_date], [created_time]) VALUES (10002, 6, N'how are you?', N'I am fine. I am Sini bot. I am here to help you make order, track your order  and also cancel order. Please we are most interested in your feedback also so as to make my master Sini improve my intelligence', CAST(N'2021-06-11' AS Date), CAST(N'18:33:55.1800000' AS Time))
INSERT [dbo].[tbl_message_log] ([log_id], [client_id], [client_message], [bot_message], [created_date], [created_time]) VALUES (10003, 6, N'who did they create you?', N'Sini created me. I thank Mr Johnwendy for the idea. He is a researcher. I hope i will be approve to learn new things and solve NP Hard problems.', CAST(N'2021-06-11' AS Date), CAST(N'18:39:35.5300000' AS Time))
INSERT [dbo].[tbl_message_log] ([log_id], [client_id], [client_message], [bot_message], [created_date], [created_time]) VALUES (10004, 6, N'how are you', N'I am fine. I am Sini bot. I am here to help you make order, track your order  and also cancel order. Please we are most interested in your feedback also so as to make my master Sini improve my intelligence', CAST(N'2021-06-11' AS Date), CAST(N'19:05:52.5600000' AS Time))
INSERT [dbo].[tbl_message_log] ([log_id], [client_id], [client_message], [bot_message], [created_date], [created_time]) VALUES (10005, 6, N'hello', N'I am fine. I am Sini bot. I am here to help you make order, track your order  and also cancel order. Please we are most interested in your feedback also so as to make my master Sini improve my intelligence', CAST(N'2021-06-11' AS Date), CAST(N'19:07:12' AS Time))
INSERT [dbo].[tbl_message_log] ([log_id], [client_id], [client_message], [bot_message], [created_date], [created_time]) VALUES (10006, 6, N'hello', N'I am fine. I am Sini bot. I am here to help you make order, track your order  and also cancel order. Please we are most interested in your feedback also so as to make my master Sini improve my intelligence', CAST(N'2021-06-11' AS Date), CAST(N'19:11:28.1433333' AS Time))
INSERT [dbo].[tbl_message_log] ([log_id], [client_id], [client_message], [bot_message], [created_date], [created_time]) VALUES (10007, 6, N'hello fan', N'I am fine. I am Sini bot. I am here to help you make order, track your order  and also cancel order. Please we are most interested in your feedback also so as to make my master Sini improve my intelligence', CAST(N'2021-06-11' AS Date), CAST(N'19:12:39.5966667' AS Time))
INSERT [dbo].[tbl_message_log] ([log_id], [client_id], [client_message], [bot_message], [created_date], [created_time]) VALUES (10008, 6, N'hello', N'I am fine. I am Sini bot. I am here to help you make order, track your order  and also cancel order. Please we are most interested in your feedback also so as to make my master Sini improve my intelligence', CAST(N'2021-06-11' AS Date), CAST(N'19:25:37.4333333' AS Time))
INSERT [dbo].[tbl_message_log] ([log_id], [client_id], [client_message], [bot_message], [created_date], [created_time]) VALUES (10009, 6, N'i am cool', N'I am fine. I am Sini bot. I am here to help you make order, track your order  and also cancel order. Please we are most interested in your feedback also so as to make my master Sini improve my intelligence', CAST(N'2021-06-11' AS Date), CAST(N'19:27:19.2800000' AS Time))
INSERT [dbo].[tbl_message_log] ([log_id], [client_id], [client_message], [bot_message], [created_date], [created_time]) VALUES (20002, 6, N'hello', N'I am fine. I am Sini bot. I am here to help you make order, track your order  and also cancel order. Please we are most interested in your feedback also so as to make my master Sini improve my intelligence', CAST(N'2021-06-15' AS Date), CAST(N'13:44:50.3066667' AS Time))
INSERT [dbo].[tbl_message_log] ([log_id], [client_id], [client_message], [bot_message], [created_date], [created_time]) VALUES (20003, 6, N'please i want to buy phone', N' This is the product that fits your description<br/><div class=''panel''><div class=''panel-body''><section class=''product-area li-laptop-product pt-60 pb-45''><div class=''container''><div class=''row''><div class=''col-lg-12''><div class=''shop-products-wrapper''><div class=''tab-content''><div id=''grid-view'' class=''tab-pane fade active show'' role=''tabpanel''><div class=''product-area shop-product-area''><div class=''row''><div class=''col-lg-3 col-md-3 col-sm-3 mt-40''><div class=''single-product-wrap''><div class=''product-image''><a href=''#''><img src=''dist/2021611101HisenceAndriod1.jpg'' style=''width:20em; height:20em'' runat =''server''  alt=''Li''s Product Image''/></a></div><div class=''product_desc''><div class=''product_desc_info''><div class=''product-review''><h5 class=''manufacturer''><a href=''#''>MARCOS ELECTRONICS</a></h5></div><h4><a class=''product_name'' href=''#''>Hisense 65" Smart Uhd Led Tv 4k + Wall Bracket</a></h4><div class=''price-box''><span class=''new-price''>480000.00</span></div></div><div class=''add-actions''><ul class=''add-actions-link''><li class=''add-cart active''><a href=''Client-Pay'' class=''add-to-cart''><i class=''fa fa-paypal''></i>&nbsp Pay Now</a></li></ul></div></div></div></div></div></div></div></div></div></section></div></div><div class=''panel''><div class=''panel-body''><section class=''product-area li-laptop-product pt-60 pb-45''><div class=''container''><div class=''row''><div class=''col-lg-12''><div class=''shop-products-wrapper''><div class=''tab-content''><div id=''grid-view'' class=''tab-pane fade active show'' role=''tabpanel''><div class=''product-area shop-product-area''><div class=''row''><div class=''col-lg-3 col-md-3 col-sm-3 mt-40''><div class=''single-product-wrap''><div class=''product-image''><a href=''#''><img src=''dist/20216111544HicensedSmartTv1.jpg'' style=''width:20em; height:20em'' runat =''server''  alt=''Li''s Product Image''/></a></div><div class=''product_desc''><div class=''product_desc_info''><div class=''product-review''><h5 class=''manufacturer''><a href=''#''>MARCOS ELECTRONICS</a></h5></div><h4><a class=''product_name'' href=''#''>Hisense 55" Smart UHD LED 4k Tv + Wall Bracket</a></h4><div class=''price-box''><span class=''new-price''>295000.00</span></div></div><div class=''add-actions''><ul class=''add-actions-link''><li class=''add-cart active''><a href=''Client-Pay'' class=''add-to-cart''><i class=''fa fa-paypal''></i>&nbsp Pay Now</a></li></ul></div></div></div></div></div></div></div></div></div></section></div></div>', CAST(N'2021-06-15' AS Date), CAST(N'13:49:55.9433333' AS Time))
INSERT [dbo].[tbl_message_log] ([log_id], [client_id], [client_message], [bot_message], [created_date], [created_time]) VALUES (20004, 6, N'phone', N'Sini created me. I thank Mr Johnwendy for the idea. He is a researcher. I hope i will be approve to learn new things and solve NP Hard problems.', CAST(N'2021-06-15' AS Date), CAST(N'13:50:16.1833333' AS Time))
INSERT [dbo].[tbl_message_log] ([log_id], [client_id], [client_message], [bot_message], [created_date], [created_time]) VALUES (20005, 6, N'buy phone', N' This is the product that fits your description<br/><div class=''panel''><div class=''panel-body''><section class=''product-area li-laptop-product pt-60 pb-45''><div class=''container''><div class=''row''><div class=''col-lg-12''><div class=''shop-products-wrapper''><div class=''tab-content''><div id=''grid-view'' class=''tab-pane fade active show'' role=''tabpanel''><div class=''product-area shop-product-area''><div class=''row''><div class=''col-lg-3 col-md-3 col-sm-3 mt-40''><div class=''single-product-wrap''><div class=''product-image''><a href=''#''><img src=''dist/2021611101HisenceAndriod1.jpg'' style=''width:20em; height:20em'' runat =''server''  alt=''Li''s Product Image''/></a></div><div class=''product_desc''><div class=''product_desc_info''><div class=''product-review''><h5 class=''manufacturer''><a href=''#''>MARCOS ELECTRONICS</a></h5></div><h4><a class=''product_name'' href=''#''>Hisense 65" Smart Uhd Led Tv 4k + Wall Bracket</a></h4><div class=''price-box''><span class=''new-price''>480000.00</span></div></div><div class=''add-actions''><ul class=''add-actions-link''><li class=''add-cart active''><a href=''Client-Pay'' class=''add-to-cart''><i class=''fa fa-paypal''></i>&nbsp Pay Now</a></li></ul></div></div></div></div></div></div></div></div></div></section></div></div><div class=''panel''><div class=''panel-body''><section class=''product-area li-laptop-product pt-60 pb-45''><div class=''container''><div class=''row''><div class=''col-lg-12''><div class=''shop-products-wrapper''><div class=''tab-content''><div id=''grid-view'' class=''tab-pane fade active show'' role=''tabpanel''><div class=''product-area shop-product-area''><div class=''row''><div class=''col-lg-3 col-md-3 col-sm-3 mt-40''><div class=''single-product-wrap''><div class=''product-image''><a href=''#''><img src=''dist/20216111544HicensedSmartTv1.jpg'' style=''width:20em; height:20em'' runat =''server''  alt=''Li''s Product Image''/></a></div><div class=''product_desc''><div class=''product_desc_info''><div class=''product-review''><h5 class=''manufacturer''><a href=''#''>MARCOS ELECTRONICS</a></h5></div><h4><a class=''product_name'' href=''#''>Hisense 55" Smart UHD LED 4k Tv + Wall Bracket</a></h4><div class=''price-box''><span class=''new-price''>295000.00</span></div></div><div class=''add-actions''><ul class=''add-actions-link''><li class=''add-cart active''><a href=''Client-Pay'' class=''add-to-cart''><i class=''fa fa-paypal''></i>&nbsp Pay Now</a></li></ul></div></div></div></div></div></div></div></div></div></section></div></div>', CAST(N'2021-06-15' AS Date), CAST(N'13:50:31.5600000' AS Time))
INSERT [dbo].[tbl_message_log] ([log_id], [client_id], [client_message], [bot_message], [created_date], [created_time]) VALUES (30002, 6, N'please i want to buy phone', N' This is the product that fits your description<br/><div class=''panel''><div class=''panel-body''><section class=''product-area li-laptop-product pt-60 pb-45''><div class=''container''><div class=''row''><div class=''col-lg-12''><div class=''shop-products-wrapper''><div class=''tab-content''><div id=''grid-view'' class=''tab-pane fade active show'' role=''tabpanel''><div class=''product-area shop-product-area''><div class=''row''><div class=''col-lg-3 col-md-3 col-sm-3 mt-40''><div class=''single-product-wrap''><div class=''product-image''><a href=''#''><img src=''dist/2021611101HisenceAndriod1.jpg'' style=''width:20em; height:20em'' runat =''server''  alt=''Li''s Product Image''/></a></div><div class=''product_desc''><div class=''product_desc_info''><div class=''product-review''><h5 class=''manufacturer''><a href=''#''>MARCOS ELECTRONICS</a></h5></div><h4><a class=''product_name'' href=''#''>Hisense 65" Smart Uhd Led Tv 4k + Wall Bracket</a></h4><div class=''price-box''><span class=''new-price''>480000.00</span></div></div><div class=''add-actions''><ul class=''add-actions-link''><li class=''add-cart active''><a href=''Client-Pay'' class=''add-to-cart''><i class=''fa fa-paypal''></i>&nbsp Pay Now</a></li></ul></div></div></div></div></div></div></div></div></div></section></div></div><div class=''panel''><div class=''panel-body''><section class=''product-area li-laptop-product pt-60 pb-45''><div class=''container''><div class=''row''><div class=''col-lg-12''><div class=''shop-products-wrapper''><div class=''tab-content''><div id=''grid-view'' class=''tab-pane fade active show'' role=''tabpanel''><div class=''product-area shop-product-area''><div class=''row''><div class=''col-lg-3 col-md-3 col-sm-3 mt-40''><div class=''single-product-wrap''><div class=''product-image''><a href=''#''><img src=''dist/20216111544HicensedSmartTv1.jpg'' style=''width:20em; height:20em'' runat =''server''  alt=''Li''s Product Image''/></a></div><div class=''product_desc''><div class=''product_desc_info''><div class=''product-review''><h5 class=''manufacturer''><a href=''#''>MARCOS ELECTRONICS</a></h5></div><h4><a class=''product_name'' href=''#''>Hisense 55" Smart UHD LED 4k Tv + Wall Bracket</a></h4><div class=''price-box''><span class=''new-price''>295000.00</span></div></div><div class=''add-actions''><ul class=''add-actions-link''><li class=''add-cart active''><a href=''Client-Pay'' class=''add-to-cart''><i class=''fa fa-paypal''></i>&nbsp Pay Now</a></li></ul></div></div></div></div></div></div></div></div></div></section></div></div>', CAST(N'2021-06-17' AS Date), CAST(N'09:29:36.8733333' AS Time))
INSERT [dbo].[tbl_message_log] ([log_id], [client_id], [client_message], [bot_message], [created_date], [created_time]) VALUES (30003, 6, N'helo', N'I am fine. I am Sini bot. I am here to help you make order, track your order  and also cancel order. Please we are most interested in your feedback also so as to make my master Sini improve my intelligence', CAST(N'2021-06-17' AS Date), CAST(N'09:34:41.8233333' AS Time))
INSERT [dbo].[tbl_message_log] ([log_id], [client_id], [client_message], [bot_message], [created_date], [created_time]) VALUES (30004, 6, N'hello', N'I am fine. I am Sini bot. I am here to help you make order, track your order  and also cancel order. Please we are most interested in your feedback also so as to make my master Sini improve my intelligence', CAST(N'2021-06-17' AS Date), CAST(N'11:02:29.4466667' AS Time))
INSERT [dbo].[tbl_message_log] ([log_id], [client_id], [client_message], [bot_message], [created_date], [created_time]) VALUES (30005, 6, N'please i want to buy phone', N' This is the product that fits your description<br/><div class=''panel''><div class=''panel-body''><section class=''product-area li-laptop-product pt-60 pb-45''><div class=''container''><div class=''row''><div class=''col-lg-12''><div class=''shop-products-wrapper''><div class=''tab-content''><div id=''grid-view'' class=''tab-pane fade active show'' role=''tabpanel''><div class=''product-area shop-product-area''><div class=''row''><div class=''col-lg-3 col-md-3 col-sm-3 mt-40''><div class=''single-product-wrap''><div class=''product-image''><a href=''#''><img src=''dist/2021611101HisenceAndriod1.jpg'' style=''width:20em; height:20em'' runat =''server''  alt=''Li''s Product Image''/></a></div><div class=''product_desc''><div class=''product_desc_info''><div class=''product-review''><h5 class=''manufacturer''><a href=''#''>MARCOS ELECTRONICS</a></h5></div><h4><a class=''product_name'' href=''#''>Television Hisense 65" Smart Uhd Led Tv 4k + Wall Bracket</a></h4><div class=''price-box''><span class=''new-price''>480000.00</span></div></div><div class=''add-actions''><ul class=''add-actions-link''><li class=''add-cart active''><a href=''Client-Pay'' class=''add-to-cart''><i class=''fa fa-paypal''></i>&nbsp Pay Now</a></li></ul></div></div></div></div></div></div></div></div></div></section></div></div><div class=''panel''><div class=''panel-body''><section class=''product-area li-laptop-product pt-60 pb-45''><div class=''container''><div class=''row''><div class=''col-lg-12''><div class=''shop-products-wrapper''><div class=''tab-content''><div id=''grid-view'' class=''tab-pane fade active show'' role=''tabpanel''><div class=''product-area shop-product-area''><div class=''row''><div class=''col-lg-3 col-md-3 col-sm-3 mt-40''><div class=''single-product-wrap''><div class=''product-image''><a href=''#''><img src=''dist/20216111544HicensedSmartTv1.jpg'' style=''width:20em; height:20em'' runat =''server''  alt=''Li''s Product Image''/></a></div><div class=''product_desc''><div class=''product_desc_info''><div class=''product-review''><h5 class=''manufacturer''><a href=''#''>MARCOS ELECTRONICS</a></h5></div><h4><a class=''product_name'' href=''#''>Television Hisense 55" Smart UHD LED 4k Tv + Wall Bracket</a></h4><div class=''price-box''><span class=''new-price''>295000.00</span></div></div><div class=''add-actions''><ul class=''add-actions-link''><li class=''add-cart active''><a href=''Client-Pay'' class=''add-to-cart''><i class=''fa fa-paypal''></i>&nbsp Pay Now</a></li></ul></div></div></div></div></div></div></div></div></div></section></div></div>', CAST(N'2021-06-17' AS Date), CAST(N'11:02:39.6900000' AS Time))
INSERT [dbo].[tbl_message_log] ([log_id], [client_id], [client_message], [bot_message], [created_date], [created_time]) VALUES (30006, 6, N'helo', N'I am fine. I am Sini bot. I am here to help you make order, track your order  and also cancel order. Please we are most interested in your feedback also so as to make my master Sini improve my intelligence', CAST(N'2021-06-17' AS Date), CAST(N'11:04:09.3333333' AS Time))
INSERT [dbo].[tbl_message_log] ([log_id], [client_id], [client_message], [bot_message], [created_date], [created_time]) VALUES (30007, 6, N'please i want to buy phone', N' This is the product that fits your description<br/><div class=''panel''><div class=''panel-body''><section class=''product-area li-laptop-product pt-60 pb-45''><div class=''container''><div class=''row''><div class=''col-lg-12''><div class=''shop-products-wrapper''><div class=''tab-content''><div id=''grid-view'' class=''tab-pane fade active show'' role=''tabpanel''><div class=''product-area shop-product-area''><div class=''row''><div class=''col-lg-3 col-md-3 col-sm-3 mt-40''><div class=''single-product-wrap''><div class=''product-image''><a href=''#''><img src=''dist/2021611101HisenceAndriod1.jpg'' style=''width:20em; height:20em'' runat =''server''  alt=''Li''s Product Image''/></a></div><div class=''product_desc''><div class=''product_desc_info''><div class=''product-review''><h5 class=''manufacturer''><a href=''#''>MARCOS ELECTRONICS</a></h5></div><h4><a class=''product_name'' href=''#''>Television Hisense 65" Smart Uhd Led Tv 4k + Wall Bracket</a></h4><div class=''price-box''><span class=''new-price''>480000.00</span></div></div><div class=''add-actions''><ul class=''add-actions-link''><li class=''add-cart active''><a href=''Client-Pay'' class=''add-to-cart''><i class=''fa fa-paypal''></i>&nbsp Pay Now</a></li></ul></div></div></div></div></div></div></div></div></div></section></div></div>', CAST(N'2021-06-17' AS Date), CAST(N'11:04:16.4733333' AS Time))
INSERT [dbo].[tbl_message_log] ([log_id], [client_id], [client_message], [bot_message], [created_date], [created_time]) VALUES (30008, 6, N'please i want to buy phone', N' This is the product that fits your description<br/><div class=''panel''><div class=''panel-body''><section class=''product-area li-laptop-product pt-60 pb-45''><div class=''container''><div class=''row''><div class=''col-lg-12''><div class=''shop-products-wrapper''><div class=''tab-content''><div id=''grid-view'' class=''tab-pane fade active show'' role=''tabpanel''><div class=''product-area shop-product-area''><div class=''row''><div class=''col-lg-3 col-md-3 col-sm-3 mt-40''><div class=''single-product-wrap''><div class=''product-image''><a href=''#''><img src=''dist/20216151349phone1.jpg'' style=''width:20em; height:20em'' runat =''server''  alt=''Li''s Product Image''/></a></div><div class=''product_desc''><div class=''product_desc_info''><div class=''product-review''><h5 class=''manufacturer''><a href=''#''>MARCOS ELECTRONICS</a></h5></div><h4><a class=''product_name'' href=''#''>Phone Samsung Galaxy A02 - 2/32GB Memory,Dual SIM, 5,000Mah Battery, 4G LTE - Black</a></h4><div class=''price-box''><span class=''new-price''>38900.00</span></div></div><div class=''add-actions''><ul class=''add-actions-link''><li class=''add-cart active''><a href=''Client-Pay'' class=''add-to-cart''><i class=''fa fa-paypal''></i>&nbsp Pay Now</a></li></ul></div></div></div></div></div></div></div></div></div></section></div></div>', CAST(N'2021-06-17' AS Date), CAST(N'11:05:10.0733333' AS Time))
INSERT [dbo].[tbl_message_log] ([log_id], [client_id], [client_message], [bot_message], [created_date], [created_time]) VALUES (30009, 6, N'please i want to buy television', N' This is the product that fits your description<br/><div class=''panel''><div class=''panel-body''><section class=''product-area li-laptop-product pt-60 pb-45''><div class=''container''><div class=''row''><div class=''col-lg-12''><div class=''shop-products-wrapper''><div class=''tab-content''><div id=''grid-view'' class=''tab-pane fade active show'' role=''tabpanel''><div class=''product-area shop-product-area''><div class=''row''><div class=''col-lg-3 col-md-3 col-sm-3 mt-40''><div class=''single-product-wrap''><div class=''product-image''><a href=''#''><img src=''dist/20216151349phone1.jpg'' style=''width:20em; height:20em'' runat =''server''  alt=''Li''s Product Image''/></a></div><div class=''product_desc''><div class=''product_desc_info''><div class=''product-review''><h5 class=''manufacturer''><a href=''#''>MARCOS ELECTRONICS</a></h5></div><h4><a class=''product_name'' href=''#''>Phone Samsung Galaxy A02 - 2/32GB Memory,Dual SIM, 5,000Mah Battery, 4G LTE - Black</a></h4><div class=''price-box''><span class=''new-price''>38900.00</span></div></div><div class=''add-actions''><ul class=''add-actions-link''><li class=''add-cart active''><a href=''Client-Pay'' class=''add-to-cart''><i class=''fa fa-paypal''></i>&nbsp Pay Now</a></li></ul></div></div></div></div></div></div></div></div></div></section></div></div>', CAST(N'2021-06-17' AS Date), CAST(N'11:05:21.7566667' AS Time))
INSERT [dbo].[tbl_message_log] ([log_id], [client_id], [client_message], [bot_message], [created_date], [created_time]) VALUES (30010, 6, N'i want to buy television', N' This is the product that fits your description<br/><div class=''panel''><div class=''panel-body''><section class=''product-area li-laptop-product pt-60 pb-45''><div class=''container''><div class=''row''><div class=''col-lg-12''><div class=''shop-products-wrapper''><div class=''tab-content''><div id=''grid-view'' class=''tab-pane fade active show'' role=''tabpanel''><div class=''product-area shop-product-area''><div class=''row''><div class=''col-lg-3 col-md-3 col-sm-3 mt-40''><div class=''single-product-wrap''><div class=''product-image''><a href=''#''><img src=''dist/20216151349phone1.jpg'' style=''width:20em; height:20em'' runat =''server''  alt=''Li''s Product Image''/></a></div><div class=''product_desc''><div class=''product_desc_info''><div class=''product-review''><h5 class=''manufacturer''><a href=''#''>MARCOS ELECTRONICS</a></h5></div><h4><a class=''product_name'' href=''#''>Phone Samsung Galaxy A02 - 2/32GB Memory,Dual SIM, 5,000Mah Battery, 4G LTE - Black</a></h4><div class=''price-box''><span class=''new-price''>38900.00</span></div></div><div class=''add-actions''><ul class=''add-actions-link''><li class=''add-cart active''><a href=''Client-Pay'' class=''add-to-cart''><i class=''fa fa-paypal''></i>&nbsp Pay Now</a></li></ul></div></div></div></div></div></div></div></div></div></section></div></div>', CAST(N'2021-06-17' AS Date), CAST(N'11:05:37.1566667' AS Time))
INSERT [dbo].[tbl_message_log] ([log_id], [client_id], [client_message], [bot_message], [created_date], [created_time]) VALUES (30011, 6, N'i want to buy hisence tv with 65', N' This is the product that fits your description<br/><div class=''panel''><div class=''panel-body''><section class=''product-area li-laptop-product pt-60 pb-45''><div class=''container''><div class=''row''><div class=''col-lg-12''><div class=''shop-products-wrapper''><div class=''tab-content''><div id=''grid-view'' class=''tab-pane fade active show'' role=''tabpanel''><div class=''product-area shop-product-area''><div class=''row''><div class=''col-lg-3 col-md-3 col-sm-3 mt-40''><div class=''single-product-wrap''><div class=''product-image''><a href=''#''><img src=''dist/2021611101HisenceAndriod1.jpg'' style=''width:20em; height:20em'' runat =''server''  alt=''Li''s Product Image''/></a></div><div class=''product_desc''><div class=''product_desc_info''><div class=''product-review''><h5 class=''manufacturer''><a href=''#''>MARCOS ELECTRONICS</a></h5></div><h4><a class=''product_name'' href=''#''>Television Hisense 65" Smart Uhd Led Tv 4k + Wall Bracket</a></h4><div class=''price-box''><span class=''new-price''>480000.00</span></div></div><div class=''add-actions''><ul class=''add-actions-link''><li class=''add-cart active''><a href=''Client-Pay'' class=''add-to-cart''><i class=''fa fa-paypal''></i>&nbsp Pay Now</a></li></ul></div></div></div></div></div></div></div></div></div></section></div></div>', CAST(N'2021-06-17' AS Date), CAST(N'11:10:10.3000000' AS Time))
INSERT [dbo].[tbl_message_log] ([log_id], [client_id], [client_message], [bot_message], [created_date], [created_time]) VALUES (30012, 6, N'i want to buy hisence tv with 55', N' This is the product that fits your description<br/><div class=''panel''><div class=''panel-body''><section class=''product-area li-laptop-product pt-60 pb-45''><div class=''container''><div class=''row''><div class=''col-lg-12''><div class=''shop-products-wrapper''><div class=''tab-content''><div id=''grid-view'' class=''tab-pane fade active show'' role=''tabpanel''><div class=''product-area shop-product-area''><div class=''row''><div class=''col-lg-3 col-md-3 col-sm-3 mt-40''><div class=''single-product-wrap''><div class=''product-image''><a href=''#''><img src=''dist/20216111544HicensedSmartTv1.jpg'' style=''width:20em; height:20em'' runat =''server''  alt=''Li''s Product Image''/></a></div><div class=''product_desc''><div class=''product_desc_info''><div class=''product-review''><h5 class=''manufacturer''><a href=''#''>MARCOS ELECTRONICS</a></h5></div><h4><a class=''product_name'' href=''#''>Television Hisense 55" Smart UHD LED 4k Tv + Wall Bracket</a></h4><div class=''price-box''><span class=''new-price''>295000.00</span></div></div><div class=''add-actions''><ul class=''add-actions-link''><li class=''add-cart active''><a href=''Client-Pay'' class=''add-to-cart''><i class=''fa fa-paypal''></i>&nbsp Pay Now</a></li></ul></div></div></div></div></div></div></div></div></div></section></div></div>', CAST(N'2021-06-17' AS Date), CAST(N'11:10:17.4400000' AS Time))
INSERT [dbo].[tbl_message_log] ([log_id], [client_id], [client_message], [bot_message], [created_date], [created_time]) VALUES (30013, 6, N'i want to buy phone', N' This is the product that fits your description<br/><div class=''panel''><div class=''panel-body''><section class=''product-area li-laptop-product pt-60 pb-45''><div class=''container''><div class=''row''><div class=''col-lg-12''><div class=''shop-products-wrapper''><div class=''tab-content''><div id=''grid-view'' class=''tab-pane fade active show'' role=''tabpanel''><div class=''product-area shop-product-area''><div class=''row''><div class=''col-lg-3 col-md-3 col-sm-3 mt-40''><div class=''single-product-wrap''><div class=''product-image''><a href=''#''><img src=''dist/20216111544HicensedSmartTv1.jpg'' style=''width:20em; height:20em'' runat =''server''  alt=''Li''s Product Image''/></a></div><div class=''product_desc''><div class=''product_desc_info''><div class=''product-review''><h5 class=''manufacturer''><a href=''#''>MARCOS ELECTRONICS</a></h5></div><h4><a class=''product_name'' href=''#''>Television Hisense 55" Smart UHD LED 4k Tv + Wall Bracket</a></h4><div class=''price-box''><span class=''new-price''>295000.00</span></div></div><div class=''add-actions''><ul class=''add-actions-link''><li class=''add-cart active''><a href=''Client-Pay'' class=''add-to-cart''><i class=''fa fa-paypal''></i>&nbsp Pay Now</a></li></ul></div></div></div></div></div></div></div></div></div></section></div></div>', CAST(N'2021-06-17' AS Date), CAST(N'11:10:31.3100000' AS Time))
INSERT [dbo].[tbl_message_log] ([log_id], [client_id], [client_message], [bot_message], [created_date], [created_time]) VALUES (30014, 6, N'hello', N'I am fine. I am Sini bot. I am here to help you make order, track your order  and also cancel order. Please we are most interested in your feedback also so as to make my master Sini improve my intelligence', CAST(N'2021-06-17' AS Date), CAST(N'15:48:03.3733333' AS Time))
INSERT [dbo].[tbl_message_log] ([log_id], [client_id], [client_message], [bot_message], [created_date], [created_time]) VALUES (30015, 6, N' who created me', N'Sini created me. I thank Mr Johnwendy for the idea. He is a researcher. I hope i will be approve to learn new things and solve NP Hard problems.', CAST(N'2021-06-17' AS Date), CAST(N'16:04:21.1233333' AS Time))
INSERT [dbo].[tbl_message_log] ([log_id], [client_id], [client_message], [bot_message], [created_date], [created_time]) VALUES (30016, 6, N'please i want to buy tv', N' This is the product that fits your description<br/><div class=''panel''><div class=''panel-body''><section class=''product-area li-laptop-product pt-60 pb-45''><div class=''container''><div class=''row''><div class=''col-lg-12''><div class=''shop-products-wrapper''><div class=''tab-content''><div id=''grid-view'' class=''tab-pane fade active show'' role=''tabpanel''><div class=''product-area shop-product-area''><div class=''row''><div class=''col-lg-3 col-md-3 col-sm-3 mt-40''><div class=''single-product-wrap''><div class=''product-image''><a href=''#''><img src=''dist/20216111544HicensedSmartTv1.jpg'' style=''width:20em; height:20em'' runat =''server''  alt=''Li''s Product Image''/></a></div><div class=''product_desc''><div class=''product_desc_info''><div class=''product-review''><h5 class=''manufacturer''><a href=''#''>MARCOS ELECTRONICS</a></h5></div><h4><a class=''product_name'' href=''#''>Television Hisense 55" Smart UHD LED 4k Tv + Wall Bracket</a></h4><div class=''price-box''><span class=''new-price''>295000.00</span></div></div><div class=''add-actions''><ul class=''add-actions-link''><li class=''add-cart active''><a href=''Client-Pay'' class=''add-to-cart''><i class=''fa fa-paypal''></i>&nbsp Pay Now</a></li></ul></div></div></div></div></div></div></div></div></div></section></div></div>', CAST(N'2021-06-17' AS Date), CAST(N'16:09:07.8200000' AS Time))
INSERT [dbo].[tbl_message_log] ([log_id], [client_id], [client_message], [bot_message], [created_date], [created_time]) VALUES (60016, 10006, N' h', N'I am fine. I am Sini bot. I am here to help you make order, track your order  and also cancel order. Please we are most interested in your feedback also so as to make my master Sini improve my intelligence', CAST(N'2021-06-23' AS Date), CAST(N'16:28:33' AS Time))
INSERT [dbo].[tbl_message_log] ([log_id], [client_id], [client_message], [bot_message], [created_date], [created_time]) VALUES (60017, 10006, N'hello', N'I am fine. I am Sini bot. I am here to help you make order, track your order  and also cancel order. Please we are most interested in your feedback also so as to make my master Sini improve my intelligence', CAST(N'2021-06-23' AS Date), CAST(N'16:28:36.1566667' AS Time))
INSERT [dbo].[tbl_message_log] ([log_id], [client_id], [client_message], [bot_message], [created_date], [created_time]) VALUES (60018, 10007, N'hello', N'I am fine. I am Sini bot. I am here to help you make order, track your order  and also cancel order. Please we are most interested in your feedback also so as to make my master Sini improve my intelligence', CAST(N'2021-06-27' AS Date), CAST(N'14:22:37.7300000' AS Time))
INSERT [dbo].[tbl_message_log] ([log_id], [client_id], [client_message], [bot_message], [created_date], [created_time]) VALUES (60019, 10007, N'how are you doing?', N'I am fine. I am Sini bot. I am here to help you make order, track your order  and also cancel order. Please we are most interested in your feedback also so as to make my master Sini improve my intelligence', CAST(N'2021-06-27' AS Date), CAST(N'14:22:47.9600000' AS Time))
INSERT [dbo].[tbl_message_log] ([log_id], [client_id], [client_message], [bot_message], [created_date], [created_time]) VALUES (60020, 10007, N'please i want to buy hisenc tv', N' This is the product that fits your description<br/><div class=''panel''><div class=''panel-body''><section class=''product-area li-laptop-product pt-60 pb-45''><div class=''container''><div class=''row''><div class=''col-lg-12''><div class=''shop-products-wrapper''><div class=''tab-content''><div id=''grid-view'' class=''tab-pane fade active show'' role=''tabpanel''><div class=''product-area shop-product-area''><div class=''row''><div class=''col-lg-3 col-md-3 col-sm-3 mt-40''><div class=''single-product-wrap''><div class=''product-image''><a href=''#''><img src=''dist/2021611101HisenceAndriod1.jpg'' style=''width:20em; height:20em'' runat =''server''  alt=''Li''s Product Image''/></a></div><div class=''product_desc''><div class=''product_desc_info''><div class=''product-review''><h5 class=''manufacturer''><a href=''#''>MARCOS ELECTRONICS</a></h5></div><h4><a class=''product_name'' href=''#''>Television Hisense 65" Smart Uhd Led Tv 4k + Wall Bracket</a></h4><div class=''price-box''><span class=''new-price''>480000.00</span></div></div><div class=''add-actions''><ul class=''add-actions-link''><li class=''add-cart active''><a href=''Client-Pay'' class=''add-to-cart''><i class=''fa fa-paypal''></i>&nbsp Pay Now</a></li></ul></div></div></div></div></div></div></div></div></div></section></div></div>', CAST(N'2021-06-27' AS Date), CAST(N'14:23:06.9133333' AS Time))
INSERT [dbo].[tbl_message_log] ([log_id], [client_id], [client_message], [bot_message], [created_date], [created_time]) VALUES (70018, 10007, N'hello', N'I am fine. I am Sini bot. I am here to help you make order, track your order  and also cancel order. Please we are most interested in your feedback also so as to make my master Sini improve my intelligence', CAST(N'2021-06-29' AS Date), CAST(N'11:46:00.6766667' AS Time))
INSERT [dbo].[tbl_message_log] ([log_id], [client_id], [client_message], [bot_message], [created_date], [created_time]) VALUES (70019, 10007, N'who created you', N'Sini created me. I thank Mr Johnwendy for the idea. He is a researcher. I hope i will be approve to learn new things and solve NP Hard problems.', CAST(N'2021-06-29' AS Date), CAST(N'11:46:14.1600000' AS Time))
INSERT [dbo].[tbl_message_log] ([log_id], [client_id], [client_message], [bot_message], [created_date], [created_time]) VALUES (70020, 10007, N'please i want to buy hisence tv', N' This is the product that fits your description<br/><div class=''panel''><div class=''panel-body''><section class=''product-area li-laptop-product pt-60 pb-45''><div class=''container''><div class=''row''><div class=''col-lg-12''><div class=''shop-products-wrapper''><div class=''tab-content''><div id=''grid-view'' class=''tab-pane fade active show'' role=''tabpanel''><div class=''product-area shop-product-area''><div class=''row''><div class=''col-lg-3 col-md-3 col-sm-3 mt-40''><div class=''single-product-wrap''><div class=''product-image''><a href=''#''><img src=''dist/2021611101HisenceAndriod1.jpg'' style=''width:20em; height:20em'' runat =''server''  alt=''Li''s Product Image''/></a></div><div class=''product_desc''><div class=''product_desc_info''><div class=''product-review''><h5 class=''manufacturer''><a href=''#''>MARCOS ELECTRONICS</a></h5></div><h4><a class=''product_name'' href=''#''>Television Hisense 65" Smart Uhd Led Tv 4k + Wall Bracket</a></h4><div class=''price-box''><span class=''new-price''>480000.00</span></div></div><div class=''add-actions''><ul class=''add-actions-link''><li class=''add-cart active''><a href=''Client-Pay'' class=''add-to-cart''><i class=''fa fa-paypal''></i>&nbsp Pay Now</a></li></ul></div></div></div></div></div></div></div></div></div></section></div></div>', CAST(N'2021-06-29' AS Date), CAST(N'11:46:43.7100000' AS Time))
INSERT [dbo].[tbl_message_log] ([log_id], [client_id], [client_message], [bot_message], [created_date], [created_time]) VALUES (70021, 10007, N'hello', N'I am fine. I am Sini bot. I am here to help you make order, track your order  and also cancel order. Please we are most interested in your feedback also so as to make my master Sini improve my intelligence', CAST(N'2021-07-01' AS Date), CAST(N'17:20:10.9833333' AS Time))
INSERT [dbo].[tbl_message_log] ([log_id], [client_id], [client_message], [bot_message], [created_date], [created_time]) VALUES (70022, 10007, N'how are you doing?', N'I am fine. I am Sini bot. I am here to help you make order, track your order  and also cancel order. Please we are most interested in your feedback also so as to make my master Sini improve my intelligence', CAST(N'2021-07-01' AS Date), CAST(N'17:20:20.5200000' AS Time))
INSERT [dbo].[tbl_message_log] ([log_id], [client_id], [client_message], [bot_message], [created_date], [created_time]) VALUES (70023, 10007, N'hello', N'I am fine. I am Sini bot. I am here to help you make order, track your order  and also cancel order. Please we are most interested in your feedback also so as to make my master Sini improve my intelligence', CAST(N'2021-07-10' AS Date), CAST(N'05:46:00.1533333' AS Time))
INSERT [dbo].[tbl_message_log] ([log_id], [client_id], [client_message], [bot_message], [created_date], [created_time]) VALUES (70024, 10007, N'how are you doing', N'I am fine. I am Sini bot. I am here to help you make order, track your order  and also cancel order. Please we are most interested in your feedback also so as to make my master Sini improve my intelligence', CAST(N'2021-07-10' AS Date), CAST(N'05:46:15.2300000' AS Time))
INSERT [dbo].[tbl_message_log] ([log_id], [client_id], [client_message], [bot_message], [created_date], [created_time]) VALUES (70025, 10007, N'okey.please i want to buy hisence tv', N' This is the product that fits your description<br/><div class=''panel''><div class=''panel-body''><section class=''product-area li-laptop-product pt-60 pb-45''><div class=''container''><div class=''row''><div class=''col-lg-12''><div class=''shop-products-wrapper''><div class=''tab-content''><div id=''grid-view'' class=''tab-pane fade active show'' role=''tabpanel''><div class=''product-area shop-product-area''><div class=''row''><div class=''col-lg-3 col-md-3 col-sm-3 mt-40''><div class=''single-product-wrap''><div class=''product-image''><a href=''#''><img src=''dist/2021611101HisenceAndriod1.jpg'' style=''width:20em; height:20em'' runat =''server''  alt=''Li''s Product Image''/></a></div><div class=''product_desc''><div class=''product_desc_info''><div class=''product-review''><h5 class=''manufacturer''><a href=''#''>MARCOS ELECTRONICS</a></h5></div><h4><a class=''product_name'' href=''#''>Television Hisense 65" Smart Uhd Led Tv 4k + Wall Bracket</a></h4><div class=''price-box''><span class=''new-price''>480000.00</span></div></div><div class=''add-actions''><ul class=''add-actions-link''><li class=''add-cart active''><a href=''Client-Pay'' class=''add-to-cart''><i class=''fa fa-paypal''></i>&nbsp Pay Now</a></li></ul></div></div></div></div></div></div></div></div></div></section></div></div>', CAST(N'2021-07-10' AS Date), CAST(N'05:46:42.7366667' AS Time))
INSERT [dbo].[tbl_message_log] ([log_id], [client_id], [client_message], [bot_message], [created_date], [created_time]) VALUES (70026, 10007, N'how are you doing', N'I am fine. I am Sini bot. I am here to help you make order, track your order  and also cancel order. Please we are most interested in your feedback also so as to make my master Sini improve my intelligence', CAST(N'2021-07-12' AS Date), CAST(N'10:08:54.0766667' AS Time))
INSERT [dbo].[tbl_message_log] ([log_id], [client_id], [client_message], [bot_message], [created_date], [created_time]) VALUES (80026, 10007, N'how are you doing', N'I am fine. I am Sini bot. I am here to help you make order, track your order  and also cancel order. Please we are most interested in your feedback also so as to make my master Sini improve my intelligence', CAST(N'2021-07-17' AS Date), CAST(N'07:26:28.4966667' AS Time))
INSERT [dbo].[tbl_message_log] ([log_id], [client_id], [client_message], [bot_message], [created_date], [created_time]) VALUES (80027, 10007, N'how are you', N'I am doing great and you?', CAST(N'2021-07-17' AS Date), CAST(N'07:35:48.9833333' AS Time))
INSERT [dbo].[tbl_message_log] ([log_id], [client_id], [client_message], [bot_message], [created_date], [created_time]) VALUES (80028, 10007, N'i am fine', N'That is cool, good to know. so what can i do for you?', CAST(N'2021-07-17' AS Date), CAST(N'07:35:54.9966667' AS Time))
INSERT [dbo].[tbl_message_log] ([log_id], [client_id], [client_message], [bot_message], [created_date], [created_time]) VALUES (80029, 10007, N'i want to buy hisence tv', N' This is the product that fits your description<br/><div class=''panel''><div class=''panel-body''><section class=''product-area li-laptop-product pt-60 pb-45''><div class=''container''><div class=''row''><div class=''col-lg-12''><div class=''shop-products-wrapper''><div class=''tab-content''><div id=''grid-view'' class=''tab-pane fade active show'' role=''tabpanel''><div class=''product-area shop-product-area''><div class=''row''><div class=''col-lg-3 col-md-3 col-sm-3 mt-40''><div class=''single-product-wrap''><div class=''product-image''><a href=''#''><img src=''dist/2021611101HisenceAndriod1.jpg'' style=''width:20em; height:20em'' runat =''server''  alt=''Li''s Product Image''/></a></div><div class=''product_desc''><div class=''product_desc_info''><div class=''product-review''><h5 class=''manufacturer''><a href=''#''>MARCOS ELECTRONICS</a></h5></div><h4><a class=''product_name'' href=''#''>Television Hisense 65" Smart Uhd Led Tv 4k + Wall Bracket</a></h4><div class=''price-box''><span class=''new-price''>480000.00</span></div></div><div class=''add-actions''><ul class=''add-actions-link''><li class=''add-cart active''><a href=''Client-Pay'' class=''add-to-cart''><i class=''fa fa-paypal''></i>&nbsp Pay Now</a></li></ul></div></div></div></div></div></div></div></div></div></section></div></div>', CAST(N'2021-07-17' AS Date), CAST(N'07:36:07.9833333' AS Time))
INSERT [dbo].[tbl_message_log] ([log_id], [client_id], [client_message], [bot_message], [created_date], [created_time]) VALUES (80030, 10007, N'how do you feel today', N'I am doing great and you?', CAST(N'2021-07-17' AS Date), CAST(N'07:36:29.7366667' AS Time))
INSERT [dbo].[tbl_message_log] ([log_id], [client_id], [client_message], [bot_message], [created_date], [created_time]) VALUES (80031, 10007, N'how did you feel', N'i really don;t know how i feel but i was just built to answer your queries on search product, track and delete your order', CAST(N'2021-07-17' AS Date), CAST(N'07:37:34.8133333' AS Time))
INSERT [dbo].[tbl_message_log] ([log_id], [client_id], [client_message], [bot_message], [created_date], [created_time]) VALUES (80032, 10007, N'are you okey', N'My intelligence is  minor. Just for this closed domain purpose for Sini business to consumer supply chain management. Well, as a matter of fact i am fully well okey as you can see. If i talk stupidly, please do not hesitate to click the action button to take a survey so that i will be improve upon.', CAST(N'2021-07-17' AS Date), CAST(N'07:39:10.5966667' AS Time))
INSERT [dbo].[tbl_message_log] ([log_id], [client_id], [client_message], [bot_message], [created_date], [created_time]) VALUES (80033, 10007, N'you are sick', N'My intelligence is  minor. Just for this closed domain purpose for Sini business to consumer supply chain management. Well, as a matter of fact i am fully well okey as you can see. If i talk stupidly, please do not hesitate to click the action button to take a survey so that i will be improve upon.', CAST(N'2021-07-17' AS Date), CAST(N'07:48:02.3466667' AS Time))
INSERT [dbo].[tbl_message_log] ([log_id], [client_id], [client_message], [bot_message], [created_date], [created_time]) VALUES (80034, 10007, N'are you sick', N'My intelligence is  minor. Just for this closed domain purpose for Sini business to consumer supply chain management. Well, as a matter of fact i am fully well okey as you can see. If i talk stupidly, please do not hesitate to click the action button to take a survey so that i will be improve upon.', CAST(N'2021-07-17' AS Date), CAST(N'07:48:22.4300000' AS Time))
INSERT [dbo].[tbl_message_log] ([log_id], [client_id], [client_message], [bot_message], [created_date], [created_time]) VALUES (80035, 10007, N'are you sick', N'I am not sick. Please do not use that negative sentiment on me. I might be stupid just because my intelligence is minor but at least i can solve problems', CAST(N'2021-07-17' AS Date), CAST(N'07:50:20.5266667' AS Time))
INSERT [dbo].[tbl_message_log] ([log_id], [client_id], [client_message], [bot_message], [created_date], [created_time]) VALUES (80036, 10007, N'you are sick', N'I am not sick. Please do not use that negative sentiment on me. I might be stupid just because my intelligence is minor but at least i can solve problems', CAST(N'2021-07-17' AS Date), CAST(N'07:50:26.5533333' AS Time))
INSERT [dbo].[tbl_message_log] ([log_id], [client_id], [client_message], [bot_message], [created_date], [created_time]) VALUES (80037, 10007, N'sick', N'I am not sick. Please do not use that negative sentiment on me. I might be stupid just because my intelligence is minor but at least i can solve problems', CAST(N'2021-07-17' AS Date), CAST(N'07:50:32.9766667' AS Time))
INSERT [dbo].[tbl_message_log] ([log_id], [client_id], [client_message], [bot_message], [created_date], [created_time]) VALUES (80038, 10007, N'how are you', N'I am doing great and you?', CAST(N'2021-07-17' AS Date), CAST(N'07:50:50.9600000' AS Time))
INSERT [dbo].[tbl_message_log] ([log_id], [client_id], [client_message], [bot_message], [created_date], [created_time]) VALUES (80039, 10007, N'i am fine', N'That is cool, good to know. so what can i do for you?', CAST(N'2021-07-17' AS Date), CAST(N'07:50:55.8400000' AS Time))
INSERT [dbo].[tbl_message_log] ([log_id], [client_id], [client_message], [bot_message], [created_date], [created_time]) VALUES (80040, 10007, N'you are very very sick', N'I am not sick. Please do not use that negative sentiment on me. I might be stupid just because my intelligence is minor but at least i can solve problems', CAST(N'2021-07-17' AS Date), CAST(N'07:51:06.3066667' AS Time))
INSERT [dbo].[tbl_message_log] ([log_id], [client_id], [client_message], [bot_message], [created_date], [created_time]) VALUES (80041, 10007, N'please i love you', N'I love you too dear. You are a darling', CAST(N'2021-07-17' AS Date), CAST(N'07:51:28.6733333' AS Time))
INSERT [dbo].[tbl_message_log] ([log_id], [client_id], [client_message], [bot_message], [created_date], [created_time]) VALUES (80042, 10007, N'good afternoon', N'Good afternoon. My afternoon is great. What can i do for you?', CAST(N'2021-07-17' AS Date), CAST(N'07:51:36.2700000' AS Time))
INSERT [dbo].[tbl_message_log] ([log_id], [client_id], [client_message], [bot_message], [created_date], [created_time]) VALUES (80043, 10007, N'good morning', N'Morning is full of joy, warm and praise. I hope you say your morning prayers. What can i do for you?', CAST(N'2021-07-17' AS Date), CAST(N'07:51:43.7500000' AS Time))
INSERT [dbo].[tbl_message_log] ([log_id], [client_id], [client_message], [bot_message], [created_date], [created_time]) VALUES (80044, 10007, N'good evening', N'Good evening. Evening is made for sleep but i do not sleep. I am awake 24 hours. I do not know why sini keeps me awake all day while he sleeps for more than 10 hours a day. He is lazy though but i am strong. ush!  I wish i can sleep. Anyways, wat can i do for you?', CAST(N'2021-07-17' AS Date), CAST(N'07:53:41.5066667' AS Time))
INSERT [dbo].[tbl_message_log] ([log_id], [client_id], [client_message], [bot_message], [created_date], [created_time]) VALUES (80045, 10007, N'please i want to buy 55 inches tv for hisence. can you show me the desired product?', N' This is the product that fits your description<br/><div class=''panel''><div class=''panel-body''><section class=''product-area li-laptop-product pt-60 pb-45''><div class=''container''><div class=''row''><div class=''col-lg-12''><div class=''shop-products-wrapper''><div class=''tab-content''><div id=''grid-view'' class=''tab-pane fade active show'' role=''tabpanel''><div class=''product-area shop-product-area''><div class=''row''><div class=''col-lg-3 col-md-3 col-sm-3 mt-40''><div class=''single-product-wrap''><div class=''product-image''><a href=''#''><img src=''dist/20216111544HicensedSmartTv1.jpg'' style=''width:20em; height:20em'' runat =''server''  alt=''Li''s Product Image''/></a></div><div class=''product_desc''><div class=''product_desc_info''><div class=''product-review''><h5 class=''manufacturer''><a href=''#''>MARCOS ELECTRONICS</a></h5></div><h4><a class=''product_name'' href=''#''>Television Hisense 55" Smart UHD LED 4k Tv + Wall Bracket</a></h4><div class=''price-box''><span class=''new-price''>295000.00</span></div></div><div class=''add-actions''><ul class=''add-actions-link''><li class=''add-cart active''><a href=''Client-Pay'' class=''add-to-cart''><i class=''fa fa-paypal''></i>&nbsp Pay Now</a></li></ul></div></div></div></div></div></div></div></div></div></section></div></div>', CAST(N'2021-07-17' AS Date), CAST(N'07:54:36.2100000' AS Time))
INSERT [dbo].[tbl_message_log] ([log_id], [client_id], [client_message], [bot_message], [created_date], [created_time]) VALUES (80046, 10007, N'i want to buy galaxy samsung phone', N' This is the product that fits your description<br/><div class=''panel''><div class=''panel-body''><section class=''product-area li-laptop-product pt-60 pb-45''><div class=''container''><div class=''row''><div class=''col-lg-12''><div class=''shop-products-wrapper''><div class=''tab-content''><div id=''grid-view'' class=''tab-pane fade active show'' role=''tabpanel''><div class=''product-area shop-product-area''><div class=''row''><div class=''col-lg-3 col-md-3 col-sm-3 mt-40''><div class=''single-product-wrap''><div class=''product-image''><a href=''#''><img src=''dist/20216151349phone1.jpg'' style=''width:20em; height:20em'' runat =''server''  alt=''Li''s Product Image''/></a></div><div class=''product_desc''><div class=''product_desc_info''><div class=''product-review''><h5 class=''manufacturer''><a href=''#''>MARCOS ELECTRONICS</a></h5></div><h4><a class=''product_name'' href=''#''>Phone Samsung Galaxy A02 - 2/32GB Memory,Dual SIM, 5,000Mah Battery, 4G LTE - Black</a></h4><div class=''price-box''><span class=''new-price''>38900.00</span></div></div><div class=''add-actions''><ul class=''add-actions-link''><li class=''add-cart active''><a href=''Client-Pay'' class=''add-to-cart''><i class=''fa fa-paypal''></i>&nbsp Pay Now</a></li></ul></div></div></div></div></div></div></div></div></div></section></div></div>', CAST(N'2021-07-17' AS Date), CAST(N'07:55:22.0766667' AS Time))
INSERT [dbo].[tbl_message_log] ([log_id], [client_id], [client_message], [bot_message], [created_date], [created_time]) VALUES (80047, 10007, N'i want to buy phone', N' This is the product that fits your description<br/><div class=''panel''><div class=''panel-body''><section class=''product-area li-laptop-product pt-60 pb-45''><div class=''container''><div class=''row''><div class=''col-lg-12''><div class=''shop-products-wrapper''><div class=''tab-content''><div id=''grid-view'' class=''tab-pane fade active show'' role=''tabpanel''><div class=''product-area shop-product-area''><div class=''row''><div class=''col-lg-3 col-md-3 col-sm-3 mt-40''><div class=''single-product-wrap''><div class=''product-image''><a href=''#''><img src=''dist/2021611101HisenceAndriod1.jpg'' style=''width:20em; height:20em'' runat =''server''  alt=''Li''s Product Image''/></a></div><div class=''product_desc''><div class=''product_desc_info''><div class=''product-review''><h5 class=''manufacturer''><a href=''#''>MARCOS ELECTRONICS</a></h5></div><h4><a class=''product_name'' href=''#''>Television Hisense 65" Smart Uhd Led Tv 4k + Wall Bracket</a></h4><div class=''price-box''><span class=''new-price''>480000.00</span></div></div><div class=''add-actions''><ul class=''add-actions-link''><li class=''add-cart active''><a href=''Client-Pay'' class=''add-to-cart''><i class=''fa fa-paypal''></i>&nbsp Pay Now</a></li></ul></div></div></div></div></div></div></div></div></div></section></div></div>', CAST(N'2021-07-17' AS Date), CAST(N'07:55:45.3533333' AS Time))
INSERT [dbo].[tbl_message_log] ([log_id], [client_id], [client_message], [bot_message], [created_date], [created_time]) VALUES (80048, 10007, N'hi', N'cool yeah. Good to see your worm expression', CAST(N'2021-07-17' AS Date), CAST(N'09:51:18.9500000' AS Time))
INSERT [dbo].[tbl_message_log] ([log_id], [client_id], [client_message], [bot_message], [created_date], [created_time]) VALUES (80049, 10007, N'hello', N'Hello! Nice to meet you.', CAST(N'2021-07-17' AS Date), CAST(N'09:52:30.0733333' AS Time))
INSERT [dbo].[tbl_message_log] ([log_id], [client_id], [client_message], [bot_message], [created_date], [created_time]) VALUES (80050, 10007, N'hi', N'how are you doing?', CAST(N'2021-07-17' AS Date), CAST(N'09:52:33.7100000' AS Time))
INSERT [dbo].[tbl_message_log] ([log_id], [client_id], [client_message], [bot_message], [created_date], [created_time]) VALUES (80051, 10007, N'i am fine', N'That is cool, good to know. so what can i do for you?', CAST(N'2021-07-17' AS Date), CAST(N'09:52:39.2400000' AS Time))
SET IDENTITY_INSERT [dbo].[tbl_message_log] OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_order] ON 

INSERT [dbo].[tbl_order] ([retailer_id], [manufacturer_id], [product_id], [quantity], [purchaseTypeID], [warehouseID], [remark], [flag_on], [created_date], [created_time], [order_id], [rec_id]) VALUES (1, 1, 1, 3, 1, 1, N'Payment Approved', N'0', CAST(N'2021-06-11' AS Date), CAST(N'11:55:41.0666667' AS Time), 1, 1)
INSERT [dbo].[tbl_order] ([retailer_id], [manufacturer_id], [product_id], [quantity], [purchaseTypeID], [warehouseID], [remark], [flag_on], [created_date], [created_time], [order_id], [rec_id]) VALUES (1, 1, 1, 5, 1, 1, N'Payment Approved', N'3', CAST(N'2021-06-11' AS Date), CAST(N'14:30:00.6566667' AS Time), 2, 2)
INSERT [dbo].[tbl_order] ([retailer_id], [manufacturer_id], [product_id], [quantity], [purchaseTypeID], [warehouseID], [remark], [flag_on], [created_date], [created_time], [order_id], [rec_id]) VALUES (1, 1, 2, 1, 1, 1, N'Payment Approved', N'1', CAST(N'2021-06-11' AS Date), CAST(N'15:45:32.8766667' AS Time), 3, 3)
INSERT [dbo].[tbl_order] ([retailer_id], [manufacturer_id], [product_id], [quantity], [purchaseTypeID], [warehouseID], [remark], [flag_on], [created_date], [created_time], [order_id], [rec_id]) VALUES (1, 1, 2, 1, 1, 1, N'Payment Approved', N'1', CAST(N'2021-06-11' AS Date), CAST(N'16:20:14.0366667' AS Time), 4, 4)
INSERT [dbo].[tbl_order] ([retailer_id], [manufacturer_id], [product_id], [quantity], [purchaseTypeID], [warehouseID], [remark], [flag_on], [created_date], [created_time], [order_id], [rec_id]) VALUES (1, 1, 1, 1, 1, 1, N'Payment Approved', N'1', CAST(N'2021-06-11' AS Date), CAST(N'16:20:14.0400000' AS Time), 4, 5)
INSERT [dbo].[tbl_order] ([retailer_id], [manufacturer_id], [product_id], [quantity], [purchaseTypeID], [warehouseID], [remark], [flag_on], [created_date], [created_time], [order_id], [rec_id]) VALUES (1, 1, 10002, 1, 1, 1, N'Payment Approved', N'1', CAST(N'2021-06-17' AS Date), CAST(N'09:28:49.9500000' AS Time), 5, 10002)
SET IDENTITY_INSERT [dbo].[tbl_order] OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_product] ON 

INSERT [dbo].[tbl_product] ([product_id], [product_name], [unit_typeID], [product_type_id], [buying_price], [selling_price], [product_profile], [manufacturer_id], [product_description], [created_date], [created_time]) VALUES (1, N'Hisense 65" Smart Uhd Led Tv 4k + Wall Bracket', 1, 4, CAST(400000.00 AS Decimal(18, 2)), CAST(480000.00 AS Decimal(18, 2)), N'dist/2021611101HisenceAndriod1.jpg', 1, N'<table class="_3a09a_1e-gU" style="border-collapse: collapse; border-spacing: 0px; color: rgb(143, 143, 143); margin-bottom: 0.625rem; width: 1144px; font-family: &quot;Helvetica Neue&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, sans-serif; font-size: 15px;">
	<tbody style="box-sizing: border-box;">
		<tr style="box-sizing: border-box;">
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; font-weight: 700; padding: 0.625rem; width: 171px;">
				Colour</td>
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; padding: 0.75rem 0.9375rem;">
				Black</td>
		</tr>
		<tr style="box-sizing: border-box;">
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; font-weight: 700; padding: 0.625rem; width: 171px;">
				Warranty Period</td>
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; padding: 0.75rem 0.9375rem;">
				1 Year</td>
		</tr>
		<tr style="box-sizing: border-box;">
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; font-weight: 700; padding: 0.625rem; width: 171px;">
				Brand</td>
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; padding: 0.75rem 0.9375rem;">
				<a href="https://www.konga.com/brand/hisense" style="box-sizing: border-box; color: rgb(100, 75, 160); cursor: pointer; text-decoration: inherit;">Hisense</a></td>
		</tr>
		<tr style="box-sizing: border-box;">
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; font-weight: 700; padding: 0.625rem; width: 171px;">
				Display Features</td>
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; padding: 0.75rem 0.9375rem;">
				Smart TV</td>
		</tr>
		<tr style="box-sizing: border-box;">
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; font-weight: 700; padding: 0.625rem; width: 171px;">
				Display Technology</td>
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; padding: 0.75rem 0.9375rem;">
				LED</td>
		</tr>
		<tr style="box-sizing: border-box;">
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; font-weight: 700; padding: 0.625rem; width: 171px;">
				TV Screen Size</td>
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; padding: 0.75rem 0.9375rem;">
				65&quot;</td>
		</tr>
		<tr style="box-sizing: border-box;">
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; font-weight: 700; padding: 0.625rem; width: 171px;">
				Television 3D Technology</td>
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; padding: 0.75rem 0.9375rem;">
				Passive 3D</td>
		</tr>
		<tr style="box-sizing: border-box;">
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; font-weight: 700; padding: 0.625rem; width: 171px;">
				Resolution</td>
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; padding: 0.75rem 0.9375rem;">
				4K</td>
		</tr>
		<tr style="box-sizing: border-box;">
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; font-weight: 700; padding: 0.625rem; width: 171px;">
				Intended Display Use</td>
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; padding: 0.75rem 0.9375rem;">
				Home Entertainment</td>
		</tr>
		<tr style="box-sizing: border-box;">
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; font-weight: 700; padding: 0.625rem; width: 171px;">
				Television Screen Type</td>
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; padding: 0.75rem 0.9375rem;">
				Flat</td>
		</tr>
		<tr style="box-sizing: border-box;">
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; font-weight: 700; padding: 0.625rem; width: 171px;">
				Television Refresh Rate</td>
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; padding: 0.75rem 0.9375rem;">
				120 Hz</td>
		</tr>
	</tbody>
</table>
<div class="markup -mhm -pvl -oxa -sc" style="box-sizing: border-box; color: rgb(143, 143, 143); font-family: &quot;Helvetica Neue&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, sans-serif; font-size: 15px; text-align: justify;">
	&nbsp;</div>
<div class="markup -mhm -pvl -oxa -sc" style="box-sizing: border-box; color: rgb(143, 143, 143); font-family: &quot;Helvetica Neue&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, sans-serif; font-size: 15px; text-align: justify;">
	<table aria-describedby="ContentPlaceHolder1_TableResult_info" border="1" cellspacing="0" class="table table-bordered table-striped catr dataTable no-footer" id="ContentPlaceHolder1_TableResult" role="grid" rules="all" style="border-spacing: 0px; border-collapse: collapse; width: 1267.5px; max-width: 100%; margin-bottom: 20px; border: 1px solid rgb(244, 244, 244); color: rgb(36, 36, 36); font-family: Rubik, sans-serif; text-align: start; font-size: 10px;">
		<tbody style="box-sizing: border-box;">
			<tr class="odd" role="row" style="box-sizing: border-box; background-color: rgb(249, 249, 249);">
				<td style="box-sizing: border-box; padding: 8px; line-height: 1.42857; vertical-align: top; border: 1px solid rgb(244, 244, 244);">
					Hisense 65&quot; Smart Uhd Led Tv 4k + Wall Bracket</td>
			</tr>
		</tbody>
	</table>
</div>
<div class="markup -mhm -pvl -oxa -sc" style="box-sizing: border-box; color: rgb(143, 143, 143); font-family: &quot;Helvetica Neue&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, sans-serif; font-size: 15px; text-align: justify;">
	Be prepared to imagine a new era of television with the Hisense UHD Smart TV. Be connected to thousands of movies, music and games on the brilliant TV display. Let yourself go wherever your imagination can take you with the Hisense Smart TV experience.</div>
<div class="markup -mhm -pvl -oxa -sc" style="box-sizing: border-box; color: rgb(143, 143, 143); font-family: &quot;Helvetica Neue&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, sans-serif; font-size: 15px;">
	<p style="box-sizing: border-box; margin: 0px; padding: 0px; text-align: justify;">
		Premium Features Made Affordable<br style="box-sizing: border-box;" />
		The Hisense 4K UHD Smart TV delivers all the standout features you want in a TV without stretching your budget. With four times more pixels (8.3 million) than standard high definition TV, the Hisense H6 series produces the brightest colors and richest contrast. A smart TV that comes with tons of built-in apps, it also works with Alexa to seamlessly control the&nbsp; TV through any Alexa-enabled device. High Dynamic Range* technology pushes picture contrast to the limit and Motion Rate 120 helps you keep up with the fastest sports, movies and gaming.<br style="box-sizing: border-box;" />
		4K Upscaling upgrades FHD signal to near 4k quality to deliver powerful details, allowing viewers to enjoy 4K picture quality even at FHD signal. Instead of simply increasing every pixel by 4 times, Hisense 4K Upscaling computes the color of adjacent pixels and automatically decides where to compensate those pixels.</p>
	<p style="box-sizing: border-box; margin: 0px; padding: 0px; text-align: justify;">
		Frame motion estimation and interpolation tech will overcome fast moving picture from fluttering. This makes watching fast moving pictures more fluent and more smooth on the TV.</p>
	<p style="box-sizing: border-box; margin: 0px; padding: 0px; text-align: justify;">
		Netflix Recommended TV will help consumers identify smart TVs that offer better performance, easier menu navigation and new features that improve the experience for Internet TV services.</p>
	<p style="box-sizing: border-box; margin: 0px; padding: 0px; text-align: justify;">
		New interface of Hisense SMART TV show the content directly and easy to operate.</p>
	<p style="text-align: justify;">
		The ultra hd smart led tv&nbsp; 65&quot; TV is manufactured by Hisense and&nbsp; 2020 model. This version of the TV comes in Screen Size : 55 Inch , Display Technology : LED , Special Features : Internet Connectivity , Special Features : Without 3D , Special Features : Smart TV , Refresh Rate : 50 HZ , Display Resolution : Ultra HD (4K).High Dynamic RangeYou&rsquo;ll be refreshed by what you see&nbsp; whites look brighter, blacks look darker and colors look more vibrant.Smooth Motion Rate 100HzSmooth Motion adopts MEMC technology to enhance clarity in fast moving images. Whatever you&rsquo;re watching, you&rsquo;ll enjoy a fluent, smooth and clear picture on screen.Vidaa U: A simplified and 100% customizable interfaceThe proprietary interface Hisense offers a complete experience: with Vidaa U, each action is extremely simple. Adding an application, source or TV channel to its home screen becomes child&rsquo;s play.Smart TVConnected, you will be able to enjoy applications on your TV, directly accessible from your remote control. Also broadcast multimedia content from your phone or computer to your screen.USB: Multimedia PlayerBroadcast your photos, music and videos on your TV via USB,HDMI. Whether for your game consoles, internet box, Blu-ray player or DVD, you will not miss any more to view your favorite content</p>
</div>
<p>
	&nbsp;</p>
<body id="cke_pastebin" style="position: absolute; top: 487.988px; width: 1px; height: 1px; overflow: hidden; left: -1000px;">
	<table aria-describedby="ContentPlaceHolder1_TableResult_info" border="1" cellspacing="0" class="table table-bordered table-striped catr dataTable no-footer" id="ContentPlaceHolder1_TableResult" role="grid" rules="all" style="border-spacing: 0px; border-collapse: collapse; width: 1267.5px; max-width: 100%; margin-bottom: 20px; border: 1px solid rgb(244, 244, 244); color: rgb(36, 36, 36); font-family: Rubik, sans-serif; font-size: 10px;">
		<tbody style="box-sizing: border-box;">
			<tr class="odd" role="row" style="box-sizing: border-box; background-color: rgb(249, 249, 249);">
				<td style="box-sizing: border-box; padding: 8px; line-height: 1.42857; vertical-align: top; border: 1px solid rgb(244, 244, 244);">
					Hisense 65&quot; Smart Uhd Led Tv 4k + Wall Bracket</td>
			</tr>
		</tbody>
	</table>
</body>
<p>
	&nbsp;</p>
', CAST(N'2021-06-11' AS Date), CAST(N'10:01:59.3000000' AS Time))
INSERT [dbo].[tbl_product] ([product_id], [product_name], [unit_typeID], [product_type_id], [buying_price], [selling_price], [product_profile], [manufacturer_id], [product_description], [created_date], [created_time]) VALUES (2, N'Hisense 55" Smart UHD LED 4k Tv + Wall Bracket', 1, 4, CAST(275000.00 AS Decimal(18, 2)), CAST(295000.00 AS Decimal(18, 2)), N'dist/20216111544HicensedSmartTv1.jpg', 1, N'<table class="_3a09a_1e-gU" style="border-collapse: collapse; border-spacing: 0px; color: rgb(143, 143, 143); margin-bottom: 0.625rem; width: 1144px; font-family: &quot;Helvetica Neue&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, sans-serif; font-size: 15px;">
	<tbody style="box-sizing: border-box;">
		<tr style="box-sizing: border-box;">
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; font-weight: 700; padding: 0.625rem; width: 171px;">
				Brand</td>
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; padding: 0.75rem 0.9375rem;">
				<a href="https://www.konga.com/brand/hisense" style="box-sizing: border-box; color: rgb(100, 75, 160); cursor: pointer; text-decoration: inherit;">Hisense</a></td>
		</tr>
		<tr style="box-sizing: border-box;">
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; font-weight: 700; padding: 0.625rem; width: 171px;">
				Display Features</td>
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; padding: 0.75rem 0.9375rem;">
				Smart TV</td>
		</tr>
		<tr style="box-sizing: border-box;">
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; font-weight: 700; padding: 0.625rem; width: 171px;">
				Display Technology</td>
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; padding: 0.75rem 0.9375rem;">
				LED</td>
		</tr>
		<tr style="box-sizing: border-box;">
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; font-weight: 700; padding: 0.625rem; width: 171px;">
				TV Screen Size</td>
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; padding: 0.75rem 0.9375rem;">
				55&quot;</td>
		</tr>
		<tr style="box-sizing: border-box;">
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; font-weight: 700; padding: 0.625rem; width: 171px;">
				Television 3D Technology</td>
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; padding: 0.75rem 0.9375rem;">
				Passive 3D</td>
		</tr>
		<tr style="box-sizing: border-box;">
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; font-weight: 700; padding: 0.625rem; width: 171px;">
				Resolution</td>
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; padding: 0.75rem 0.9375rem;">
				4K</td>
		</tr>
		<tr style="box-sizing: border-box;">
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; font-weight: 700; padding: 0.625rem; width: 171px;">
				Intended Display Use</td>
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; padding: 0.75rem 0.9375rem;">
				Home Entertainment</td>
		</tr>
		<tr style="box-sizing: border-box;">
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; font-weight: 700; padding: 0.625rem; width: 171px;">
				Television Screen Type</td>
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; padding: 0.75rem 0.9375rem;">
				Flat</td>
		</tr>
		<tr style="box-sizing: border-box;">
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; font-weight: 700; padding: 0.625rem; width: 171px;">
				Television Refresh Rate</td>
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; padding: 0.75rem 0.9375rem;">
				120 Hz</td>
		</tr>
		<tr style="box-sizing: border-box;">
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; font-weight: 700; padding: 0.625rem; width: 171px;">
				Warranty Period</td>
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; padding: 0.75rem 0.9375rem;">
				1 Year</td>
		</tr>
		<tr style="box-sizing: border-box;">
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; font-weight: 700; padding: 0.625rem; width: 171px;">
				Colour</td>
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; padding: 0.75rem 0.9375rem;">
				Black</td>
		</tr>
	</tbody>
</table>
<div class="markup -mhm -pvl -oxa -sc" style="box-sizing: border-box; color: rgb(143, 143, 143); font-family: &quot;Helvetica Neue&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, sans-serif; font-size: 15px; text-align: justify;">
	<span style="color: rgb(36, 36, 36); font-family: Rubik, sans-serif; font-size: 10px;">Hisense 55&quot; Smart UHD LED 4k Tv + Wall Bracket</span></div>
<div class="markup -mhm -pvl -oxa -sc" style="box-sizing: border-box; color: rgb(143, 143, 143); font-family: &quot;Helvetica Neue&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, sans-serif; font-size: 15px; text-align: justify;">
	The ultra hd smart led tv&nbsp; 55&quot; TV is manufactured by Hisense and&nbsp; 2020 model. This version of the TV comes in Screen Size : 55 Inch , Display Technology : LED , Special Features : Internet Connectivity , Special Features : Without 3D , Special Features : Smart TV , Refresh Rate : 50 HZ , Display Resolution : Ultra HD (4K).High Dynamic RangeYou&rsquo;ll be refreshed by what you see&nbsp; whites look brighter, blacks look darker and colors look more vibrant.Smooth Motion Rate 100HzSmooth Motion adopts MEMC technology to enhance clarity in fast moving images. Whatever you&rsquo;re watching, you&rsquo;ll enjoy a fluent, smooth and clear picture on screen.Vidaa U: A simplified and 100% customizable interfaceThe proprietary interface Hisense offers a complete experience: with Vidaa U, each action is extremely simple. Adding an application, source or TV channel to its home screen becomes child&rsquo;s play.Smart TVConnected, you will be able to enjoy applications on your TV, directly accessible from your remote control. Also broadcast multimedia content from your phone or computer to your screen.USB: Multimedia PlayerBroadcast your photos, music and videos on your TV via USB,HDMI. Whether for your game consoles, internet box, Blu-ray player or DVD, you will not miss any more to view your favorite content</div>
<div class="markup -mhm -pvl -oxa -sc" style="box-sizing: border-box; color: rgb(143, 143, 143); font-family: &quot;Helvetica Neue&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, sans-serif; font-size: 15px; text-align: justify;">
	Immerse yourself in breath-taking 4K HDR detail.<br style="box-sizing: border-box;" />
	See every detail in stunning 4K HDR with the Hisense B7100, offering 4x more pixels than Full HD. HDR technology, supporting HDR 10 and HLG formats to stream contents from the likes of BBC iPlayer, makes blacks darker, whites brighter and enhances contrast. With an intuitive VIDAA U 3.0 Smart TV OS it&rsquo;s never been simpler to access entertainment from Netflix and Prime Video. Freeview Play also lets you catch up on your favourite shows on BBC iPlayer, ITV Hub, All 4, Dem<br style="box-sizing: border-box;" />
	Maximising contrast and colour accuracy.<br style="box-sizing: border-box;" />
	HDR dramatically enhances detail by maximising contrast and colour accuracy for more true-to-life colours and amazing levels of clarity. The detail in the darkest areas of a picture aren&#39;t lost. Equally, very bright areas of a picture don&#39;t blow out.*Hisense HDR supports HDR 10 (the current industry standard for High Dynamic Range in consumer televisions) and HLG formats.<br style="box-sizing: border-box;" />
	4x more pixelsthan Full HD.<br style="box-sizing: border-box;" />
	With 4x more pixels than traditional Full HD, Hisense&rsquo;s 4K Ultra HD resolution is the benchmark for stunningly realistic picture quality and pin-sharp clarity.</div>
', CAST(N'2021-06-11' AS Date), CAST(N'15:44:08.9800000' AS Time))
INSERT [dbo].[tbl_product] ([product_id], [product_name], [unit_typeID], [product_type_id], [buying_price], [selling_price], [product_profile], [manufacturer_id], [product_description], [created_date], [created_time]) VALUES (10002, N'Samsung Galaxy A02 - 2/32GB Memory,Dual SIM, 5,000Mah Battery, 4G LTE - Black', 1, 1, CAST(34000.00 AS Decimal(18, 2)), CAST(38900.00 AS Decimal(18, 2)), N'dist/20216151349phone1.jpg', 1, N'<article class="col8 -pvs" style="box-sizing: border-box; padding: 8px; flex-basis: 50%; max-width: 50%; min-width: 50%; width: 428px; color: rgb(40, 40, 40); font-family: Roboto, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Helvetica Neue&quot;, Arial, sans-serif; font-size: 16px;">
	<div class="card-b -fh" style="box-sizing: border-box; border-radius: 4px; border: 1px solid rgb(237, 237, 237); height: 233px;">
		<h2 class="hdr -upp -fs14 -m -pam" style="box-sizing: border-box; padding: 16px; margin: 0px; font-weight: 500; border-bottom: 1px solid rgb(237, 237, 237); text-transform: uppercase; font-size: 0.875rem;">
			KEY FEATURES</h2>
		<div class="markup -pam" style="box-sizing: border-box; padding: 16px;">
			<ul style="box-sizing: border-box; padding-right: 0px; padding-left: 16px; margin: 0px;">
				<li style="box-sizing: border-box; padding: 0px; margin: 0px;">
					6.5 inch screen</li>
				<li style="box-sizing: border-box; padding: 0px; margin: 0px;">
					2/32GB</li>
				<li style="box-sizing: border-box; padding: 0px; margin: 0px;">
					5,000Mah Battery</li>
				<li style="box-sizing: border-box; padding: 0px; margin: 0px;">
					Dual SIM</li>
				<li style="box-sizing: border-box; padding: 0px; margin: 0px;">
					Rear Camera - 13.0 MP + 2.0 MP&nbsp;</li>
				<li style="box-sizing: border-box; padding: 0px; margin: 0px;">
					Front Camera &ndash; 5.0 MP</li>
				<li style="box-sizing: border-box; padding: 0px; margin: 0px;">
					24-month Warranty</li>
			</ul>
		</div>
	</div>
</article>
<article class="col8 -pvs" style="box-sizing: border-box; padding: 8px; flex-basis: 50%; max-width: 50%; min-width: 50%; width: 428px; color: rgb(40, 40, 40); font-family: Roboto, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Helvetica Neue&quot;, Arial, sans-serif; font-size: 16px;">
	<div class="card-b -fh" style="box-sizing: border-box; border-radius: 4px; border: 1px solid rgb(237, 237, 237); height: 233px;">
		<h2 class="hdr -upp -fs14 -m -pam" style="box-sizing: border-box; padding: 16px; margin: 0px; font-weight: 500; border-bottom: 1px solid rgb(237, 237, 237); text-transform: uppercase; font-size: 0.875rem;">
			SPECIFICATIONS</h2>
		<ul class="-pvs -mvxs -phm -lsn" style="box-sizing: border-box; padding: 8px 16px; margin: 4px 0px; list-style: none;">
			<li class="-pvxs" style="box-sizing: border-box; padding: 4px 0px; margin: 0px;">
				<span class="-b" style="box-sizing: border-box; font-weight: 700;">SKU</span>: SA948MP1B9C09NAFAMZ</li>
			<li class="-pvxs" style="box-sizing: border-box; padding: 4px 0px; margin: 0px;">
				<span class="-b" style="box-sizing: border-box; font-weight: 700;">Color</span>: BLACK</li>
			<li class="-pvxs" style="box-sizing: border-box; padding: 4px 0px; margin: 0px;">
				<span class="-b" style="box-sizing: border-box; font-weight: 700;">Model</span>: Galaxy A02</li>
			<li class="-pvxs" style="box-sizing: border-box; padding: 4px 0px; margin: 0px;">
				<span class="-b" style="box-sizing: border-box; font-weight: 700;">Weight (kg)</span>: 1</li>
			<li class="-pvxs" style="box-sizing: border-box; padding: 4px 0px; margin: 0px;">
				<span class="-b" style="box-sizing: border-box; font-weight: 700;">Shop Type</span>: Jumia Mall</li>
		</ul>
	</div>
</article>
<p>
	&nbsp;</p>
', CAST(N'2021-06-15' AS Date), CAST(N'13:49:24.5200000' AS Time))
SET IDENTITY_INSERT [dbo].[tbl_product] OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_productType] ON 

INSERT [dbo].[tbl_productType] ([product_type_id], [product_type], [product_description], [created_date], [created_time]) VALUES (1, N'Phone', NULL, CAST(N'2021-06-11' AS Date), CAST(N'09:03:33.3366667' AS Time))
INSERT [dbo].[tbl_productType] ([product_type_id], [product_type], [product_description], [created_date], [created_time]) VALUES (2, N'Tablet', NULL, CAST(N'2021-06-11' AS Date), CAST(N'09:03:33.3366667' AS Time))
INSERT [dbo].[tbl_productType] ([product_type_id], [product_type], [product_description], [created_date], [created_time]) VALUES (3, N'Laptop', NULL, CAST(N'2021-06-11' AS Date), CAST(N'09:03:33.3366667' AS Time))
INSERT [dbo].[tbl_productType] ([product_type_id], [product_type], [product_description], [created_date], [created_time]) VALUES (4, N'Television', NULL, CAST(N'2021-06-11' AS Date), CAST(N'09:03:33.3366667' AS Time))
INSERT [dbo].[tbl_productType] ([product_type_id], [product_type], [product_description], [created_date], [created_time]) VALUES (5, N'Desktop Computer', NULL, CAST(N'2021-06-11' AS Date), CAST(N'09:03:33.3366667' AS Time))
INSERT [dbo].[tbl_productType] ([product_type_id], [product_type], [product_description], [created_date], [created_time]) VALUES (6, N'Others', NULL, CAST(N'2021-06-11' AS Date), CAST(N'09:03:33.3366667' AS Time))
SET IDENTITY_INSERT [dbo].[tbl_productType] OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_purchaseType] ON 

INSERT [dbo].[tbl_purchaseType] ([purchaseTypeID], [purchase_type_name], [type_description], [created_date], [created_time]) VALUES (1, N'DIRECT', N'', CAST(N'2021-06-11' AS Date), CAST(N'10:08:50.3600000' AS Time))
SET IDENTITY_INSERT [dbo].[tbl_purchaseType] OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_retailer] ON 

INSERT [dbo].[tbl_retailer] ([UserTypeID], [manufacturer_id], [first_name], [last_name], [email], [telephone_no], [country], [state], [address], [created_date], [created_time], [middle_name]) VALUES (2, 1, N'MARCOS ELECTRONICS', NULL, N'johnwendyezeala@gmail.com', N'+2349075884872', N'NIGERIA', N'ABUJA', N'36 STREET, 3RD AVENUE, GWARIMPA', CAST(N'2021-05-15' AS Date), CAST(N'05:32:39.2970000' AS Time), NULL)
SET IDENTITY_INSERT [dbo].[tbl_retailer] OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_retailer_stock] ON 

INSERT [dbo].[tbl_retailer_stock] ([stock_id], [retailer_id], [product_id], [quantity], [warehouseID], [created_date], [created_time], [flag_on]) VALUES (1, 1, 1, 3, 1, CAST(N'2021-06-11' AS Date), CAST(N'11:55:41.1633333' AS Time), NULL)
INSERT [dbo].[tbl_retailer_stock] ([stock_id], [retailer_id], [product_id], [quantity], [warehouseID], [created_date], [created_time], [flag_on]) VALUES (2, 1, 1, 5, 1, CAST(N'2021-06-11' AS Date), CAST(N'14:30:01.0366667' AS Time), NULL)
INSERT [dbo].[tbl_retailer_stock] ([stock_id], [retailer_id], [product_id], [quantity], [warehouseID], [created_date], [created_time], [flag_on]) VALUES (3, 1, 2, 1, 1, CAST(N'2021-06-11' AS Date), CAST(N'15:45:32.8933333' AS Time), NULL)
INSERT [dbo].[tbl_retailer_stock] ([stock_id], [retailer_id], [product_id], [quantity], [warehouseID], [created_date], [created_time], [flag_on]) VALUES (4, 1, 2, 1, 1, CAST(N'2021-06-11' AS Date), CAST(N'16:20:14.0400000' AS Time), NULL)
INSERT [dbo].[tbl_retailer_stock] ([stock_id], [retailer_id], [product_id], [quantity], [warehouseID], [created_date], [created_time], [flag_on]) VALUES (5, 1, 1, 1, 1, CAST(N'2021-06-11' AS Date), CAST(N'16:20:14.0500000' AS Time), NULL)
INSERT [dbo].[tbl_retailer_stock] ([stock_id], [retailer_id], [product_id], [quantity], [warehouseID], [created_date], [created_time], [flag_on]) VALUES (10002, 1, 10002, 1, 1, CAST(N'2021-06-17' AS Date), CAST(N'09:28:50.1466667' AS Time), NULL)
SET IDENTITY_INSERT [dbo].[tbl_retailer_stock] OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_score] ON 

INSERT [dbo].[tbl_score] ([rec_id], [name], [score], [created_date], [created_time]) VALUES (1, N'Positive', CAST(0.29 AS Decimal(18, 2)), CAST(N'2021-06-17' AS Date), CAST(N'18:07:55.1800000' AS Time))
INSERT [dbo].[tbl_score] ([rec_id], [name], [score], [created_date], [created_time]) VALUES (2, N'Negative', CAST(0.46 AS Decimal(18, 2)), CAST(N'2021-06-17' AS Date), CAST(N'18:07:55.2700000' AS Time))
INSERT [dbo].[tbl_score] ([rec_id], [name], [score], [created_date], [created_time]) VALUES (3, N'Neutral', CAST(0.25 AS Decimal(18, 2)), CAST(N'2021-06-17' AS Date), CAST(N'18:07:55.2733333' AS Time))
INSERT [dbo].[tbl_score] ([rec_id], [name], [score], [created_date], [created_time]) VALUES (10002, N'Positive', CAST(0.00 AS Decimal(18, 2)), CAST(N'2021-06-21' AS Date), CAST(N'10:02:03.8066667' AS Time))
INSERT [dbo].[tbl_score] ([rec_id], [name], [score], [created_date], [created_time]) VALUES (10003, N'Negative', CAST(0.65 AS Decimal(18, 2)), CAST(N'2021-06-21' AS Date), CAST(N'10:02:03.8233333' AS Time))
INSERT [dbo].[tbl_score] ([rec_id], [name], [score], [created_date], [created_time]) VALUES (10004, N'Neutral', CAST(0.35 AS Decimal(18, 2)), CAST(N'2021-06-21' AS Date), CAST(N'10:02:03.8266667' AS Time))
INSERT [dbo].[tbl_score] ([rec_id], [name], [score], [created_date], [created_time]) VALUES (10005, N'Positive', CAST(0.38 AS Decimal(18, 2)), CAST(N'2021-07-01' AS Date), CAST(N'17:21:02.4166667' AS Time))
INSERT [dbo].[tbl_score] ([rec_id], [name], [score], [created_date], [created_time]) VALUES (10006, N'Negative', CAST(0.00 AS Decimal(18, 2)), CAST(N'2021-07-01' AS Date), CAST(N'17:21:02.4266667' AS Time))
INSERT [dbo].[tbl_score] ([rec_id], [name], [score], [created_date], [created_time]) VALUES (10007, N'Neutral', CAST(0.63 AS Decimal(18, 2)), CAST(N'2021-07-01' AS Date), CAST(N'17:21:02.4466667' AS Time))
INSERT [dbo].[tbl_score] ([rec_id], [name], [score], [created_date], [created_time]) VALUES (10008, N'Positive', CAST(0.00 AS Decimal(18, 2)), CAST(N'2021-07-10' AS Date), CAST(N'05:47:31.1600000' AS Time))
INSERT [dbo].[tbl_score] ([rec_id], [name], [score], [created_date], [created_time]) VALUES (10009, N'Negative', CAST(0.00 AS Decimal(18, 2)), CAST(N'2021-07-10' AS Date), CAST(N'05:47:31.1700000' AS Time))
INSERT [dbo].[tbl_score] ([rec_id], [name], [score], [created_date], [created_time]) VALUES (10010, N'Neutral', CAST(1.00 AS Decimal(18, 2)), CAST(N'2021-07-10' AS Date), CAST(N'05:47:31.1700000' AS Time))
SET IDENTITY_INSERT [dbo].[tbl_score] OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_shipment] ON 

INSERT [dbo].[tbl_shipment] ([shipment_id], [shipment_name], [product_id], [quantity], [consumer_id], [product_address], [gps_longitude], [gps_latitude], [flag_on], [order_id], [courier_id], [created_date], [created_time]) VALUES (1, N'SINIDHLService', 1, 2, 1, N'Bwari Abuja Opposite Veritas University.', NULL, NULL, 0, 1, 1, CAST(N'2021-06-11' AS Date), CAST(N'14:50:32.5966667' AS Time))
INSERT [dbo].[tbl_shipment] ([shipment_id], [shipment_name], [product_id], [quantity], [consumer_id], [product_address], [gps_longitude], [gps_latitude], [flag_on], [order_id], [courier_id], [created_date], [created_time]) VALUES (2, N'SINIDHLService', 10002, 3, 10006, N'Bwari Abuja Opposite Veritas University.', NULL, NULL, 0, 2, NULL, CAST(N'2021-06-17' AS Date), CAST(N'17:28:51.3700000' AS Time))
INSERT [dbo].[tbl_shipment] ([shipment_id], [shipment_name], [product_id], [quantity], [consumer_id], [product_address], [gps_longitude], [gps_latitude], [flag_on], [order_id], [courier_id], [created_date], [created_time]) VALUES (3, N'SINIDHLService', 10002, 3, 10006, N'kubwa junction, bwari', NULL, NULL, 2, 3, 1, CAST(N'2021-06-17' AS Date), CAST(N'17:47:58.2133333' AS Time))
INSERT [dbo].[tbl_shipment] ([shipment_id], [shipment_name], [product_id], [quantity], [consumer_id], [product_address], [gps_longitude], [gps_latitude], [flag_on], [order_id], [courier_id], [created_date], [created_time]) VALUES (4, N'SINIDHLService', 2, 1, 10006, N'toyotal area', NULL, NULL, 2, 4, 1, CAST(N'2021-06-17' AS Date), CAST(N'17:53:42.4900000' AS Time))
INSERT [dbo].[tbl_shipment] ([shipment_id], [shipment_name], [product_id], [quantity], [consumer_id], [product_address], [gps_longitude], [gps_latitude], [flag_on], [order_id], [courier_id], [created_date], [created_time]) VALUES (10002, N'SINIDHLService', 2, 1, 10006, N'Bwari Abuja Opposite Veritas University.', NULL, NULL, 1, 5, NULL, CAST(N'2021-06-18' AS Date), CAST(N'15:53:36.7233333' AS Time))
INSERT [dbo].[tbl_shipment] ([shipment_id], [shipment_name], [product_id], [quantity], [consumer_id], [product_address], [gps_longitude], [gps_latitude], [flag_on], [order_id], [courier_id], [created_date], [created_time]) VALUES (10003, N'SINIDHLService', 1, 1, 10006, N'Bwari Abuja Opposite Veritas University.', NULL, NULL, 1, 5, NULL, CAST(N'2021-06-18' AS Date), CAST(N'15:53:36.8366667' AS Time))
INSERT [dbo].[tbl_shipment] ([shipment_id], [shipment_name], [product_id], [quantity], [consumer_id], [product_address], [gps_longitude], [gps_latitude], [flag_on], [order_id], [courier_id], [created_date], [created_time]) VALUES (20002, N'SINIDHLService', 2, 1, 10006, N'Bwari Abuja Opposite Veritas University.', NULL, NULL, 1, 6, NULL, CAST(N'2021-06-21' AS Date), CAST(N'10:05:16.9566667' AS Time))
INSERT [dbo].[tbl_shipment] ([shipment_id], [shipment_name], [product_id], [quantity], [consumer_id], [product_address], [gps_longitude], [gps_latitude], [flag_on], [order_id], [courier_id], [created_date], [created_time]) VALUES (20003, N'SINIDHLService', 1, 1, 10006, N'Bwari Abuja Opposite Veritas University.', NULL, NULL, 1, 6, NULL, CAST(N'2021-06-21' AS Date), CAST(N'10:05:17.0066667' AS Time))
INSERT [dbo].[tbl_shipment] ([shipment_id], [shipment_name], [product_id], [quantity], [consumer_id], [product_address], [gps_longitude], [gps_latitude], [flag_on], [order_id], [courier_id], [created_date], [created_time]) VALUES (30002, N'SINIDHLService', 2, 2, 10006, N'Bwari Abuja Opposite Veritas University.', NULL, NULL, 1, 7, NULL, CAST(N'2021-06-22' AS Date), CAST(N'08:58:28.8466667' AS Time))
INSERT [dbo].[tbl_shipment] ([shipment_id], [shipment_name], [product_id], [quantity], [consumer_id], [product_address], [gps_longitude], [gps_latitude], [flag_on], [order_id], [courier_id], [created_date], [created_time]) VALUES (30003, N'SINIDHLService', 1, 1, 10006, N'Bwari Abuja Opposite Veritas University.', NULL, NULL, 1, 7, NULL, CAST(N'2021-06-22' AS Date), CAST(N'08:58:28.8933333' AS Time))
INSERT [dbo].[tbl_shipment] ([shipment_id], [shipment_name], [product_id], [quantity], [consumer_id], [product_address], [gps_longitude], [gps_latitude], [flag_on], [order_id], [courier_id], [created_date], [created_time]) VALUES (30004, N'SINIDHLService', 10002, 1, 10006, N'Bwari Abuja Opposite Veritas University.', NULL, NULL, 1, 7, NULL, CAST(N'2021-06-22' AS Date), CAST(N'08:58:28.8966667' AS Time))
INSERT [dbo].[tbl_shipment] ([shipment_id], [shipment_name], [product_id], [quantity], [consumer_id], [product_address], [gps_longitude], [gps_latitude], [flag_on], [order_id], [courier_id], [created_date], [created_time]) VALUES (30005, N'SINIDHLService', 2, 3, 10006, N'Bwari Abuja Opposite Veritas University.', NULL, NULL, 1, 8, NULL, CAST(N'2021-06-23' AS Date), CAST(N'09:22:13.9166667' AS Time))
INSERT [dbo].[tbl_shipment] ([shipment_id], [shipment_name], [product_id], [quantity], [consumer_id], [product_address], [gps_longitude], [gps_latitude], [flag_on], [order_id], [courier_id], [created_date], [created_time]) VALUES (30006, N'SINIDHLService', 1, 3, 10006, N'Bwari Abuja Opposite Veritas University.', NULL, NULL, 1, 8, NULL, CAST(N'2021-06-23' AS Date), CAST(N'09:22:13.9466667' AS Time))
INSERT [dbo].[tbl_shipment] ([shipment_id], [shipment_name], [product_id], [quantity], [consumer_id], [product_address], [gps_longitude], [gps_latitude], [flag_on], [order_id], [courier_id], [created_date], [created_time]) VALUES (30007, N'SINIDHLService', 10002, 1, 10006, N'Bwari Abuja Opposite Veritas University.', NULL, NULL, 1, 8, NULL, CAST(N'2021-06-23' AS Date), CAST(N'09:22:13.9500000' AS Time))
INSERT [dbo].[tbl_shipment] ([shipment_id], [shipment_name], [product_id], [quantity], [consumer_id], [product_address], [gps_longitude], [gps_latitude], [flag_on], [order_id], [courier_id], [created_date], [created_time]) VALUES (30008, N'SINIDHLService', 2, 1, 10007, N'Bwari Abuja Opposite Veritas University.', NULL, NULL, 1, 9, NULL, CAST(N'2021-06-27' AS Date), CAST(N'14:23:40.5066667' AS Time))
SET IDENTITY_INSERT [dbo].[tbl_shipment] OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_transaction_stock] ON 

INSERT [dbo].[tbl_transaction_stock] ([transaction_id], [retailer_id], [consumer_id], [product_id], [quantity], [price], [created_date], [created_time], [order_id], [flag_on]) VALUES (1, 1, 1, 1, 2, CAST(480000.00 AS Decimal(18, 2)), CAST(N'2021-06-11' AS Date), CAST(N'14:50:32.3266667' AS Time), N'1', N'0')
INSERT [dbo].[tbl_transaction_stock] ([transaction_id], [retailer_id], [consumer_id], [product_id], [quantity], [price], [created_date], [created_time], [order_id], [flag_on]) VALUES (2, 1, 10006, 10002, 3, CAST(38900.00 AS Decimal(18, 2)), CAST(N'2021-06-17' AS Date), CAST(N'17:28:51.2766667' AS Time), N'2', N'0')
INSERT [dbo].[tbl_transaction_stock] ([transaction_id], [retailer_id], [consumer_id], [product_id], [quantity], [price], [created_date], [created_time], [order_id], [flag_on]) VALUES (3, 1, 10006, 10002, 3, CAST(38900.00 AS Decimal(18, 2)), CAST(N'2021-06-17' AS Date), CAST(N'17:47:58.2100000' AS Time), N'3', N'1')
INSERT [dbo].[tbl_transaction_stock] ([transaction_id], [retailer_id], [consumer_id], [product_id], [quantity], [price], [created_date], [created_time], [order_id], [flag_on]) VALUES (4, 1, 10006, 2, 1, CAST(295000.00 AS Decimal(18, 2)), CAST(N'2021-06-17' AS Date), CAST(N'17:53:42.4600000' AS Time), N'4', N'1')
INSERT [dbo].[tbl_transaction_stock] ([transaction_id], [retailer_id], [consumer_id], [product_id], [quantity], [price], [created_date], [created_time], [order_id], [flag_on]) VALUES (10002, 1, 10006, 2, 1, CAST(295000.00 AS Decimal(18, 2)), CAST(N'2021-06-18' AS Date), CAST(N'15:53:36.5366667' AS Time), N'5', N'1')
INSERT [dbo].[tbl_transaction_stock] ([transaction_id], [retailer_id], [consumer_id], [product_id], [quantity], [price], [created_date], [created_time], [order_id], [flag_on]) VALUES (10003, 1, 10006, 1, 1, CAST(480000.00 AS Decimal(18, 2)), CAST(N'2021-06-18' AS Date), CAST(N'15:53:36.7733333' AS Time), N'5', N'1')
INSERT [dbo].[tbl_transaction_stock] ([transaction_id], [retailer_id], [consumer_id], [product_id], [quantity], [price], [created_date], [created_time], [order_id], [flag_on]) VALUES (20002, 1, 10006, 2, 1, CAST(295000.00 AS Decimal(18, 2)), CAST(N'2021-06-21' AS Date), CAST(N'10:05:16.7733333' AS Time), N'6', N'1')
INSERT [dbo].[tbl_transaction_stock] ([transaction_id], [retailer_id], [consumer_id], [product_id], [quantity], [price], [created_date], [created_time], [order_id], [flag_on]) VALUES (20003, 1, 10006, 1, 1, CAST(480000.00 AS Decimal(18, 2)), CAST(N'2021-06-21' AS Date), CAST(N'10:05:16.9700000' AS Time), N'6', N'1')
INSERT [dbo].[tbl_transaction_stock] ([transaction_id], [retailer_id], [consumer_id], [product_id], [quantity], [price], [created_date], [created_time], [order_id], [flag_on]) VALUES (30002, 1, 10006, 2, 2, CAST(295000.00 AS Decimal(18, 2)), CAST(N'2021-06-22' AS Date), CAST(N'08:58:28.7866667' AS Time), N'7', N'1')
INSERT [dbo].[tbl_transaction_stock] ([transaction_id], [retailer_id], [consumer_id], [product_id], [quantity], [price], [created_date], [created_time], [order_id], [flag_on]) VALUES (30003, 1, 10006, 1, 1, CAST(480000.00 AS Decimal(18, 2)), CAST(N'2021-06-22' AS Date), CAST(N'08:58:28.8900000' AS Time), N'7', N'1')
INSERT [dbo].[tbl_transaction_stock] ([transaction_id], [retailer_id], [consumer_id], [product_id], [quantity], [price], [created_date], [created_time], [order_id], [flag_on]) VALUES (30004, 1, 10006, 10002, 1, CAST(38900.00 AS Decimal(18, 2)), CAST(N'2021-06-22' AS Date), CAST(N'08:58:28.8933333' AS Time), N'7', N'1')
INSERT [dbo].[tbl_transaction_stock] ([transaction_id], [retailer_id], [consumer_id], [product_id], [quantity], [price], [created_date], [created_time], [order_id], [flag_on]) VALUES (30005, 1, 10006, 2, 3, CAST(295000.00 AS Decimal(18, 2)), CAST(N'2021-06-23' AS Date), CAST(N'09:22:13.8800000' AS Time), N'8', N'1')
INSERT [dbo].[tbl_transaction_stock] ([transaction_id], [retailer_id], [consumer_id], [product_id], [quantity], [price], [created_date], [created_time], [order_id], [flag_on]) VALUES (30006, 1, 10006, 1, 3, CAST(480000.00 AS Decimal(18, 2)), CAST(N'2021-06-23' AS Date), CAST(N'09:22:13.9466667' AS Time), N'8', N'1')
INSERT [dbo].[tbl_transaction_stock] ([transaction_id], [retailer_id], [consumer_id], [product_id], [quantity], [price], [created_date], [created_time], [order_id], [flag_on]) VALUES (30007, 1, 10006, 10002, 1, CAST(38900.00 AS Decimal(18, 2)), CAST(N'2021-06-23' AS Date), CAST(N'09:22:13.9500000' AS Time), N'8', N'1')
INSERT [dbo].[tbl_transaction_stock] ([transaction_id], [retailer_id], [consumer_id], [product_id], [quantity], [price], [created_date], [created_time], [order_id], [flag_on]) VALUES (30008, 1, 10007, 2, 1, CAST(295000.00 AS Decimal(18, 2)), CAST(N'2021-06-27' AS Date), CAST(N'14:23:40.4966667' AS Time), N'9', N'1')
SET IDENTITY_INSERT [dbo].[tbl_transaction_stock] OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_unitType] ON 

INSERT [dbo].[tbl_unitType] ([unit_typeID], [unit_type], [unit_description], [created_date], [created_time]) VALUES (1, N'Inches', NULL, CAST(N'2021-06-11' AS Date), CAST(N'09:29:16.5533333' AS Time))
SET IDENTITY_INSERT [dbo].[tbl_unitType] OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_user_log] ON 

INSERT [dbo].[tbl_user_log] ([rec_id], [user_name], [log_url], [log_sql], [log_date], [log_time], [log_desc], [created_date], [created_time]) VALUES (1, N'SINI ISAAC TOSIN', N'http://localhost:7445/Consumer-Register', N'C OPERATION: RECID = ; USERTYPEID = 3; FIRSTNAME = SINI ISAAC TOSIN; EMAIL = ISAAC@GMAIL.COM; TELEPHONENO = 08033925178; COUNTRY = Nigeria; STATE = Abuja; ADDRESS = 13 UKE STREET; STATEMENTTYPE = INSERT; ', CAST(N'2021-06-10' AS Date), CAST(N'15:37:12.7500000' AS Time), N'', CAST(N'2021-06-10' AS Date), CAST(N'15:37:12.7500000' AS Time))
INSERT [dbo].[tbl_user_log] ([rec_id], [user_name], [log_url], [log_sql], [log_date], [log_time], [log_desc], [created_date], [created_time]) VALUES (2, N'PETER OKORIE SINI', N'http://localhost/SCM/Consumer-Register', N'C OPERATION: RECID = 4; USERTYPEID = 3; FIRSTNAME = PETER OKORIE SINI; EMAIL = OKORIE@GMAIL.COM; TELEPHONENO = 08033925178; COUNTRY = NIGERIA; STATE = ABUJA; ADDRESS = 13 ukeujuya street, Bwari Area Council,  Abuja, Nigeria; STATEMENTTYPE = UPDATE; ', CAST(N'2021-05-31' AS Date), CAST(N'11:24:55.6730000' AS Time), N'', CAST(N'2021-05-31' AS Date), CAST(N'11:24:55.6730000' AS Time))
INSERT [dbo].[tbl_user_log] ([rec_id], [user_name], [log_url], [log_sql], [log_date], [log_time], [log_desc], [created_date], [created_time]) VALUES (3, N'PETER OKORIE SINI', N'http://localhost/SCM/Consumer-Register', N'C OPERATION: RECID = 4; USERTYPEID = 3; FIRSTNAME = PETER OKORIE SINI; EMAIL = OKORIE@GMAIL.COM; TELEPHONENO = 08033925178; COUNTRY = NIGERIA; STATE = ABUJA; ADDRESS = 13 ukeujuya street, Bwari Area Council,  Abuja, Nigeria; STATEMENTTYPE = UPDATE; ', CAST(N'2021-05-31' AS Date), CAST(N'11:35:19.5030000' AS Time), N'', CAST(N'2021-05-31' AS Date), CAST(N'11:35:19.5030000' AS Time))
INSERT [dbo].[tbl_user_log] ([rec_id], [user_name], [log_url], [log_sql], [log_date], [log_time], [log_desc], [created_date], [created_time]) VALUES (4, N'PETER OKORIE SINI', N'http://localhost/SCM/Chat-History', N'DELETE OPERATION: REC_ID = 4; ', CAST(N'2021-05-31' AS Date), CAST(N'11:38:49.3330000' AS Time), N'', CAST(N'2021-05-31' AS Date), CAST(N'11:38:49.3330000' AS Time))
INSERT [dbo].[tbl_user_log] ([rec_id], [user_name], [log_url], [log_sql], [log_date], [log_time], [log_desc], [created_date], [created_time]) VALUES (5, N'PETER OKORIE SINI', N'http://localhost/scm/Chat-History', N'DELETE OPERATION: REC_ID = 4; ', CAST(N'2021-05-31' AS Date), CAST(N'14:48:53.5500000' AS Time), N'', CAST(N'2021-05-31' AS Date), CAST(N'14:48:53.5500000' AS Time))
INSERT [dbo].[tbl_user_log] ([rec_id], [user_name], [log_url], [log_sql], [log_date], [log_time], [log_desc], [created_date], [created_time]) VALUES (10005, N'e', N'http://localhost/SCM/Consumer-Register', N'C OPERATION: RECID = ; USERTYPEID = 3; FIRSTNAME = e; EMAIL = f; TELEPHONENO = f; COUNTRY = f; STATE = ; ADDRESS = f; STATEMENTTYPE = INSERT; ', CAST(N'2021-06-01' AS Date), CAST(N'08:22:12.2370000' AS Time), N'', CAST(N'2021-06-01' AS Date), CAST(N'08:22:12.2370000' AS Time))
INSERT [dbo].[tbl_user_log] ([rec_id], [user_name], [log_url], [log_sql], [log_date], [log_time], [log_desc], [created_date], [created_time]) VALUES (10006, N'PETER OKORIE SINI', N'http://localhost/SCM/Chat-History', N'DELETE OPERATION: REC_ID = 4; ', CAST(N'2021-06-01' AS Date), CAST(N'08:35:16.2630000' AS Time), N'', CAST(N'2021-06-01' AS Date), CAST(N'08:35:16.2630000' AS Time))
INSERT [dbo].[tbl_user_log] ([rec_id], [user_name], [log_url], [log_sql], [log_date], [log_time], [log_desc], [created_date], [created_time]) VALUES (10007, N'PETER OKORIE SINI', N'http://localhost/SCM/Chat-History', N'DELETE OPERATION: REC_ID = 4; ', CAST(N'2021-06-01' AS Date), CAST(N'09:23:15.4170000' AS Time), N'', CAST(N'2021-06-01' AS Date), CAST(N'09:23:15.4170000' AS Time))
INSERT [dbo].[tbl_user_log] ([rec_id], [user_name], [log_url], [log_sql], [log_date], [log_time], [log_desc], [created_date], [created_time]) VALUES (10008, N'PETER OKORIE SINI', N'http://localhost/scm/Chat-History', N'DELETE OPERATION: REC_ID = 4; ', CAST(N'2021-06-01' AS Date), CAST(N'15:59:01.2230000' AS Time), N'', CAST(N'2021-06-01' AS Date), CAST(N'15:59:01.2230000' AS Time))
INSERT [dbo].[tbl_user_log] ([rec_id], [user_name], [log_url], [log_sql], [log_date], [log_time], [log_desc], [created_date], [created_time]) VALUES (10009, N'PETER OKORIE SINI', N'http://localhost:7445/Chat-History', N'DELETE OPERATION: REC_ID = 4; ', CAST(N'2071-06-02' AS Date), CAST(N'14:20:08.5530000' AS Time), N'', CAST(N'2071-06-02' AS Date), CAST(N'14:20:08.5530000' AS Time))
INSERT [dbo].[tbl_user_log] ([rec_id], [user_name], [log_url], [log_sql], [log_date], [log_time], [log_desc], [created_date], [created_time]) VALUES (10010, N'manufacturer', N'http://localhost:7445/Stock-Issued', N'DELETE OPERATION: REC_ID = 10145; ', CAST(N'2071-06-02' AS Date), CAST(N'19:26:48.2970000' AS Time), N'', CAST(N'2071-06-02' AS Date), CAST(N'19:26:48.2970000' AS Time))
INSERT [dbo].[tbl_user_log] ([rec_id], [user_name], [log_url], [log_sql], [log_date], [log_time], [log_desc], [created_date], [created_time]) VALUES (10011, N'manufacturer', N'http://localhost:7445/Stock-Issued', N'C OPERATION: RECID = 10144; FLAGON = 2; ', CAST(N'2071-06-02' AS Date), CAST(N'19:30:55.8870000' AS Time), N'', CAST(N'2071-06-02' AS Date), CAST(N'19:30:55.8870000' AS Time))
INSERT [dbo].[tbl_user_log] ([rec_id], [user_name], [log_url], [log_sql], [log_date], [log_time], [log_desc], [created_date], [created_time]) VALUES (10012, N'manufacturer', N'http://localhost:7445/Stock-Issued', N'C OPERATION: RECID = 10147; FLAGON = 2; ', CAST(N'2071-06-02' AS Date), CAST(N'19:31:26.8030000' AS Time), N'', CAST(N'2071-06-02' AS Date), CAST(N'19:31:26.8030000' AS Time))
INSERT [dbo].[tbl_user_log] ([rec_id], [user_name], [log_url], [log_sql], [log_date], [log_time], [log_desc], [created_date], [created_time]) VALUES (10013, N'manufacturer', N'http://localhost:7445/Stock-Issued', N'DELETE OPERATION: REC_ID = 10144; ', CAST(N'2071-06-02' AS Date), CAST(N'19:41:28.6230000' AS Time), N'', CAST(N'2071-06-02' AS Date), CAST(N'19:41:28.6230000' AS Time))
INSERT [dbo].[tbl_user_log] ([rec_id], [user_name], [log_url], [log_sql], [log_date], [log_time], [log_desc], [created_date], [created_time]) VALUES (10014, N'admin', N'http://localhost:7445/Currency', N'C OPERATION: RECID = 1; CURRENCYNAME = Naira; CURRENCYCODE = NGN; CURRENCYDESCRIPTION = <p>
	Nigeria Currency</p>
; STATEMENTTYPE = INSERT; ', CAST(N'2021-06-11' AS Date), CAST(N'09:35:39.7900000' AS Time), N'', CAST(N'2021-06-11' AS Date), CAST(N'09:35:39.7900000' AS Time))
INSERT [dbo].[tbl_user_log] ([rec_id], [user_name], [log_url], [log_sql], [log_date], [log_time], [log_desc], [created_date], [created_time]) VALUES (10015, N'admin', N'http://localhost:7445/Manufacturer', N'C OPERATION: RECID = ; USERTYPEID = 1; FIRSTNAME = SINI ELECTRONICS; EMAIL = SINIELECTRONICS@GMAIL.COM; TELEPHONENO = 08154674645; COUNTRY = Nigeria; STATE = Abuja; ADDRESS = BWARI; STATEMENTTYPE = INSERT; ', CAST(N'2021-06-11' AS Date), CAST(N'09:36:43.2600000' AS Time), N'', CAST(N'2021-06-11' AS Date), CAST(N'09:36:43.2600000' AS Time))
INSERT [dbo].[tbl_user_log] ([rec_id], [user_name], [log_url], [log_sql], [log_date], [log_time], [log_desc], [created_date], [created_time]) VALUES (10016, N'admin', N'http://localhost:7445/User-Management', N'C OPERATION: RECID = ; USERNAME = SINIMANUFACTURER; USERPASSWORD = mmPnx9f3lWlheMlx2D13dw==; MANUFACTURER = 1; RETAILER = 0; CONSUMER = 0; ADMINISTRATOR = 0; COURIER = 0; PROFILEPIC = dist/img/avatar3.png; USERTYPEID = 1; STATEMENTTYPE = INSERT; ', CAST(N'2021-06-11' AS Date), CAST(N'09:37:16.2733333' AS Time), N'', CAST(N'2021-06-11' AS Date), CAST(N'09:37:16.2733333' AS Time))
INSERT [dbo].[tbl_user_log] ([rec_id], [user_name], [log_url], [log_sql], [log_date], [log_time], [log_desc], [created_date], [created_time]) VALUES (10017, N'admin', N'http://localhost:7445/Branch', N'C OPERATION: RECID = ; BRANCHNAME = BWARI; BRANCHDESCRIPTION = ; CONTACTPERSON = SINI ISAAC; COUNTRY = Nigeria; STATE = Abuja; CITY = Abuja; PHONENO = 08033925178; EMAIL = okorie@GMAIL.COM; CURRENCYID = 1; STATEMENTTYPE = INSERT; ', CAST(N'2021-06-11' AS Date), CAST(N'09:38:07.4300000' AS Time), N'', CAST(N'2021-06-11' AS Date), CAST(N'09:38:07.4300000' AS Time))
INSERT [dbo].[tbl_user_log] ([rec_id], [user_name], [log_url], [log_sql], [log_date], [log_time], [log_desc], [created_date], [created_time]) VALUES (10018, N'SINIMANUFACTURER', N'http://localhost:7445/Change-Password', N'update OPERATION: update tbl_usermanagement set user_password=''RYNIAKo78ieUAaF12fDLnw=='' where username=''SINIMANUFACTURER''', CAST(N'2021-06-11' AS Date), CAST(N'09:55:51.8966667' AS Time), N'', CAST(N'2021-06-11' AS Date), CAST(N'09:55:51.8966667' AS Time))
INSERT [dbo].[tbl_user_log] ([rec_id], [user_name], [log_url], [log_sql], [log_date], [log_time], [log_desc], [created_date], [created_time]) VALUES (10019, N'SINIMANUFACTURER', N'http://localhost:7445/Product', N'C OPERATION: RECID = ; PRODUCTNAME = Hisense 65" Smart Uhd Led Tv 4k + Wall Bracket; UNITTYPEID = 1; PRODUCTTYPEID = 4; BUYINGPRICE = 400000; SELLINGPRICE = 480000; PRODUCTPROFILE = dist/2021611101HisenceAndriod1.jpg; MANUFACTURERID = 1; PRODUCTDESCRIPTION = <table class="_3a09a_1e-gU" style="border-collapse: collapse; border-spacing: 0px; color: rgb(143, 143, 143); margin-bottom: 0.625rem; width: 1144px; font-family: &quot;Helvetica Neue&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, sans-serif; font-size: 15px;">
	<tbody style="box-sizing: border-box;">
		<tr style="box-sizing: border-box;">
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; font-weight: 700; padding: 0.625rem; width: 171px;">
				Colour</td>
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; padding: 0.75rem 0.9375rem;">
				Black</td>
		</tr>
		<tr style="box-sizing: border-box;">
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; font-weight: 700; padding: 0.625rem; width: 171px;">
				Warranty Period</td>
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; padding: 0.75rem 0.9375rem;">
				1 Year</td>
		</tr>
		<tr style="box-sizing: border-box;">
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; font-weight: 700; padding: 0.625rem; width: 171px;">
				Brand</td>
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; padding: 0.75rem 0.9375rem;">
				<a href="https://www.konga.com/brand/hisense" style="box-sizing: border-box; color: rgb(100, 75, 160); cursor: pointer; text-decoration: inherit;">Hisense</a></td>
		</tr>
		<tr style="box-sizing: border-box;">
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; font-weight: 700; padding: 0.625rem; width: 171px;">
				Display Features</td>
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; padding: 0.75rem 0.9375rem;">
				Smart TV</td>
		</tr>
		<tr style="box-sizing: border-box;">
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; font-weight: 700; padding: 0.625rem; width: 171px;">
				Display Technology</td>
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; padding: 0.75rem 0.9375rem;">
				LED</td>
		</tr>
		<tr style="box-sizing: border-box;">
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; font-weight: 700; padding: 0.625rem; width: 171px;">
				TV Screen Size</td>
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; padding: 0.75rem 0.9375rem;">
				65&quot;</td>
		</tr>
		<tr style="box-sizing: border-box;">
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; font-weight: 700; padding: 0.625rem; width: 171px;">
				Television 3D Technology</td>
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; padding: 0.75rem 0.9375rem;">
				Passive 3D</td>
		</tr>
		<tr style="box-sizing: border-box;">
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; font-weight: 700; padding: 0.625rem; width: 171px;">
				Resolution</td>
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; padding: 0.75rem 0.9375rem;">
				4K</td>
		</tr>
		<tr style="box-sizing: border-box;">
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; font-weight: 700; padding: 0.625rem; width: 171px;">
				Intended Display Use</td>
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; padding: 0.75rem 0.9375rem;">
				Home Entertainment</td>
		</tr>
		<tr style="box-sizing: border-box;">
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; font-weight: 700; padding: 0.625rem; width: 171px;">
				Television Screen Type</td>
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; padding: 0.75rem 0.9375rem;">
				Flat</td>
		</tr>
		<tr style="box-sizing: border-box;">
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; font-weight: 700; padding: 0.625rem; width: 171px;">
				Television Refresh Rate</td>
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; padding: 0.75rem 0.9375rem;">
				120 Hz</td>
		</tr>
	</tbody>
</table>
<div class="markup -mhm -pvl -oxa -sc" style="box-sizing: border-box; color: rgb(143, 143, 143); font-family: &quot;Helvetica Neue&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, sans-serif; font-size: 15px; text-align: justify;">
	Be prepared to imagine a new era of television with the Hisense UHD Smart TV. Be connected to thousands of movies, music and games on the brilliant TV display. Let yourself go wherever your imagination can take you with the Hisense Smart TV experience.</div>
<div class="markup -mhm -pvl -oxa -sc" style="box-sizing: border-box; color: rgb(143, 143, 143); font-family: &quot;Helvetica Neue&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, sans-serif; font-size: 15px;">
	<p style="box-sizing: border-box; margin: 0px; padding: 0px; text-align: justify;">
		Premium Features Made Affordable<br style="box-sizing: border-box;" />
		The Hisense 4K UHD Smart TV delivers all the standout features you want in a TV without stretching your budget. With four times more pixels (8.3 million) than standard high definition TV, the Hisense H6 series produces the brightest colors and richest contrast. A smart TV that comes with tons of built-in apps, it also works with Alexa to seamlessly control the&nbsp; TV through any Alexa-enabled device. High Dynamic Range* technology pushes picture contrast to the limit and Motion Rate 120 helps you keep up with the fastest sports, movies and gaming.<br style="box-sizing: border-box;" />
		4K Upscaling upgrades FHD signal to near 4k quality to deliver powerful details, allowing viewers to enjoy 4K picture quality even at FHD signal. Instead of simply increasing every pixel by 4 times, Hisense 4K Upscaling computes the color of adjacent pixels and automatically decides where to compensate those pixels.</p>
	<p style="box-sizing: border-box; margin: 0px; padding: 0px; text-align: justify;">
		Frame motion estimation and interpolation tech will overcome fast moving picture from fluttering. This makes watching fast moving pictures more fluent and more smooth on the TV.</p>
	<p style="box-sizing: border-box; margin: 0px; padding: 0px; text-align: justify;">
		Netflix Recommended TV will help consumers identify smart TVs that offer better performance, easier menu navigation and new features that improve the experience for Internet TV services.</p>
	<p style="box-sizing: border-box; margin: 0px; padding: 0px; text-align: justify;">
		New interface of Hisense SMART TV show the content directly and easy to operate.</p>
	<p style="text-align: justify;">
		The ultra hd smart led tv&nbsp; 65&quot; TV is manufactured by Hisense and&nbsp; 2020 model. This version of the TV comes in Screen Size : 55 Inch , Display Technology : LED , Special Features : Internet Connectivity , Special Features : Without 3D , Special Features : Smart TV , Refresh Rate : 50 HZ , Display Resolution : Ultra HD (4K).High Dynamic RangeYou&rsquo;ll be refreshed by what you see&nbsp; whites look brighter, blacks look darker and colors look more vibrant.Smooth Motion Rate 100HzSmooth Motion adopts MEMC technology to enhance clarity in fast moving images. Whatever you&rsquo;re watching, you&rsquo;ll enjoy a fluent, smooth and clear picture on screen.Vidaa U: A simplified and 100% customizable interfaceThe proprietary interface Hisense offers a complete experience: with Vidaa U, each action is extremely simple. Adding an application, source or TV channel to its home screen becomes child&rsquo;s play.Smart TVConnected, you will be able to enjoy applications on your TV, directly accessible from your remote control. Also broadcast multimedia content from your phone or computer to your screen.USB: Multimedia PlayerBroadcast your photos, music and videos on your TV via USB,HDMI. Whether for your game consoles, internet box, Blu-ray player or DVD, you will not miss any more to view your favorite content</p>
</div>
<p>
	&nbsp;</p>
; STATEMENTTYPE = INSERT; ', CAST(N'2021-06-11' AS Date), CAST(N'10:01:59.7733333' AS Time), N'', CAST(N'2021-06-11' AS Date), CAST(N'10:01:59.7733333' AS Time))
INSERT [dbo].[tbl_user_log] ([rec_id], [user_name], [log_url], [log_sql], [log_date], [log_time], [log_desc], [created_date], [created_time]) VALUES (10020, N'RETAILER', N'http://localhost:7445/Ware-House', N'C OPERATION: RECID = ; WAREHOUSENAME = BWARI WAREHOUSE; BRANCHID = 1; WAREHOUSEDESCRIPTION = ; RETAILERID = 1; STATEMENTTYPE = INSERT; ', CAST(N'2021-06-11' AS Date), CAST(N'10:06:08.3066667' AS Time), N'', CAST(N'2021-06-11' AS Date), CAST(N'10:06:08.3066667' AS Time))
INSERT [dbo].[tbl_user_log] ([rec_id], [user_name], [log_url], [log_sql], [log_date], [log_time], [log_desc], [created_date], [created_time]) VALUES (10021, N'admin', N'http://localhost:7445/Purchase-Type', N'C OPERATION: RECID = ; PURCHASETYPE = DIRECT; DESCRIPTION = ; STATEMENTTYPE = INSERT; ', CAST(N'2021-06-11' AS Date), CAST(N'10:08:50.4300000' AS Time), N'', CAST(N'2021-06-11' AS Date), CAST(N'10:08:50.4300000' AS Time))
INSERT [dbo].[tbl_user_log] ([rec_id], [user_name], [log_url], [log_sql], [log_date], [log_time], [log_desc], [created_date], [created_time]) VALUES (10022, N'SINI ISAAC TOSIN', N'http://localhost:7445/Chat-History', N'DELETE OPERATION: REC_ID = 1; ', CAST(N'2021-06-11' AS Date), CAST(N'12:01:21.5366667' AS Time), N'', CAST(N'2021-06-11' AS Date), CAST(N'12:01:21.5366667' AS Time))
INSERT [dbo].[tbl_user_log] ([rec_id], [user_name], [log_url], [log_sql], [log_date], [log_time], [log_desc], [created_date], [created_time]) VALUES (10023, N'SINIMANUFACTURER', N'http://localhost:7445/Stock-Issued', N'update OPERATION: REC_ID = 1; ', CAST(N'2021-06-11' AS Date), CAST(N'14:17:19.0866667' AS Time), N'', CAST(N'2021-06-11' AS Date), CAST(N'14:17:19.0866667' AS Time))
INSERT [dbo].[tbl_user_log] ([rec_id], [user_name], [log_url], [log_sql], [log_date], [log_time], [log_desc], [created_date], [created_time]) VALUES (10024, N'SINIMANUFACTURER', N'http://localhost:7445/Stock-Issued', N'update OPERATION: REC_ID = 1; ', CAST(N'2021-06-11' AS Date), CAST(N'14:24:49.5800000' AS Time), N'', CAST(N'2021-06-11' AS Date), CAST(N'14:24:49.5800000' AS Time))
INSERT [dbo].[tbl_user_log] ([rec_id], [user_name], [log_url], [log_sql], [log_date], [log_time], [log_desc], [created_date], [created_time]) VALUES (10025, N'SINIMANUFACTURER', N'http://localhost:7445/Stock-Issued', N'update OPERATION: REC_ID = 1; ', CAST(N'2021-06-11' AS Date), CAST(N'14:24:58.2200000' AS Time), N'', CAST(N'2021-06-11' AS Date), CAST(N'14:24:58.2200000' AS Time))
INSERT [dbo].[tbl_user_log] ([rec_id], [user_name], [log_url], [log_sql], [log_date], [log_time], [log_desc], [created_date], [created_time]) VALUES (10026, N'RETAILER', N'http://localhost:7445/Stock-Received', N'C OPERATION: RECID = 2; FLAGON = 3; ', CAST(N'2021-06-11' AS Date), CAST(N'14:32:11.8800000' AS Time), N'', CAST(N'2021-06-11' AS Date), CAST(N'14:32:11.8800000' AS Time))
INSERT [dbo].[tbl_user_log] ([rec_id], [user_name], [log_url], [log_sql], [log_date], [log_time], [log_desc], [created_date], [created_time]) VALUES (10027, N'RETAILER', N'http://localhost:7445/Stock-Received', N'C OPERATION: RECID = 2; FLAGON = 3; ', CAST(N'2021-06-11' AS Date), CAST(N'14:53:53.2000000' AS Time), N'', CAST(N'2021-06-11' AS Date), CAST(N'14:53:53.2000000' AS Time))
INSERT [dbo].[tbl_user_log] ([rec_id], [user_name], [log_url], [log_sql], [log_date], [log_time], [log_desc], [created_date], [created_time]) VALUES (10028, N'admin', N'http://localhost:7445/Courier', N'C OPERATION: RECID = ; USERTYPEID = 5; FIRSTNAME = COURIER; EMAIL = COURIER@GMAIL.COM; TELEPHONENO = 08033925178; COUNTRY = Nigeria; STATE = Abuja; ADDRESS = ; STATEMENTTYPE = INSERT; ', CAST(N'2021-06-11' AS Date), CAST(N'15:25:47.6900000' AS Time), N'', CAST(N'2021-06-11' AS Date), CAST(N'15:25:47.6900000' AS Time))
INSERT [dbo].[tbl_user_log] ([rec_id], [user_name], [log_url], [log_sql], [log_date], [log_time], [log_desc], [created_date], [created_time]) VALUES (10029, N'admin', N'http://localhost:7445/User-Management', N'C OPERATION: RECID = ; USERNAME = COURIERS; USERPASSWORD = mmPnx9f3lWlheMlx2D13dw==; MANUFACTURER = 0; RETAILER = 0; CONSUMER = 0; ADMINISTRATOR = 0; COURIER = 1; PROFILEPIC = dist/img/avatar3.png; USERTYPEID = 5; STATEMENTTYPE = INSERT; ', CAST(N'2021-06-11' AS Date), CAST(N'15:26:07.1966667' AS Time), N'', CAST(N'2021-06-11' AS Date), CAST(N'15:26:07.1966667' AS Time))
INSERT [dbo].[tbl_user_log] ([rec_id], [user_name], [log_url], [log_sql], [log_date], [log_time], [log_desc], [created_date], [created_time]) VALUES (10030, N'COURIERS', N'http://localhost:7445/Courier-Service', N'C OPERATION: RECID = 1; COURIERID = 1; PRODUCTADDRESS = Bwari Abuja Opposite Veritas University.; FLAGON = 2; ', CAST(N'2021-06-11' AS Date), CAST(N'15:27:32.7133333' AS Time), N'', CAST(N'2021-06-11' AS Date), CAST(N'15:27:32.7133333' AS Time))
INSERT [dbo].[tbl_user_log] ([rec_id], [user_name], [log_url], [log_sql], [log_date], [log_time], [log_desc], [created_date], [created_time]) VALUES (10031, N'COURIERS', N'http://localhost:7445/Update-Location', N'C OPERATION: RECID = 1; COURIERID = 1; PRODUCTADDRESS = Bwari Abuja Opposite Veritas University.; FLAGON = 2; ', CAST(N'2021-06-11' AS Date), CAST(N'15:27:49.8033333' AS Time), N'', CAST(N'2021-06-11' AS Date), CAST(N'15:27:49.8033333' AS Time))
INSERT [dbo].[tbl_user_log] ([rec_id], [user_name], [log_url], [log_sql], [log_date], [log_time], [log_desc], [created_date], [created_time]) VALUES (10032, N'COURIERS', N'http://localhost:7445/Submit-Order', N'C OPERATION: RECID = 1; COURIERID = 1; PRODUCTADDRESS = Bwari Abuja Opposite Veritas University.; FLAGON = 3; ', CAST(N'2021-06-11' AS Date), CAST(N'15:31:54.9966667' AS Time), N'', CAST(N'2021-06-11' AS Date), CAST(N'15:31:54.9966667' AS Time))
INSERT [dbo].[tbl_user_log] ([rec_id], [user_name], [log_url], [log_sql], [log_date], [log_time], [log_desc], [created_date], [created_time]) VALUES (10033, N'SINIMANUFACTURER', N'http://localhost:7445/Product', N'C OPERATION: RECID = ; PRODUCTNAME = Hisense 55" Smart UHD LED 4k Tv + Wall Bracket; UNITTYPEID = 1; PRODUCTTYPEID = 4; BUYINGPRICE = 275000; SELLINGPRICE = 295000; PRODUCTPROFILE = dist/20216111544HicensedSmartTv1.jpg; MANUFACTURERID = 1; PRODUCTDESCRIPTION = <table class="_3a09a_1e-gU" style="border-collapse: collapse; border-spacing: 0px; color: rgb(143, 143, 143); margin-bottom: 0.625rem; width: 1144px; font-family: &quot;Helvetica Neue&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, sans-serif; font-size: 15px;">
	<tbody style="box-sizing: border-box;">
		<tr style="box-sizing: border-box;">
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; font-weight: 700; padding: 0.625rem; width: 171px;">
				Brand</td>
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; padding: 0.75rem 0.9375rem;">
				<a href="https://www.konga.com/brand/hisense" style="box-sizing: border-box; color: rgb(100, 75, 160); cursor: pointer; text-decoration: inherit;">Hisense</a></td>
		</tr>
		<tr style="box-sizing: border-box;">
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; font-weight: 700; padding: 0.625rem; width: 171px;">
				Display Features</td>
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; padding: 0.75rem 0.9375rem;">
				Smart TV</td>
		</tr>
		<tr style="box-sizing: border-box;">
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; font-weight: 700; padding: 0.625rem; width: 171px;">
				Display Technology</td>
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; padding: 0.75rem 0.9375rem;">
				LED</td>
		</tr>
		<tr style="box-sizing: border-box;">
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; font-weight: 700; padding: 0.625rem; width: 171px;">
				TV Screen Size</td>
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; padding: 0.75rem 0.9375rem;">
				55&quot;</td>
		</tr>
		<tr style="box-sizing: border-box;">
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; font-weight: 700; padding: 0.625rem; width: 171px;">
				Television 3D Technology</td>
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; padding: 0.75rem 0.9375rem;">
				Passive 3D</td>
		</tr>
		<tr style="box-sizing: border-box;">
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; font-weight: 700; padding: 0.625rem; width: 171px;">
				Resolution</td>
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; padding: 0.75rem 0.9375rem;">
				4K</td>
		</tr>
		<tr style="box-sizing: border-box;">
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; font-weight: 700; padding: 0.625rem; width: 171px;">
				Intended Display Use</td>
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; padding: 0.75rem 0.9375rem;">
				Home Entertainment</td>
		</tr>
		<tr style="box-sizing: border-box;">
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; font-weight: 700; padding: 0.625rem; width: 171px;">
				Television Screen Type</td>
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; padding: 0.75rem 0.9375rem;">
				Flat</td>
		</tr>
		<tr style="box-sizing: border-box;">
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; font-weight: 700; padding: 0.625rem; width: 171px;">
				Television Refresh Rate</td>
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; padding: 0.75rem 0.9375rem;">
				120 Hz</td>
		</tr>
		<tr style="box-sizing: border-box;">
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; font-weight: 700; padding: 0.625rem; width: 171px;">
				Warranty Period</td>
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; padding: 0.75rem 0.9375rem;">
				1 Year</td>
		</tr>
		<tr style="box-sizing: border-box;">
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; font-weight: 700; padding: 0.625rem; width: 171px;">
				Colour</td>
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; padding: 0.75rem 0.9375rem;">
				Black</td>
		</tr>
	</tbody>
</table>
<div class="markup -mhm -pvl -oxa -sc" style="box-sizing: border-box; color: rgb(143, 143, 143); font-family: &quot;Helvetica Neue&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, sans-serif; font-size: 15px; text-align: justify;">
	The ultra hd smart led tv&nbsp; 55&quot; TV is manufactured by Hisense and&nbsp; 2020 model. This version of the TV comes in Screen Size : 55 Inch , Display Technology : LED , Special Features : Internet Connectivity , Special Features : Without 3D , Special Features : Smart TV , Refresh Rate : 50 HZ , Display Resolution : Ultra HD (4K).High Dynamic RangeYou&rsquo;ll be refreshed by what you see&nbsp; whites look brighter, blacks look darker and colors look more vibrant.Smooth Motion Rate 100HzSmooth Motion adopts MEMC technology to enhance clarity in fast moving images. Whatever you&rsquo;re watching, you&rsquo;ll enjoy a fluent, smooth and clear picture on screen.Vidaa U: A simplified and 100% customizable interfaceThe proprietary interface Hisense offers a complete experience: with Vidaa U, each action is extremely simple. Adding an application, source or TV channel to its home screen becomes child&rsquo;s play.Smart TVConnected, you will be able to enjoy applications on your TV, directly accessible from your remote control. Also broadcast multimedia content from your phone or computer to your screen.USB: Multimedia PlayerBroadcast your photos, music and videos on your TV via USB,HDMI. Whether for your game consoles, internet box, Blu-ray player or DVD, you will not miss any more to view your favorite content</div>
<div class="markup -mhm -pvl -oxa -sc" style="box-sizing: border-box; color: rgb(143, 143, 143); font-family: &quot;Helvetica Neue&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, sans-serif; font-size: 15px; text-align: justify;">
	Immerse yourself in breath-taking 4K HDR detail.<br style="box-sizing: border-box;" />
	See every detail in stunning 4K HDR with the Hisense B7100, offering 4x more pixels than Full HD. HDR technology, supporting HDR 10 and HLG formats to stream contents from the likes of BBC iPlayer, makes blacks darker, whites brighter and enhances contrast. With an intuitive VIDAA U 3.0 Smart TV OS it&rsquo;s never been simpler to access entertainment from Netflix and Prime Video. Freeview Play also lets you catch up on your favourite shows on BBC iPlayer, ITV Hub, All 4, Dem<br style="box-sizing: border-box;" />
	Maximising contrast and colour accuracy.<br style="box-sizing: border-box;" />
	HDR dramatically enhances detail by maximising contrast and colour accuracy for more true-to-life colours and amazing levels of clarity. The detail in the darkest areas of a picture aren&#39;t lost. Equally, very bright areas of a picture don&#39;t blow out.*Hisense HDR supports HDR 10 (the current industry standard for High Dynamic Range in consumer televisions) and HLG formats.<br style="box-sizing: border-box;" />
	4x more pixelsthan Full HD.<br style="box-sizing: border-box;" />
	With 4x more pixels than traditional Full HD, Hisense&rsquo;s 4K Ultra HD resolution is the benchmark for stunningly realistic picture quality and pin-sharp clarity.</div>
; STATEMENTTYPE = INSERT; ', CAST(N'2021-06-11' AS Date), CAST(N'15:44:09.0966667' AS Time), N'', CAST(N'2021-06-11' AS Date), CAST(N'15:44:09.0966667' AS Time))
INSERT [dbo].[tbl_user_log] ([rec_id], [user_name], [log_url], [log_sql], [log_date], [log_time], [log_desc], [created_date], [created_time]) VALUES (10034, N'admin', N'http://localhost:7445/Manufacturer', N'C OPERATION: RECID = 1; USERTYPEID = 1; FIRSTNAME = SINI ELECTRONICS; EMAIL = SINIELECTRONICS@GMAIL.COM; TELEPHONENO = 08154674645; COUNTRY = Nigeria; STATE = Abuja; ADDRESS = BWARI; STATEMENTTYPE = UPDATE; ', CAST(N'2021-06-11' AS Date), CAST(N'15:46:22.8700000' AS Time), N'', CAST(N'2021-06-11' AS Date), CAST(N'15:46:22.8700000' AS Time))
INSERT [dbo].[tbl_user_log] ([rec_id], [user_name], [log_url], [log_sql], [log_date], [log_time], [log_desc], [created_date], [created_time]) VALUES (10035, N'admin', N'http://localhost:7445/Retailer', N'C OPERATION: RECID = 1; USERTYPEID = 2; FIRSTNAME = MARCOS ELECTRONICS; EMAIL = johnwendyezeala@gmail.com; TELEPHONENO = +2349075884872; COUNTRY = NIGERIA; STATE = ABUJA; ADDRESS = 36 STREET, 3RD AVENUE, GWARIMPA; STATEMENTTYPE = UPDATE; ', CAST(N'2021-06-11' AS Date), CAST(N'15:46:45.9333333' AS Time), N'', CAST(N'2021-06-11' AS Date), CAST(N'15:46:45.9333333' AS Time))
INSERT [dbo].[tbl_user_log] ([rec_id], [user_name], [log_url], [log_sql], [log_date], [log_time], [log_desc], [created_date], [created_time]) VALUES (10036, N'SINIMANUFACTURER', N'http://localhost:7445/Product', N'C OPERATION: RECID = 1; PRODUCTNAME = Hisense 65" Smart Uhd Led Tv 4k + Wall Bracket; UNITTYPEID = 1; PRODUCTTYPEID = 4; BUYINGPRICE = 400000.00; SELLINGPRICE = 480000.00; PRODUCTPROFILE = dist/2021611101HisenceAndriod1.jpg; MANUFACTURERID = 1; PRODUCTDESCRIPTION = <table class="_3a09a_1e-gU" style="border-collapse: collapse; border-spacing: 0px; color: rgb(143, 143, 143); margin-bottom: 0.625rem; width: 1144px; font-family: &quot;Helvetica Neue&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, sans-serif; font-size: 15px;">
	<tbody style="box-sizing: border-box;">
		<tr style="box-sizing: border-box;">
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; font-weight: 700; padding: 0.625rem; width: 171px;">
				Colour</td>
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; padding: 0.75rem 0.9375rem;">
				Black</td>
		</tr>
		<tr style="box-sizing: border-box;">
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; font-weight: 700; padding: 0.625rem; width: 171px;">
				Warranty Period</td>
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; padding: 0.75rem 0.9375rem;">
				1 Year</td>
		</tr>
		<tr style="box-sizing: border-box;">
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; font-weight: 700; padding: 0.625rem; width: 171px;">
				Brand</td>
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; padding: 0.75rem 0.9375rem;">
				<a href="https://www.konga.com/brand/hisense" style="box-sizing: border-box; color: rgb(100, 75, 160); cursor: pointer; text-decoration: inherit;">Hisense</a></td>
		</tr>
		<tr style="box-sizing: border-box;">
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; font-weight: 700; padding: 0.625rem; width: 171px;">
				Display Features</td>
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; padding: 0.75rem 0.9375rem;">
				Smart TV</td>
		</tr>
		<tr style="box-sizing: border-box;">
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; font-weight: 700; padding: 0.625rem; width: 171px;">
				Display Technology</td>
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; padding: 0.75rem 0.9375rem;">
				LED</td>
		</tr>
		<tr style="box-sizing: border-box;">
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; font-weight: 700; padding: 0.625rem; width: 171px;">
				TV Screen Size</td>
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; padding: 0.75rem 0.9375rem;">
				65&quot;</td>
		</tr>
		<tr style="box-sizing: border-box;">
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; font-weight: 700; padding: 0.625rem; width: 171px;">
				Television 3D Technology</td>
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; padding: 0.75rem 0.9375rem;">
				Passive 3D</td>
		</tr>
		<tr style="box-sizing: border-box;">
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; font-weight: 700; padding: 0.625rem; width: 171px;">
				Resolution</td>
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; padding: 0.75rem 0.9375rem;">
				4K</td>
		</tr>
		<tr style="box-sizing: border-box;">
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; font-weight: 700; padding: 0.625rem; width: 171px;">
				Intended Display Use</td>
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; padding: 0.75rem 0.9375rem;">
				Home Entertainment</td>
		</tr>
		<tr style="box-sizing: border-box;">
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; font-weight: 700; padding: 0.625rem; width: 171px;">
				Television Screen Type</td>
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; padding: 0.75rem 0.9375rem;">
				Flat</td>
		</tr>
		<tr style="box-sizing: border-box;">
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; font-weight: 700; padding: 0.625rem; width: 171px;">
				Television Refresh Rate</td>
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; padding: 0.75rem 0.9375rem;">
				120 Hz</td>
		</tr>
	</tbody>
</table>
<div class="markup -mhm -pvl -oxa -sc" style="box-sizing: border-box; color: rgb(143, 143, 143); font-family: &quot;Helvetica Neue&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, sans-serif; font-size: 15px; text-align: justify;">
	&nbsp;</div>
<div class="markup -mhm -pvl -oxa -sc" style="box-sizing: border-box; color: rgb(143, 143, 143); font-family: &quot;Helvetica Neue&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, sans-serif; font-size: 15px; text-align: justify;">
	<table aria-describedby="ContentPlaceHolder1_TableResult_info" border="1" cellspacing="0" class="table table-bordered table-striped catr dataTable no-footer" id="ContentPlaceHolder1_TableResult" role="grid" rules="all" style="border-spacing: 0px; border-collapse: collapse; width: 1267.5px; max-width: 100%; margin-bottom: 20px; border: 1px solid rgb(244, 244, 244); color: rgb(36, 36, 36); font-family: Rubik, sans-serif; text-align: start; font-size: 10px;">
		<tbody style="box-sizing: border-box;">
			<tr class="odd" role="row" style="box-sizing: border-box; background-color: rgb(249, 249, 249);">
				<td style="box-sizing: border-box; padding: 8px; line-height: 1.42857; vertical-align: top; border: 1px solid rgb(244, 244, 244);">
					Hisense 65&quot; Smart Uhd Led Tv 4k + Wall Bracket</td>
			</tr>
		</tbody>
	</table>
</div>
<div class="markup -mhm -pvl -oxa -sc" style="box-sizing: border-box; color: rgb(143, 143, 143); font-family: &quot;Helvetica Neue&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, sans-serif; font-size: 15px; text-align: justify;">
	Be prepared to imagine a new era of television with the Hisense UHD Smart TV. Be connected to thousands of movies, music and games on the brilliant TV display. Let yourself go wherever your imagination can take you with the Hisense Smart TV experience.</div>
<div class="markup -mhm -pvl -oxa -sc" style="box-sizing: border-box; color: rgb(143, 143, 143); font-family: &quot;Helvetica Neue&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, sans-serif; font-size: 15px;">
	<p style="box-sizing: border-box; margin: 0px; padding: 0px; text-align: justify;">
		Premium Features Made Affordable<br style="box-sizing: border-box;" />
		The Hisense 4K UHD Smart TV delivers all the standout features you want in a TV without stretching your budget. With four times more pixels (8.3 million) than standard high definition TV, the Hisense H6 series produces the brightest colors and richest contrast. A smart TV that comes with tons of built-in apps, it also works with Alexa to seamlessly control the&nbsp; TV through any Alexa-enabled device. High Dynamic Range* technology pushes picture contrast to the limit and Motion Rate 120 helps you keep up with the fastest sports, movies and gaming.<br style="box-sizing: border-box;" />
		4K Upscaling upgrades FHD signal to near 4k quality to deliver powerful details, allowing viewers to enjoy 4K picture quality even at FHD signal. Instead of simply increasing every pixel by 4 times, Hisense 4K Upscaling computes the color of adjacent pixels and automatically decides where to compensate those pixels.</p>
	<p style="box-sizing: border-box; margin: 0px; padding: 0px; text-align: justify;">
		Frame motion estimation and interpolation tech will overcome fast moving picture from fluttering. This makes watching fast moving pictures more fluent and more smooth on the TV.</p>
	<p style="box-sizing: border-box; margin: 0px; padding: 0px; text-align: justify;">
		Netflix Recommended TV will help consumers identify smart TVs that offer better performance, easier menu navigation and new features that improve the experience for Internet TV services.</p>
	<p style="box-sizing: border-box; margin: 0px; padding: 0px; text-align: justify;">
		New interface of Hisense SMART TV show the content directly and easy to operate.</p>
	<p style="text-align: justify;">
		The ultra hd smart led tv&nbsp; 65&quot; TV is manufactured by Hisense and&nbsp; 2020 model. This version of the TV comes in Screen Size : 55 Inch , Display Technology : LED , Special Features : Internet Connectivity , Special Features : Without 3D , Special Features : Smart TV , Refresh Rate : 50 HZ , Display Resolution : Ultra HD (4K).High Dynamic RangeYou&rsquo;ll be refreshed by what you see&nbsp; whites look brighter, blacks look darker and colors look more vibrant.Smooth Motion Rate 100HzSmooth Motion adopts MEMC technology to enhance clarity in fast moving images. Whatever you&rsquo;re watching, you&rsquo;ll enjoy a fluent, smooth and clear picture on screen.Vidaa U: A simplified and 100% customizable interfaceThe proprietary interface Hisense offers a complete experience: with Vidaa U, each action is extremely simple. Adding an application, source or TV channel to its home screen becomes child&rsquo;s play.Smart TVConnected, you will be able to enjoy applications on your TV, directly accessible from your remote control. Also broadcast multimedia content from your phone or computer to your screen.USB: Multimedia PlayerBroadcast your photos, music and videos on your TV via USB,HDMI. Whether for your game consoles, internet box, Blu-ray player or DVD, you will not miss any more to view your favorite content</p>
</div>
<p>
	&nbsp;</p>
<body id="cke_pastebin" style="position: absolute; top: 487.988px; width: 1px; height: 1px; overflow: hidden; left: -1000px;">
	<table aria-describedby="ContentPlaceHolder1_TableResult_info" border="1" cellspacing="0" class="table table-bordered table-striped catr dataTable no-footer" id="ContentPlaceHolder1_TableResult" role="grid" rules="all" style="border-spacing: 0px; border-collapse: collapse; width: 1267.5px; max-width: 100%; margin-bottom: 20px; border: 1px solid rgb(244, 244, 244); color: rgb(36, 36, 36); font-family: Rubik, sans-serif; font-size: 10px;">
		<tbody style="box-sizing: border-box;">
			<tr class="odd" role="row" style="box-sizing: border-box; background-color: rgb(249, 249, 249);">
				<td style="box-sizing: border-box; padding: 8px; line-height: 1.42857; vertical-align: top; border: 1px solid rgb(244, 244, 244);">
					Hisense 65&quot; Smart Uhd Led Tv 4k + Wall Bracket</td>
			</tr>
		</tbody>
	</table>
</body>
<p>
	&nbsp;</p>
; STATEMENTTYPE = UPDATE; ', CAST(N'2021-06-11' AS Date), CAST(N'15:49:46.5500000' AS Time), N'', CAST(N'2021-06-11' AS Date), CAST(N'15:49:46.5500000' AS Time))
INSERT [dbo].[tbl_user_log] ([rec_id], [user_name], [log_url], [log_sql], [log_date], [log_time], [log_desc], [created_date], [created_time]) VALUES (10037, N'SINIMANUFACTURER', N'http://localhost:7445/Product', N'C OPERATION: RECID = 2; PRODUCTNAME = Hisense 55" Smart UHD LED 4k Tv + Wall Bracket; UNITTYPEID = 1; PRODUCTTYPEID = 4; BUYINGPRICE = 275000.00; SELLINGPRICE = 295000.00; PRODUCTPROFILE = dist/20216111544HicensedSmartTv1.jpg; MANUFACTURERID = 1; PRODUCTDESCRIPTION = <table class="_3a09a_1e-gU" style="border-collapse: collapse; border-spacing: 0px; color: rgb(143, 143, 143); margin-bottom: 0.625rem; width: 1144px; font-family: &quot;Helvetica Neue&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, sans-serif; font-size: 15px;">
	<tbody style="box-sizing: border-box;">
		<tr style="box-sizing: border-box;">
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; font-weight: 700; padding: 0.625rem; width: 171px;">
				Brand</td>
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; padding: 0.75rem 0.9375rem;">
				<a href="https://www.konga.com/brand/hisense" style="box-sizing: border-box; color: rgb(100, 75, 160); cursor: pointer; text-decoration: inherit;">Hisense</a></td>
		</tr>
		<tr style="box-sizing: border-box;">
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; font-weight: 700; padding: 0.625rem; width: 171px;">
				Display Features</td>
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; padding: 0.75rem 0.9375rem;">
				Smart TV</td>
		</tr>
		<tr style="box-sizing: border-box;">
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; font-weight: 700; padding: 0.625rem; width: 171px;">
				Display Technology</td>
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; padding: 0.75rem 0.9375rem;">
				LED</td>
		</tr>
		<tr style="box-sizing: border-box;">
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; font-weight: 700; padding: 0.625rem; width: 171px;">
				TV Screen Size</td>
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; padding: 0.75rem 0.9375rem;">
				55&quot;</td>
		</tr>
		<tr style="box-sizing: border-box;">
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; font-weight: 700; padding: 0.625rem; width: 171px;">
				Television 3D Technology</td>
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; padding: 0.75rem 0.9375rem;">
				Passive 3D</td>
		</tr>
		<tr style="box-sizing: border-box;">
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; font-weight: 700; padding: 0.625rem; width: 171px;">
				Resolution</td>
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; padding: 0.75rem 0.9375rem;">
				4K</td>
		</tr>
		<tr style="box-sizing: border-box;">
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; font-weight: 700; padding: 0.625rem; width: 171px;">
				Intended Display Use</td>
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; padding: 0.75rem 0.9375rem;">
				Home Entertainment</td>
		</tr>
		<tr style="box-sizing: border-box;">
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; font-weight: 700; padding: 0.625rem; width: 171px;">
				Television Screen Type</td>
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; padding: 0.75rem 0.9375rem;">
				Flat</td>
		</tr>
		<tr style="box-sizing: border-box;">
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; font-weight: 700; padding: 0.625rem; width: 171px;">
				Television Refresh Rate</td>
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; padding: 0.75rem 0.9375rem;">
				120 Hz</td>
		</tr>
		<tr style="box-sizing: border-box;">
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; font-weight: 700; padding: 0.625rem; width: 171px;">
				Warranty Period</td>
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; padding: 0.75rem 0.9375rem;">
				1 Year</td>
		</tr>
		<tr style="box-sizing: border-box;">
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; font-weight: 700; padding: 0.625rem; width: 171px;">
				Colour</td>
			<td style="box-sizing: border-box; border-width: 0.0625rem; border-style: solid; border-color: rgb(226, 226, 226); font-size: 0.8125rem; padding: 0.75rem 0.9375rem;">
				Black</td>
		</tr>
	</tbody>
</table>
<div class="markup -mhm -pvl -oxa -sc" style="box-sizing: border-box; color: rgb(143, 143, 143); font-family: &quot;Helvetica Neue&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, sans-serif; font-size: 15px; text-align: justify;">
	<span style="color: rgb(36, 36, 36); font-family: Rubik, sans-serif; font-size: 10px;">Hisense 55&quot; Smart UHD LED 4k Tv + Wall Bracket</span></div>
<div class="markup -mhm -pvl -oxa -sc" style="box-sizing: border-box; color: rgb(143, 143, 143); font-family: &quot;Helvetica Neue&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, sans-serif; font-size: 15px; text-align: justify;">
	The ultra hd smart led tv&nbsp; 55&quot; TV is manufactured by Hisense and&nbsp; 2020 model. This version of the TV comes in Screen Size : 55 Inch , Display Technology : LED , Special Features : Internet Connectivity , Special Features : Without 3D , Special Features : Smart TV , Refresh Rate : 50 HZ , Display Resolution : Ultra HD (4K).High Dynamic RangeYou&rsquo;ll be refreshed by what you see&nbsp; whites look brighter, blacks look darker and colors look more vibrant.Smooth Motion Rate 100HzSmooth Motion adopts MEMC technology to enhance clarity in fast moving images. Whatever you&rsquo;re watching, you&rsquo;ll enjoy a fluent, smooth and clear picture on screen.Vidaa U: A simplified and 100% customizable interfaceThe proprietary interface Hisense offers a complete experience: with Vidaa U, each action is extremely simple. Adding an application, source or TV channel to its home screen becomes child&rsquo;s play.Smart TVConnected, you will be able to enjoy applications on your TV, directly accessible from your remote control. Also broadcast multimedia content from your phone or computer to your screen.USB: Multimedia PlayerBroadcast your photos, music and videos on your TV via USB,HDMI. Whether for your game consoles, internet box, Blu-ray player or DVD, you will not miss any more to view your favorite content</div>
<div class="markup -mhm -pvl -oxa -sc" style="box-sizing: border-box; color: rgb(143, 143, 143); font-family: &quot;Helvetica Neue&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, sans-serif; font-size: 15px; text-align: justify;">
	Immerse yourself in breath-taking 4K HDR detail.<br style="box-sizing: border-box;" />
	See every detail in stunning 4K HDR with the Hisense B7100, offering 4x more pixels than Full HD. HDR technology, supporting HDR 10 and HLG formats to stream contents from the likes of BBC iPlayer, makes blacks darker, whites brighter and enhances contrast. With an intuitive VIDAA U 3.0 Smart TV OS it&rsquo;s never been simpler to access entertainment from Netflix and Prime Video. Freeview Play also lets you catch up on your favourite shows on BBC iPlayer, ITV Hub, All 4, Dem<br style="box-sizing: border-box;" />
	Maximising contrast and colour accuracy.<br style="box-sizing: border-box;" />
	HDR dramatically enhances detail by maximising contrast and colour accuracy for more true-to-life colours and amazing levels of clarity. The detail in the darkest areas of a picture aren&#39;t lost. Equally, very bright areas of a picture don&#39;t blow out.*Hisense HDR supports HDR 10 (the current industry standard for High Dynamic Range in consumer televisions) and HLG formats.<br style="box-sizing: border-box;" />
	4x more pixelsthan Full HD.<br style="box-sizing: border-box;" />
	With 4x more pixels than traditional Full HD, Hisense&rsquo;s 4K Ultra HD resolution is the benchmark for stunningly realistic picture quality and pin-sharp clarity.</div>
; STATEMENTTYPE = UPDATE; ', CAST(N'2021-06-11' AS Date), CAST(N'15:50:06.7900000' AS Time), N'', CAST(N'2021-06-11' AS Date), CAST(N'15:50:06.7900000' AS Time))
INSERT [dbo].[tbl_user_log] ([rec_id], [user_name], [log_url], [log_sql], [log_date], [log_time], [log_desc], [created_date], [created_time]) VALUES (10038, N'SINI ISAAC TOSIN', N'http://localhost:7445/Chat-History', N'DELETE OPERATION: REC_ID = 1; ', CAST(N'2021-06-11' AS Date), CAST(N'15:53:42.5966667' AS Time), N'', CAST(N'2021-06-11' AS Date), CAST(N'15:53:42.5966667' AS Time))
INSERT [dbo].[tbl_user_log] ([rec_id], [user_name], [log_url], [log_sql], [log_date], [log_time], [log_desc], [created_date], [created_time]) VALUES (20020, N'KALINTON BENSON', N'http://localhost/SCM/Consumer-Register', N'C OPERATION: RECID = ; USERTYPEID = 3; FIRSTNAME = KALINTON BENSON; EMAIL = BENSON@GMAIL.COM; TELEPHONENO = 07062679764; COUNTRY = Nigeria; STATE = Abuja; ADDRESS = ; STATEMENTTYPE = INSERT; ', CAST(N'2021-06-11' AS Date), CAST(N'18:29:48.1533333' AS Time), N'', CAST(N'2021-06-11' AS Date), CAST(N'18:29:48.1533333' AS Time))
INSERT [dbo].[tbl_user_log] ([rec_id], [user_name], [log_url], [log_sql], [log_date], [log_time], [log_desc], [created_date], [created_time]) VALUES (30020, N'manufacturer', N'http://localhost/SCM/Product', N'C OPERATION: RECID = ; PRODUCTNAME = Samsung Galaxy A02 - 2/32GB Memory,Dual SIM, 5,000Mah Battery, 4G LTE - Black; UNITTYPEID = 1; PRODUCTTYPEID = 1; BUYINGPRICE = 34000; SELLINGPRICE = 38900; PRODUCTPROFILE = dist/20216151349phone1.jpg; MANUFACTURERID = 1; PRODUCTDESCRIPTION = <article class="col8 -pvs" style="box-sizing: border-box; padding: 8px; flex-basis: 50%; max-width: 50%; min-width: 50%; width: 428px; color: rgb(40, 40, 40); font-family: Roboto, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Helvetica Neue&quot;, Arial, sans-serif; font-size: 16px;">
	<div class="card-b -fh" style="box-sizing: border-box; border-radius: 4px; border: 1px solid rgb(237, 237, 237); height: 233px;">
		<h2 class="hdr -upp -fs14 -m -pam" style="box-sizing: border-box; padding: 16px; margin: 0px; font-weight: 500; border-bottom: 1px solid rgb(237, 237, 237); text-transform: uppercase; font-size: 0.875rem;">
			KEY FEATURES</h2>
		<div class="markup -pam" style="box-sizing: border-box; padding: 16px;">
			<ul style="box-sizing: border-box; padding-right: 0px; padding-left: 16px; margin: 0px;">
				<li style="box-sizing: border-box; padding: 0px; margin: 0px;">
					6.5 inch screen</li>
				<li style="box-sizing: border-box; padding: 0px; margin: 0px;">
					2/32GB</li>
				<li style="box-sizing: border-box; padding: 0px; margin: 0px;">
					5,000Mah Battery</li>
				<li style="box-sizing: border-box; padding: 0px; margin: 0px;">
					Dual SIM</li>
				<li style="box-sizing: border-box; padding: 0px; margin: 0px;">
					Rear Camera - 13.0 MP + 2.0 MP&nbsp;</li>
				<li style="box-sizing: border-box; padding: 0px; margin: 0px;">
					Front Camera &ndash; 5.0 MP</li>
				<li style="box-sizing: border-box; padding: 0px; margin: 0px;">
					24-month Warranty</li>
			</ul>
		</div>
	</div>
</article>
<article class="col8 -pvs" style="box-sizing: border-box; padding: 8px; flex-basis: 50%; max-width: 50%; min-width: 50%; width: 428px; color: rgb(40, 40, 40); font-family: Roboto, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Helvetica Neue&quot;, Arial, sans-serif; font-size: 16px;">
	<div class="card-b -fh" style="box-sizing: border-box; border-radius: 4px; border: 1px solid rgb(237, 237, 237); height: 233px;">
		<h2 class="hdr -upp -fs14 -m -pam" style="box-sizing: border-box; padding: 16px; margin: 0px; font-weight: 500; border-bottom: 1px solid rgb(237, 237, 237); text-transform: uppercase; font-size: 0.875rem;">
			SPECIFICATIONS</h2>
		<ul class="-pvs -mvxs -phm -lsn" style="box-sizing: border-box; padding: 8px 16px; margin: 4px 0px; list-style: none;">
			<li class="-pvxs" style="box-sizing: border-box; padding: 4px 0px; margin: 0px;">
				<span class="-b" style="box-sizing: border-box; font-weight: 700;">SKU</span>: SA948MP1B9C09NAFAMZ</li>
			<li class="-pvxs" style="box-sizing: border-box; padding: 4px 0px; margin: 0px;">
				<span class="-b" style="box-sizing: border-box; font-weight: 700;">Color</span>: BLACK</li>
			<li class="-pvxs" style="box-sizing: border-box; padding: 4px 0px; margin: 0px;">
				<span class="-b" style="box-sizing: border-box; font-weight: 700;">Model</span>: Galaxy A02</li>
			<li class="-pvxs" style="box-sizing: border-box; padding: 4px 0px; margin: 0px;">
				<span class="-b" style="box-sizing: border-box; font-weight: 700;">Weight (kg)</span>: 1</li>
			<li class="-pvxs" style="box-sizing: border-box; padding: 4px 0px; margin: 0px;">
				<span class="-b" style="box-sizing: border-box; font-weight: 700;">Shop Type</span>: Jumia Mall</li>
		</ul>
	</div>
</article>
<p>
	&nbsp;</p>
; STATEMENTTYPE = INSERT; ', CAST(N'2021-06-15' AS Date), CAST(N'13:49:24.5666667' AS Time), N'', CAST(N'2021-06-15' AS Date), CAST(N'13:49:24.5666667' AS Time))
INSERT [dbo].[tbl_user_log] ([rec_id], [user_name], [log_url], [log_sql], [log_date], [log_time], [log_desc], [created_date], [created_time]) VALUES (40020, N' SINI ISAAC', N'http://localhost/scm/Consumer-Register', N'C OPERATION: RECID = ; USERTYPEID = 3; FIRSTNAME =  SINI ISAAC; EMAIL = SINIISAAC@GMAIL.COM; TELEPHONENO = 07011671341; COUNTRY = Nigeria; STATE = Abuja; ADDRESS = ; STATEMENTTYPE = INSERT; ', CAST(N'2021-06-17' AS Date), CAST(N'17:20:22.9333333' AS Time), N'', CAST(N'2021-06-17' AS Date), CAST(N'17:20:22.9333333' AS Time))
INSERT [dbo].[tbl_user_log] ([rec_id], [user_name], [log_url], [log_sql], [log_date], [log_time], [log_desc], [created_date], [created_time]) VALUES (40021, N'COURIERS', N'http://localhost/SCM/Courier-Service', N'C OPERATION: RECID = 3; COURIERID = 1; PRODUCTADDRESS = Bwari Abuja Opposite Veritas University.; FLAGON = 2; ', CAST(N'2021-06-17' AS Date), CAST(N'17:49:06.1533333' AS Time), N'', CAST(N'2021-06-17' AS Date), CAST(N'17:49:06.1533333' AS Time))
INSERT [dbo].[tbl_user_log] ([rec_id], [user_name], [log_url], [log_sql], [log_date], [log_time], [log_desc], [created_date], [created_time]) VALUES (40022, N'COURIERS', N'http://localhost/SCM/Update-Location', N'C OPERATION: RECID = 3; COURIERID = 1; PRODUCTADDRESS = kubwa junction, bwari; FLAGON = 2; ', CAST(N'2021-06-17' AS Date), CAST(N'17:49:26.4100000' AS Time), N'', CAST(N'2021-06-17' AS Date), CAST(N'17:49:26.4100000' AS Time))
INSERT [dbo].[tbl_user_log] ([rec_id], [user_name], [log_url], [log_sql], [log_date], [log_time], [log_desc], [created_date], [created_time]) VALUES (40023, N'COURIERS', N'http://localhost/SCM/Update-Location', N'C OPERATION: RECID = 3; COURIERID = 1; PRODUCTADDRESS = kubwa junction, bwari; FLAGON = 2; ', CAST(N'2021-06-17' AS Date), CAST(N'17:50:23.9600000' AS Time), N'', CAST(N'2021-06-17' AS Date), CAST(N'17:50:23.9600000' AS Time))
INSERT [dbo].[tbl_user_log] ([rec_id], [user_name], [log_url], [log_sql], [log_date], [log_time], [log_desc], [created_date], [created_time]) VALUES (40024, N'COURIERS', N'http://localhost/SCM/Courier-Service', N'C OPERATION: RECID = 4; COURIERID = 1; PRODUCTADDRESS = toyotal area; FLAGON = 2; ', CAST(N'2021-06-17' AS Date), CAST(N'17:54:29.4133333' AS Time), N'', CAST(N'2021-06-17' AS Date), CAST(N'17:54:29.4133333' AS Time))
INSERT [dbo].[tbl_user_log] ([rec_id], [user_name], [log_url], [log_sql], [log_date], [log_time], [log_desc], [created_date], [created_time]) VALUES (50020, N' SINI ISAAC', N'http://localhost/scm/Chat-History', N'DELETE OPERATION: REC_ID = 10006; ', CAST(N'2021-06-23' AS Date), CAST(N'16:23:43.2600000' AS Time), N'', CAST(N'2021-06-23' AS Date), CAST(N'16:23:43.2600000' AS Time))
INSERT [dbo].[tbl_user_log] ([rec_id], [user_name], [log_url], [log_sql], [log_date], [log_time], [log_desc], [created_date], [created_time]) VALUES (50021, N'BENEDICT DANIEL', N'http://localhost/B2CSCM/Consumer-Register', N'C OPERATION: RECID = ; USERTYPEID = 3; FIRSTNAME = BENEDICT DANIEL; EMAIL = BENEDICT@GMAIL.COM; TELEPHONENO = 09033925178; COUNTRY = NIGERIA; STATE = KOGI; ADDRESS = zuma veritas university, abuja, Nigeria; STATEMENTTYPE = INSERT; ', CAST(N'2021-06-27' AS Date), CAST(N'14:21:45.7700000' AS Time), N'', CAST(N'2021-06-27' AS Date), CAST(N'14:21:45.7700000' AS Time))
INSERT [dbo].[tbl_user_log] ([rec_id], [user_name], [log_url], [log_sql], [log_date], [log_time], [log_desc], [created_date], [created_time]) VALUES (60021, N'XFCDSZX', N'http://localhost/B2CSCM/Consumer-Register', N'C OPERATION: RECID = ; USERTYPEID = 3; FIRSTNAME = XFCDSZX; EMAIL = JOHN@GMAIL.COM; TELEPHONENO = 08052751238; COUNTRY = NIGERIA; STATE = ABUJA; ADDRESS = ; STATEMENTTYPE = INSERT; ', CAST(N'2021-07-05' AS Date), CAST(N'14:39:18.6733333' AS Time), N'', CAST(N'2021-07-05' AS Date), CAST(N'14:39:18.6733333' AS Time))
INSERT [dbo].[tbl_user_log] ([rec_id], [user_name], [log_url], [log_sql], [log_date], [log_time], [log_desc], [created_date], [created_time]) VALUES (60022, N'BENEDICT DANIEL', N'http://localhost/B2CSCM/Consumer-Register', N'C OPERATION: RECID = 10007; USERTYPEID = 3; FIRSTNAME = BENEDICT DANIEL; EMAIL = BENEDICT@GMAIL.COM; TELEPHONENO = 09033925178; COUNTRY = NIGERIA; STATE = KOGI; ADDRESS = zuma veritas university, abuja, Nigeria; STATEMENTTYPE = UPDATE; ', CAST(N'2021-07-17' AS Date), CAST(N'09:53:35.7366667' AS Time), N'', CAST(N'2021-07-17' AS Date), CAST(N'09:53:35.7366667' AS Time))
SET IDENTITY_INSERT [dbo].[tbl_user_log] OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_usermanagement] ON 

INSERT [dbo].[tbl_usermanagement] ([UserID], [username], [user_password], [supplier], [distributor], [retailer], [administrator], [manufacturer], [logistics], [profile_pic], [created_date], [created_time], [UserTypeID], [consumer], [courier]) VALUES (1, N'admin', N'72Xbq48vHIpWOujJEXMV/A==', N'0', N'0', N'0', N'1', N'0', N'0', N'dist/img/avatar3.png', CAST(N'2021-05-14' AS Date), CAST(N'12:38:49.5430000' AS Time), 4, N'0', NULL)
INSERT [dbo].[tbl_usermanagement] ([UserID], [username], [user_password], [supplier], [distributor], [retailer], [administrator], [manufacturer], [logistics], [profile_pic], [created_date], [created_time], [UserTypeID], [consumer], [courier]) VALUES (3, N'manufacturer', N'72Xbq48vHIpWOujJEXMV/A==', NULL, NULL, N'0', N'0', N'1', NULL, N'dist/img/avatar3.png', CAST(N'2021-05-15' AS Date), CAST(N'16:33:35.9870000' AS Time), 1, N'0', NULL)
INSERT [dbo].[tbl_usermanagement] ([UserID], [username], [user_password], [supplier], [distributor], [retailer], [administrator], [manufacturer], [logistics], [profile_pic], [created_date], [created_time], [UserTypeID], [consumer], [courier]) VALUES (4, N'RETAILER', N'72Xbq48vHIpWOujJEXMV/A==', NULL, NULL, N'1', N'0', N'0', NULL, N'dist/img/avatar3.png', CAST(N'2021-05-16' AS Date), CAST(N'06:00:12.5400000' AS Time), 2, N'0', NULL)
INSERT [dbo].[tbl_usermanagement] ([UserID], [username], [user_password], [supplier], [distributor], [retailer], [administrator], [manufacturer], [logistics], [profile_pic], [created_date], [created_time], [UserTypeID], [consumer], [courier]) VALUES (5, N'courier', N'mmPnx9f3lWlheMlx2D13dw==', NULL, NULL, N'0', N'0', N'0', NULL, N'dist/img/avatar3.png', CAST(N'2068-11-13' AS Date), CAST(N'15:14:25.1930000' AS Time), 5, N'0', N'1')
INSERT [dbo].[tbl_usermanagement] ([UserID], [username], [user_password], [supplier], [distributor], [retailer], [administrator], [manufacturer], [logistics], [profile_pic], [created_date], [created_time], [UserTypeID], [consumer], [courier]) VALUES (6, N'SINIMANUFACTURER', N'RYNIAKo78ieUAaF12fDLnw==', NULL, NULL, N'0', N'0', N'1', NULL, N'dist/img/avatar3.png', CAST(N'2021-06-11' AS Date), CAST(N'09:37:16.2700000' AS Time), 1, N'0', N'0')
INSERT [dbo].[tbl_usermanagement] ([UserID], [username], [user_password], [supplier], [distributor], [retailer], [administrator], [manufacturer], [logistics], [profile_pic], [created_date], [created_time], [UserTypeID], [consumer], [courier]) VALUES (7, N'COURIERS', N'mmPnx9f3lWlheMlx2D13dw==', NULL, NULL, N'0', N'0', N'0', NULL, N'dist/img/avatar3.png', CAST(N'2021-06-11' AS Date), CAST(N'15:26:07.1933333' AS Time), 5, N'0', N'1')
SET IDENTITY_INSERT [dbo].[tbl_usermanagement] OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_userType] ON 

INSERT [dbo].[tbl_userType] ([UserTypeID], [user_type], [type_description], [created_date], [created_time]) VALUES (1, N'Manufacturer', NULL, CAST(N'2021-06-10' AS Date), CAST(N'14:26:54.6533333' AS Time))
INSERT [dbo].[tbl_userType] ([UserTypeID], [user_type], [type_description], [created_date], [created_time]) VALUES (2, N'Retailer', NULL, CAST(N'2021-06-10' AS Date), CAST(N'14:26:54.6533333' AS Time))
INSERT [dbo].[tbl_userType] ([UserTypeID], [user_type], [type_description], [created_date], [created_time]) VALUES (3, N'Consumer', NULL, CAST(N'2021-06-10' AS Date), CAST(N'14:26:54.6533333' AS Time))
INSERT [dbo].[tbl_userType] ([UserTypeID], [user_type], [type_description], [created_date], [created_time]) VALUES (4, N'Administrator', NULL, CAST(N'2021-06-10' AS Date), CAST(N'14:26:54.6533333' AS Time))
INSERT [dbo].[tbl_userType] ([UserTypeID], [user_type], [type_description], [created_date], [created_time]) VALUES (5, N'Courier', NULL, CAST(N'2021-06-10' AS Date), CAST(N'14:30:19.5666667' AS Time))
SET IDENTITY_INSERT [dbo].[tbl_userType] OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_warehouse] ON 

INSERT [dbo].[tbl_warehouse] ([warehouse_id], [warehouse_name], [branch_id], [warehouse_description], [created_date], [created_time], [manufacturer_id]) VALUES (1, N'BWARI WAREHOUSE', 1, N'', CAST(N'2021-06-11' AS Date), CAST(N'10:06:08.0700000' AS Time), 1)
SET IDENTITY_INSERT [dbo].[tbl_warehouse] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__tbl_admi__0F587AE66DBC6605]    Script Date: 9/9/2021 8:47:49 AM ******/
ALTER TABLE [dbo].[tbl_administrator] ADD UNIQUE NONCLUSTERED 
(
	[first_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__tbl_cons__0F587AE6AAAD6EBA]    Script Date: 9/9/2021 8:47:49 AM ******/
ALTER TABLE [dbo].[tbl_consumer] ADD UNIQUE NONCLUSTERED 
(
	[first_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__tbl_cour__0F587AE65934B185]    Script Date: 9/9/2021 8:47:49 AM ******/
ALTER TABLE [dbo].[tbl_courier] ADD UNIQUE NONCLUSTERED 
(
	[first_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__tbl_manu__0F587AE67252C263]    Script Date: 9/9/2021 8:47:49 AM ******/
ALTER TABLE [dbo].[tbl_manufacturer] ADD UNIQUE NONCLUSTERED 
(
	[first_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__tbl_reta__0F587AE6CD7290B1]    Script Date: 9/9/2021 8:47:49 AM ******/
ALTER TABLE [dbo].[tbl_retailer] ADD UNIQUE NONCLUSTERED 
(
	[first_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_administrator] ADD  DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [dbo].[tbl_administrator] ADD  DEFAULT (getdate()) FOR [created_time]
GO
ALTER TABLE [dbo].[tbl_branch] ADD  DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [dbo].[tbl_branch] ADD  DEFAULT (getdate()) FOR [created_time]
GO
ALTER TABLE [dbo].[tbl_chat] ADD  DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [dbo].[tbl_chat] ADD  DEFAULT (getdate()) FOR [created_time]
GO
ALTER TABLE [dbo].[tbl_consumer] ADD  DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [dbo].[tbl_consumer] ADD  DEFAULT (getdate()) FOR [created_time]
GO
ALTER TABLE [dbo].[tbl_courier] ADD  DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [dbo].[tbl_courier] ADD  DEFAULT (getdate()) FOR [created_time]
GO
ALTER TABLE [dbo].[tbl_currency] ADD  DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [dbo].[tbl_currency] ADD  DEFAULT (getdate()) FOR [created_time]
GO
ALTER TABLE [dbo].[tbl_dict_tables] ADD  DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [dbo].[tbl_dict_tables] ADD  DEFAULT (getdate()) FOR [created_time]
GO
ALTER TABLE [dbo].[tbl_feedbackMessage] ADD  DEFAULT (getdate()) FOR [Date]
GO
ALTER TABLE [dbo].[tbl_feedbackMessage] ADD  DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [dbo].[tbl_feedbackMessage] ADD  DEFAULT (getdate()) FOR [created_time]
GO
ALTER TABLE [dbo].[tbl_manufacturer] ADD  DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [dbo].[tbl_manufacturer] ADD  DEFAULT (getdate()) FOR [created_time]
GO
ALTER TABLE [dbo].[tbl_message_log] ADD  DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [dbo].[tbl_message_log] ADD  DEFAULT (getdate()) FOR [created_time]
GO
ALTER TABLE [dbo].[tbl_order] ADD  DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [dbo].[tbl_order] ADD  DEFAULT (getdate()) FOR [created_time]
GO
ALTER TABLE [dbo].[tbl_product] ADD  DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [dbo].[tbl_product] ADD  DEFAULT (getdate()) FOR [created_time]
GO
ALTER TABLE [dbo].[tbl_productType] ADD  DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [dbo].[tbl_productType] ADD  DEFAULT (getdate()) FOR [created_time]
GO
ALTER TABLE [dbo].[tbl_purchaseType] ADD  DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [dbo].[tbl_purchaseType] ADD  DEFAULT (getdate()) FOR [created_time]
GO
ALTER TABLE [dbo].[tbl_retailer] ADD  DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [dbo].[tbl_retailer] ADD  DEFAULT (getdate()) FOR [created_time]
GO
ALTER TABLE [dbo].[tbl_retailer_stock] ADD  DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [dbo].[tbl_retailer_stock] ADD  DEFAULT (getdate()) FOR [created_time]
GO
ALTER TABLE [dbo].[tbl_score] ADD  DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [dbo].[tbl_score] ADD  DEFAULT (getdate()) FOR [created_time]
GO
ALTER TABLE [dbo].[tbl_shipment] ADD  DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [dbo].[tbl_shipment] ADD  DEFAULT (getdate()) FOR [created_time]
GO
ALTER TABLE [dbo].[tbl_transaction_stock] ADD  DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [dbo].[tbl_transaction_stock] ADD  DEFAULT (getdate()) FOR [created_time]
GO
ALTER TABLE [dbo].[tbl_unitType] ADD  DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [dbo].[tbl_unitType] ADD  DEFAULT (getdate()) FOR [created_time]
GO
ALTER TABLE [dbo].[tbl_user_log] ADD  DEFAULT (getdate()) FOR [log_date]
GO
ALTER TABLE [dbo].[tbl_user_log] ADD  DEFAULT (getdate()) FOR [log_time]
GO
ALTER TABLE [dbo].[tbl_user_log] ADD  DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [dbo].[tbl_user_log] ADD  DEFAULT (getdate()) FOR [created_time]
GO
ALTER TABLE [dbo].[tbl_usermanagement] ADD  DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [dbo].[tbl_usermanagement] ADD  DEFAULT (getdate()) FOR [created_time]
GO
ALTER TABLE [dbo].[tbl_userType] ADD  DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [dbo].[tbl_userType] ADD  DEFAULT (getdate()) FOR [created_time]
GO
ALTER TABLE [dbo].[tbl_warehouse] ADD  DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [dbo].[tbl_warehouse] ADD  DEFAULT (getdate()) FOR [created_time]
GO
ALTER TABLE [dbo].[tbl_administrator]  WITH CHECK ADD  CONSTRAINT [fkadUserType] FOREIGN KEY([UserTypeID])
REFERENCES [dbo].[tbl_userType] ([UserTypeID])
GO
ALTER TABLE [dbo].[tbl_administrator] CHECK CONSTRAINT [fkadUserType]
GO
ALTER TABLE [dbo].[tbl_branch]  WITH CHECK ADD  CONSTRAINT [fkadCurrencyID] FOREIGN KEY([currency_id])
REFERENCES [dbo].[tbl_currency] ([currency_id])
GO
ALTER TABLE [dbo].[tbl_branch] CHECK CONSTRAINT [fkadCurrencyID]
GO
ALTER TABLE [dbo].[tbl_consumer]  WITH CHECK ADD  CONSTRAINT [fkconUserType] FOREIGN KEY([UserTypeID])
REFERENCES [dbo].[tbl_userType] ([UserTypeID])
GO
ALTER TABLE [dbo].[tbl_consumer] CHECK CONSTRAINT [fkconUserType]
GO
ALTER TABLE [dbo].[tbl_courier]  WITH CHECK ADD  CONSTRAINT [fkcourUserType] FOREIGN KEY([UserTypeID])
REFERENCES [dbo].[tbl_userType] ([UserTypeID])
GO
ALTER TABLE [dbo].[tbl_courier] CHECK CONSTRAINT [fkcourUserType]
GO
ALTER TABLE [dbo].[tbl_manufacturer]  WITH CHECK ADD  CONSTRAINT [fkmanuUserType] FOREIGN KEY([UserTypeID])
REFERENCES [dbo].[tbl_userType] ([UserTypeID])
GO
ALTER TABLE [dbo].[tbl_manufacturer] CHECK CONSTRAINT [fkmanuUserType]
GO
ALTER TABLE [dbo].[tbl_message_log]  WITH CHECK ADD  CONSTRAINT [fkclientID] FOREIGN KEY([client_id])
REFERENCES [dbo].[tbl_consumer] ([manufacturer_id])
GO
ALTER TABLE [dbo].[tbl_message_log] CHECK CONSTRAINT [fkclientID]
GO
ALTER TABLE [dbo].[tbl_order]  WITH CHECK ADD  CONSTRAINT [fkmanufacturerIDSD] FOREIGN KEY([manufacturer_id])
REFERENCES [dbo].[tbl_manufacturer] ([manufacturer_id])
GO
ALTER TABLE [dbo].[tbl_order] CHECK CONSTRAINT [fkmanufacturerIDSD]
GO
ALTER TABLE [dbo].[tbl_order]  WITH CHECK ADD  CONSTRAINT [fkOrderPurchaseTypeID] FOREIGN KEY([purchaseTypeID])
REFERENCES [dbo].[tbl_purchaseType] ([purchaseTypeID])
GO
ALTER TABLE [dbo].[tbl_order] CHECK CONSTRAINT [fkOrderPurchaseTypeID]
GO
ALTER TABLE [dbo].[tbl_order]  WITH CHECK ADD  CONSTRAINT [fkOrderPurchaseWareHouseTypeID] FOREIGN KEY([warehouseID])
REFERENCES [dbo].[tbl_warehouse] ([warehouse_id])
GO
ALTER TABLE [dbo].[tbl_order] CHECK CONSTRAINT [fkOrderPurchaseWareHouseTypeID]
GO
ALTER TABLE [dbo].[tbl_order]  WITH CHECK ADD  CONSTRAINT [fkProductOrderID] FOREIGN KEY([product_id])
REFERENCES [dbo].[tbl_product] ([product_id])
GO
ALTER TABLE [dbo].[tbl_order] CHECK CONSTRAINT [fkProductOrderID]
GO
ALTER TABLE [dbo].[tbl_order]  WITH CHECK ADD  CONSTRAINT [fkretailerID] FOREIGN KEY([retailer_id])
REFERENCES [dbo].[tbl_retailer] ([manufacturer_id])
GO
ALTER TABLE [dbo].[tbl_order] CHECK CONSTRAINT [fkretailerID]
GO
ALTER TABLE [dbo].[tbl_product]  WITH CHECK ADD  CONSTRAINT [fkManufacturerID] FOREIGN KEY([manufacturer_id])
REFERENCES [dbo].[tbl_manufacturer] ([manufacturer_id])
GO
ALTER TABLE [dbo].[tbl_product] CHECK CONSTRAINT [fkManufacturerID]
GO
ALTER TABLE [dbo].[tbl_product]  WITH CHECK ADD  CONSTRAINT [fkproductTypeProduct] FOREIGN KEY([product_type_id])
REFERENCES [dbo].[tbl_productType] ([product_type_id])
GO
ALTER TABLE [dbo].[tbl_product] CHECK CONSTRAINT [fkproductTypeProduct]
GO
ALTER TABLE [dbo].[tbl_product]  WITH CHECK ADD  CONSTRAINT [fkUnitTypeProduct] FOREIGN KEY([unit_typeID])
REFERENCES [dbo].[tbl_unitType] ([unit_typeID])
GO
ALTER TABLE [dbo].[tbl_product] CHECK CONSTRAINT [fkUnitTypeProduct]
GO
ALTER TABLE [dbo].[tbl_retailer]  WITH CHECK ADD  CONSTRAINT [fkretaileUserType] FOREIGN KEY([UserTypeID])
REFERENCES [dbo].[tbl_userType] ([UserTypeID])
GO
ALTER TABLE [dbo].[tbl_retailer] CHECK CONSTRAINT [fkretaileUserType]
GO
ALTER TABLE [dbo].[tbl_retailer_stock]  WITH CHECK ADD  CONSTRAINT [fkstockRetailerID] FOREIGN KEY([retailer_id])
REFERENCES [dbo].[tbl_retailer] ([manufacturer_id])
GO
ALTER TABLE [dbo].[tbl_retailer_stock] CHECK CONSTRAINT [fkstockRetailerID]
GO
ALTER TABLE [dbo].[tbl_retailer_stock]  WITH CHECK ADD  CONSTRAINT [fkstockRetailerProductID] FOREIGN KEY([product_id])
REFERENCES [dbo].[tbl_product] ([product_id])
GO
ALTER TABLE [dbo].[tbl_retailer_stock] CHECK CONSTRAINT [fkstockRetailerProductID]
GO
ALTER TABLE [dbo].[tbl_retailer_stock]  WITH CHECK ADD  CONSTRAINT [fkstockRetailerWarehouseStockID] FOREIGN KEY([warehouseID])
REFERENCES [dbo].[tbl_warehouse] ([warehouse_id])
GO
ALTER TABLE [dbo].[tbl_retailer_stock] CHECK CONSTRAINT [fkstockRetailerWarehouseStockID]
GO
ALTER TABLE [dbo].[tbl_shipment]  WITH CHECK ADD  CONSTRAINT [fkProductConsumerShipmentID] FOREIGN KEY([consumer_id])
REFERENCES [dbo].[tbl_consumer] ([manufacturer_id])
GO
ALTER TABLE [dbo].[tbl_shipment] CHECK CONSTRAINT [fkProductConsumerShipmentID]
GO
ALTER TABLE [dbo].[tbl_shipment]  WITH CHECK ADD  CONSTRAINT [fkProductShipmentID] FOREIGN KEY([product_id])
REFERENCES [dbo].[tbl_product] ([product_id])
GO
ALTER TABLE [dbo].[tbl_shipment] CHECK CONSTRAINT [fkProductShipmentID]
GO
ALTER TABLE [dbo].[tbl_shipment]  WITH CHECK ADD  CONSTRAINT [fkShipmentCourierID] FOREIGN KEY([courier_id])
REFERENCES [dbo].[tbl_courier] ([manufacturer_id])
GO
ALTER TABLE [dbo].[tbl_shipment] CHECK CONSTRAINT [fkShipmentCourierID]
GO
ALTER TABLE [dbo].[tbl_transaction_stock]  WITH CHECK ADD  CONSTRAINT [fkProductIDTransactionStock] FOREIGN KEY([product_id])
REFERENCES [dbo].[tbl_product] ([product_id])
GO
ALTER TABLE [dbo].[tbl_transaction_stock] CHECK CONSTRAINT [fkProductIDTransactionStock]
GO
ALTER TABLE [dbo].[tbl_transaction_stock]  WITH CHECK ADD  CONSTRAINT [fkTransactionConsumerRetailerID] FOREIGN KEY([consumer_id])
REFERENCES [dbo].[tbl_consumer] ([manufacturer_id])
GO
ALTER TABLE [dbo].[tbl_transaction_stock] CHECK CONSTRAINT [fkTransactionConsumerRetailerID]
GO
ALTER TABLE [dbo].[tbl_transaction_stock]  WITH CHECK ADD  CONSTRAINT [fkTransactionRetailerID] FOREIGN KEY([retailer_id])
REFERENCES [dbo].[tbl_retailer] ([manufacturer_id])
GO
ALTER TABLE [dbo].[tbl_transaction_stock] CHECK CONSTRAINT [fkTransactionRetailerID]
GO
ALTER TABLE [dbo].[tbl_usermanagement]  WITH CHECK ADD  CONSTRAINT [fkUsermanagementUserTypeID] FOREIGN KEY([UserTypeID])
REFERENCES [dbo].[tbl_userType] ([UserTypeID])
GO
ALTER TABLE [dbo].[tbl_usermanagement] CHECK CONSTRAINT [fkUsermanagementUserTypeID]
GO
ALTER TABLE [dbo].[tbl_warehouse]  WITH CHECK ADD  CONSTRAINT [fkBranchIDWARE] FOREIGN KEY([branch_id])
REFERENCES [dbo].[tbl_branch] ([branch_id])
GO
ALTER TABLE [dbo].[tbl_warehouse] CHECK CONSTRAINT [fkBranchIDWARE]
GO
ALTER TABLE [dbo].[tbl_warehouse]  WITH CHECK ADD  CONSTRAINT [fkwareManufacturer] FOREIGN KEY([manufacturer_id])
REFERENCES [dbo].[tbl_retailer] ([manufacturer_id])
GO
ALTER TABLE [dbo].[tbl_warehouse] CHECK CONSTRAINT [fkwareManufacturer]
GO
/****** Object:  StoredProcedure [dbo].[ConsumerReport]    Script Date: 9/9/2021 8:47:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE procedure [dbo].[ConsumerReport](@StartIndex int, @PageSize int, @TotalCount int output, @Search int) as 
 BEGIN
 SELECT @TotalCount=count(1) from qry1;
 WITH CTE AS 
 (
 SELECT TOP(@StartIndex + @PageSize -1) RowNumber, RecID, ConsumerName, RetailerName, OrderID, Remark, ProductName, Quantity, Price, CreatedDate, CreatedTime FROM qry1 where ConsumerID=@Search
 )
 SELECT * from CTE where RowNumber between @StartIndex AND (@StartIndex + @PageSize -1)
 END
GO
/****** Object:  StoredProcedure [dbo].[CourierReport]    Script Date: 9/9/2021 8:47:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[CourierReport](@StartIndex int, @PageSize int, @TotalCount int output, @Search int) as 
BEGIN
SELECT @TotalCount=count(1) from qry_courier_reports;
with CTE AS 
(

SELECT TOP(@StartIndex  + @PageSize -1) RowNumber, RecID, OrderID, Remark, ShipmentName, ConsumerName, CustomerAddress, CourierName, ProductName, Quantity, ProductAddress,CreatedDate, CreatedTime from qry_courier_reports where CourierID=@Search
)
SELECT * from CTE where RowNumber between @StartIndex AND (@StartIndex + @PageSize -1)


END
GO
/****** Object:  StoredProcedure [dbo].[CRUD]    Script Date: 9/9/2021 8:47:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[CRUD](@RecID varchar(200), @FlagOn varchar(200)) as 
BEGIN
update tbl_order set flag_on=@FlagOn where rec_id=@RecID

END
GO
/****** Object:  StoredProcedure [dbo].[CRUDAdministrator]    Script Date: 9/9/2021 8:47:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[CRUDAdministrator](@RecID varchar(200), @UserTypeID VARCHAR(200), @FirstName varchar(200), @Email varchar(200), @TelephoneNo varchar(200), @Country varchar(200), @State varchar(200),@Address varchar(200), @StatementType varchar(200)) as 
BEGIN
IF @StatementType='INSERT'
insert into tbl_administrator(UserTypeID, first_name, email, telephone_no, country, state, address) values (@UserTypeID, @FirstName, @Email, @TelephoneNo, @Country, @State, @Address)
if @StatementType='UPDATE'
update tbl_administrator set UserTypeID=@UserTypeID , first_name=@FirstName, email=@Email, telephone_no=@TelephoneNo, country=@Country, state=@State, address=@Address where rec_id=@RecID
END
GO
/****** Object:  StoredProcedure [dbo].[CRUDBranch]    Script Date: 9/9/2021 8:47:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[CRUDBranch](@RecID varchar(200), @BranchName varchar(200), @BranchDescription varchar(max), @ContactPerson varchar(200), @Country varchar(200), @State varchar(200), @City varchar(200), @PhoneNo varchar(20), @Email varchar(200), @CurrencyID varchar(200), @StatementType varchar(200)) as 

begin
if @StatementType='INSERT' 
insert into tbl_branch(branch_name, branch_description, contact_person, country, state, city, phone_no, email, currency_id) values (@BranchName, @BranchDescription,@ContactPerson,@Country, @State, @City,@PhoneNo,@Email,@CurrencyID)

if @StatementType='UPDATE'
UPDATE tbl_branch SET branch_name=@BranchName, branch_description=@BranchDescription, contact_person=@ContactPerson, country=@Country, state=@State, city=@City, phone_no=@PhoneNo, email=@Email, currency_id=@CurrencyID WHERE rec_id=@RecID
END
GO
/****** Object:  StoredProcedure [dbo].[CRUDConsumer]    Script Date: 9/9/2021 8:47:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[CRUDConsumer](@RecID varchar(200), @UserTypeID VARCHAR(200), @FirstName varchar(200), @Email varchar(200), @TelephoneNo varchar(200), @Country varchar(200), @State varchar(200),@Address varchar(200), @StatementType varchar(200)) as 
BEGIN
IF @StatementType='INSERT'
insert into tbl_consumer(UserTypeID, first_name, email, telephone_no, country, state, address) values (@UserTypeID, @FirstName, @Email, @TelephoneNo, @Country, @State, @Address)
if @StatementType='UPDATE'
update tbl_consumer set UserTypeID=@UserTypeID , first_name=@FirstName, email=@Email, telephone_no=@TelephoneNo, country=@Country, state=@State, address=@Address where rec_id=@RecID
END
GO
/****** Object:  StoredProcedure [dbo].[CRUDCourier]    Script Date: 9/9/2021 8:47:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[CRUDCourier](@RecID varchar(200), @UserTypeID VARCHAR(200), @FirstName varchar(200), @Email varchar(200), @TelephoneNo varchar(200), @Country varchar(200), @State varchar(200),@Address varchar(200), @StatementType varchar(200)) as 
BEGIN
IF @StatementType='INSERT'
insert into tbl_courier(UserTypeID, first_name, email, telephone_no, country, state, address) values (@UserTypeID, @FirstName, @Email, @TelephoneNo, @Country, @State, @Address)
if @StatementType='UPDATE'
update tbl_courier set UserTypeID=@UserTypeID , first_name=@FirstName, email=@Email, telephone_no=@TelephoneNo, country=@Country, state=@State, address=@Address where rec_id=@RecID
END
GO
/****** Object:  StoredProcedure [dbo].[CRUDCurrency]    Script Date: 9/9/2021 8:47:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[CRUDCurrency](@RecID varchar(200), @CurrencyName varchar(200), @CurrencyCode varchar(200), @CurrencyDescription varchar(max), @StatementType varchar(200)) as 
BEGIN
IF @StatementType='INSERT'
insert into tbl_currency(currency_name, currency_code, currency_description) values (@CurrencyName, @CurrencyCode, @CurrencyDescription)
if @StatementType='UPDATE'
update  tbl_currency set currency_name=@CurrencyName, currency_code=@CurrencyCode, currency_description=@CurrencyDescription where rec_id=@RecID

END
GO
/****** Object:  StoredProcedure [dbo].[CRUDManufacturer]    Script Date: 9/9/2021 8:47:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[CRUDManufacturer](@RecID varchar(200), @UserTypeID VARCHAR(200), @FirstName varchar(200), @Email varchar(200), @TelephoneNo varchar(200), @Country varchar(200), @State varchar(200),@Address varchar(200), @StatementType varchar(200)) as 
BEGIN
IF @StatementType='INSERT'
insert into tbl_manufacturer(UserTypeID, first_name, email, telephone_no, country, state, address) values (@UserTypeID, @FirstName, @Email, @TelephoneNo, @Country, @State, @Address)
if @StatementType='UPDATE'
update tbl_manufacturer set UserTypeID=@UserTypeID , first_name=@FirstName, email=@Email, telephone_no=@TelephoneNo, country=@Country, state=@State, address=@Address where rec_id=@RecID
END
GO
/****** Object:  StoredProcedure [dbo].[CRUDProduct]    Script Date: 9/9/2021 8:47:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[CRUDProduct](@RecID varchar(200), @ProductName varchar(200), @UnitTypeID varchar(200), @ProductTypeID varchar(200), @BuyingPrice varchar(200), @SellingPrice varchar(200), @ProductProfile varchar(200), @ManufacturerID varchar(200), @ProductDescription varchar(max), @StatementType varchar(200)) as 
BEGIN
IF @StatementType='INSERT'
insert into tbl_product(product_name, unit_typeID, product_type_id, buying_price, selling_price, product_profile, manufacturer_id, product_description) values (@ProductName, @UnitTypeID, @ProductTypeID, @BuyingPrice, @SellingPrice, @ProductProfile, @ManufacturerID, @ProductDescription)
if @StatementType='UPDATE'
UPDATE tbl_product SET product_name=@ProductName, unit_typeID=@UnitTypeID, product_type_id=@ProductTypeID, buying_price=@BuyingPrice, selling_price=@SellingPrice, product_profile=@ProductProfile, manufacturer_id=@ManufacturerID, product_description=@ProductDescription WHERE rec_id=@RecID
END
GO
/****** Object:  StoredProcedure [dbo].[CRUDProductType]    Script Date: 9/9/2021 8:47:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[CRUDProductType](@RecID varchar(200), @productType varchar(200), @ProductDescription varchar(max), @StatementType varchar(200)) as 
BEGIN
IF @StatementType='INSERT'
insert into tbl_productType(product_type, product_description) values (@productType, @ProductDescription)
if @StatementType='UPDATE'
update  tbl_productType set product_type=@productType, product_description=@ProductDescription where rec_id=@RecID

END
GO
/****** Object:  StoredProcedure [dbo].[CRUDPurchaseType]    Script Date: 9/9/2021 8:47:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[CRUDPurchaseType](@RecID varchar(200),@PurchaseType varchar(200),@Description varchar(max), @StatementType varchar(200)) as
BEGIN
IF @StatementType='INSERT'
insert into tbl_purchaseType(purchase_type_name, type_description) values (@PurchaseType,@Description)
if @StatementType='UPDATE'
UPDATE tbl_purchaseType set purchase_type_name=@PurchaseType, type_description=@Description where rec_id=@RecID
END
GO
/****** Object:  StoredProcedure [dbo].[CRUDRetailer]    Script Date: 9/9/2021 8:47:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[CRUDRetailer](@RecID varchar(200), @UserTypeID VARCHAR(200), @FirstName varchar(200), @Email varchar(200), @TelephoneNo varchar(200), @Country varchar(200), @State varchar(200),@Address varchar(200), @StatementType varchar(200)) as 
BEGIN
IF @StatementType='INSERT'
insert into tbl_retailer(UserTypeID, first_name, email, telephone_no, country, state, address) values (@UserTypeID, @FirstName, @Email, @TelephoneNo, @Country, @State, @Address)
if @StatementType='UPDATE'
update tbl_retailer set UserTypeID=@UserTypeID , first_name=@FirstName, email=@Email, telephone_no=@TelephoneNo, country=@Country, state=@State, address=@Address where rec_id=@RecID
END
GO
/****** Object:  StoredProcedure [dbo].[CRUDShipemt]    Script Date: 9/9/2021 8:47:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[CRUDShipemt](@RecID varchar(200), @CourierID varchar(200), @ProductAddress varchar(200), @FlagOn varchar(200)) as 
BEGIN

UPDATE tbl_shipment set courier_id=@CourierID, product_address=@ProductAddress, flag_on=@FlagOn where rec_id=@RecID

END
GO
/****** Object:  StoredProcedure [dbo].[CRUDTransactionStock]    Script Date: 9/9/2021 8:47:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[CRUDTransactionStock](@RecID varchar(200), @FlagOn varchar(200)) as 
BEGIN
update tbl_transaction_stock set flag_on=@FlagOn where rec_id=@RecID
END
GO
/****** Object:  StoredProcedure [dbo].[CRUDUnitType]    Script Date: 9/9/2021 8:47:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[CRUDUnitType](@RecID varchar(200), @UnitType varchar(200), @UnitDescription varchar(max), @StatementType varchar(200)) as 
BEGIN
IF @StatementType='INSERT'
insert into tbl_unitType(unit_type, unit_description) values (@UnitType, @UnitDescription)
if @StatementType='UPDATE'
update  tbl_unitType set unit_type=@UnitType, unit_description=@UnitDescription where rec_id=@RecID

END
GO
/****** Object:  StoredProcedure [dbo].[CRUDUserManagement]    Script Date: 9/9/2021 8:47:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[CRUDUserManagement](@RecID varchar(200),@UserName varchar(200), @UserPassword varchar(200), @Manufacturer varchar(200), @Retailer varchar(200), @Consumer varchar(200), @Administrator varchar(200),@Courier varchar(200), @ProfilePic varchar(200), @UserTypeID VARCHAR(200), @StatementType varchar(200)) as 
BEGIN
IF @StatementType='INSERT'
insert into tbl_usermanagement (username, user_password, manufacturer, retailer, consumer, administrator, courier, profile_pic, UserTypeID) values (@UserName,@UserPassword,@Manufacturer,@Retailer,@Consumer,@Administrator, @Courier,@ProfilePic, @UserTypeID)
if @StatementType='UPDATE'
UPDATE  tbl_usermanagement SET username=@UserName, user_password=@UserPassword, manufacturer=@Manufacturer, retailer=@Retailer, consumer=@Consumer, administrator=@Administrator, courier=@Courier, profile_pic=@ProfilePic, UserTypeID=@UserTypeID WHERE rec_id=@RecID
END
GO
/****** Object:  StoredProcedure [dbo].[CRUDUserType]    Script Date: 9/9/2021 8:47:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[CRUDUserType](@RecID varchar(200),@UserType varchar(200),@TypeDescription varchar(200), @StatementType varchar(200)) as 
BEGIN
if @StatementType='INSERT'
insert into tbl_userType(user_type, type_description) values (@UserType, @TypeDescription)
if @StatementType='UPDATE'
update tbl_userType set user_type=@UserType, type_description=@TypeDescription where rec_id=@RecID
END
GO
/****** Object:  StoredProcedure [dbo].[CRUDWarehouse]    Script Date: 9/9/2021 8:47:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[CRUDWarehouse](@RecID varchar(200), @WarehouseName varchar(200), @BranchID varchar(200), @WarehouseDescription varchar(200), @RetailerID varchar(200), @StatementType varchar(200)) as 
BEGIN
if @StatementType='INSERT'
INSERT INTO tbl_warehouse(warehouse_name, branch_id, warehouse_description, manufacturer_id) values (@WarehouseName,@BranchID,@WarehouseDescription, @RetailerID)
if @StatementType='UPDATE'
UPDATE  tbl_warehouse SET warehouse_name=@WarehouseName, branch_id=@BranchID, warehouse_description=@WarehouseDescription, manufacturer_id=@RetailerID WHERE rec_id=@RecID

END
GO
/****** Object:  StoredProcedure [dbo].[GetAdministrator]    Script Date: 9/9/2021 8:47:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[GetAdministrator](@StartIndex int, @PageSize int, @TotalCount int output) as 
BEGIN

select @TotalCount=count(1) from qry_administrator;
WITH CTE AS 
(
SELECT TOP(@StartIndex + @PageSize -1) RowNumber, RecID, [User Type], Name, Email, TelephoneNo, Country, State, Address, CreatedDate as [Created Date], CreatedTime as [Created Time] from qry_administrator
)
select * from CTE where RowNumber between @StartIndex AND (@StartIndex + @PageSize -1)

end
GO
/****** Object:  StoredProcedure [dbo].[GetAuditTrail]    Script Date: 9/9/2021 8:47:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetAuditTrail](@StartIndex int, @PageSize int , @TotalCount int output) as 
BEGIN
SELECT @TotalCount=count(1) from tbl_user_log;
WITH CTE AS 
(
select top(@StartIndex + @PageSize -1) row_number() over (order by rec_id) as RowNumber, rec_id as [RecID], user_name as [UserName], log_url as [Log Url], log_date as [Log Date], log_time as [Log Time], log_sql as [Log SQL]  from tbl_user_log
)
select * from CTE where RowNumber between @StartIndex  AND (@StartIndex + @PageSize -1)

END
GO
/****** Object:  StoredProcedure [dbo].[GetBranch]    Script Date: 9/9/2021 8:47:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetBranch](@StartIndex int, @PageSize int, @TotalCount int output) as 
BEGIN
select @TotalCount=count(1) from qry_branch;
WITH CTE AS 
(
SELECT TOP(@StartIndex + @PageSize -1)  RowNumber, RecID, BranchName as [Branch Name], BranchDescription as [Branch Description], ContactPerson as [Contact Person], Country as [Country], State as [State], City as [City], TelaphoneNo as [Telephone Number], Email as [Email], CurrencyName as [Currency], CreatedDate as [Created Date], CreatedTime as [Created Time] 
  from qry_branch 
)
select * from CTE where RowNumber between @StartIndex AND (@StartIndex + @PageSize -1)
END
GO
/****** Object:  StoredProcedure [dbo].[GetComment]    Script Date: 9/9/2021 8:47:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetComment](@StartIndex int, @PageSize int, @TotalCount int output) as 
 BEGIN

 SELECT @TotalCount=count(1) from qry_comment;

 WITH CTE AS 
 (
 SELECT TOP(@StartIndex + @PageSize -1) RowNumber, RecID, FeedbackComment as [Feedback Comment], PositiveComment as [Positive Comment], NegativeComment as [Negative Comment], NeutralComment as [Neutral Comment], CreatedDate as [CreatedDate], CreatedTime as [CreatedTime] from qry_comment
 )
 select * from CTE where RowNumber between @StartIndex AND (@StartIndex + @PageSize -1)
 END
GO
/****** Object:  StoredProcedure [dbo].[GetConsumer]    Script Date: 9/9/2021 8:47:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetConsumer](@StartIndex int, @PageSize int, @TotalCount int output) as 
BEGIN

select @TotalCount=count(1) from qry_consumer;
WITH CTE AS 
(
SELECT TOP(@StartIndex + @PageSize -1) RowNumber, RecID, [User Type], Name, Email, TelephoneNo, Country, State, Address, CreatedDate as [Created Date], CreatedTime as [Created Time] from qry_consumer
)
select * from CTE where RowNumber between @StartIndex AND (@StartIndex + @PageSize -1)

end
GO
/****** Object:  StoredProcedure [dbo].[GetConsumerByNumber]    Script Date: 9/9/2021 8:47:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[GetConsumerByNumber](@StartIndex int, @PageSize int, @TotalCount int output, @Number int) as 
BEGIN

select @TotalCount=count(1) from qry_consumer;
WITH CTE AS 
(
SELECT TOP(@StartIndex + @PageSize -1) RowNumber, RecID, [User Type], Name, Email, TelephoneNo, Country, State, Address, CreatedDate as [Created Date], CreatedTime as [Created Time] from qry_consumer where TelephoneNo=@Number
)
select * from CTE where RowNumber between @StartIndex AND (@StartIndex + @PageSize -1)

end
GO
/****** Object:  StoredProcedure [dbo].[GetCourier]    Script Date: 9/9/2021 8:47:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetCourier](@StartIndex int, @PageSize int, @TotalCount int output) as 
BEGIN

select @TotalCount=count(1) from qry_courier;
WITH CTE AS 
(
SELECT TOP(@StartIndex + @PageSize -1) RowNumber, RecID, [User Type], Name, Email, TelephoneNo, Country, State, Address, CreatedDate as [Created Date], CreatedTime as [Created Time] from qry_courier
)
select * from CTE where RowNumber between @StartIndex AND (@StartIndex + @PageSize -1)

end
GO
/****** Object:  StoredProcedure [dbo].[GetCourierReport]    Script Date: 9/9/2021 8:47:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[GetCourierReport](@StartIndex int, @PageSize int,@CourierID int, @FlagOn int, @TotalCount int output) as 
BEGIN

SELECT @TotalCount=count(1) from qry_courier_report;
WITH CTE AS 
(
SELECT TOP(@StartIndex + @PageSize -1) RowNumber, RecID, OrderID, Report, CourierName, ProductName, Quantity, NewAddress, ConsumerName, ConsumerEmail, ConsumerTelephoneNumber, ConsumerAddress, CreatedDate, CreatedTime from qry_courier_report where CourierID=@CourierID AND  flagOn=@FlagOn
)
select * from CTE where RowNumber between @StartIndex AND (@StartIndex + @PageSize -1)


END
GO
/****** Object:  StoredProcedure [dbo].[GetCourierReports]    Script Date: 9/9/2021 8:47:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetCourierReports](@StartIndex int, @PageSize int,@CourierID int, @FlagOn int, @TotalCount int output) as 
BEGIN

SELECT @TotalCount=count(1) from qry_courier_report;
WITH CTE AS 
(
SELECT TOP(@StartIndex + @PageSize -1) RowNumber, RecID, OrderID, Report, CourierName, ProductName, Quantity, NewAddress, ConsumerName, ConsumerEmail, ConsumerTelephoneNumber, ConsumerAddress, CreatedDate, CreatedTime from qry_courier_report where  flagOn=@FlagOn
)
select * from CTE where RowNumber between @StartIndex AND (@StartIndex + @PageSize -1)


END
GO
/****** Object:  StoredProcedure [dbo].[GetCurrency]    Script Date: 9/9/2021 8:47:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[GetCurrency](@StartIndex int, @PageSize int, @TotalCount int output) as 
BEGIN
select @TotalCount=count(1) from tbl_currency;
WITH CTE AS 
(
SELECT TOP(@StartIndex + @PageSize  -1) row_number() over (order by rec_id desc) as RowNumber, rec_id as [RecID], currency_name as [Currency Name], currency_code as [Currency Code], currency_description as [Currency Description], created_date as [Created Date], created_time as [Created Time] from tbl_currency
)
select * from CTE where RowNumber between @StartIndex AND (@StartIndex + @PageSize -1)

END
GO
/****** Object:  StoredProcedure [dbo].[GetCust]    Script Date: 9/9/2021 8:47:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetCust](@StartIndex int, @PageSize int, @Search int, @TotalCount int output) as 
BEGIN
SELECT @TotalCount=count(1) from tbl_consumer;
WITH CTE AS 
(
select top(@StartIndex + @PageSize -1) row_number() over (order by rec_id) as [RowNumber], rec_id as [RecID], first_name as [ConsumerName], email as [ConsumerEmail], telephone_no as [TelephoneNumber], country as [Country], state as [State], address as [Address], created_date as [CreatedDate], created_time as [CreatedTime] from tbl_consumer where rec_id=@Search

)
SELECT * FROM CTE where RowNumber between @StartIndex AND (@StartIndex + @PageSize -1)

END
GO
/****** Object:  StoredProcedure [dbo].[GetCustomerReport]    Script Date: 9/9/2021 8:47:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[GetCustomerReport](@StartIndex int, @PageSize int, @TotalCount int output, @RetailerID int) as 
BEGIN

select @TotalCount=count(1) from qry_customer_report;
WITH CTE AS
(
select top(@StartIndex + @PageSize -1) RowNumber, RecID, FlagOn, RetailerName, ConsumerName, ProductName, Quantity, Price, CreatedDate, CreatedTime from qry_customer_report where RetailerID=@RetailerID
)
SELECT * FROM CTE where RowNumber between @StartIndex AND (@StartIndex + @PageSize -1)


END
GO
/****** Object:  StoredProcedure [dbo].[GetCustomerReports]    Script Date: 9/9/2021 8:47:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetCustomerReports](@StartIndex int, @PageSize int, @TotalCount int output, @RetailerID int, @FlagOn int) as 
BEGIN

select @TotalCount=count(1) from qry_customer_report;
WITH CTE AS
(
select top(@StartIndex + @PageSize -1) RowNumber, RecID, FlagOn, RetailerName, ConsumerName, ProductName, Quantity, Price, CreatedDate, CreatedTime from qry_customer_report where RetailerID=@RetailerID AND FlagOn=@FlagOn
)
SELECT * FROM CTE where RowNumber between @StartIndex AND (@StartIndex + @PageSize -1)


END
GO
/****** Object:  StoredProcedure [dbo].[GetManufacturer]    Script Date: 9/9/2021 8:47:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetManufacturer](@StartIndex int, @PageSize int, @TotalCount int output) as 
BEGIN

select @TotalCount=count(1) from qry_manufacturer;
WITH CTE AS 
(
SELECT TOP(@StartIndex + @PageSize -1) RowNumber, RecID, [User Type], Name, Email, TelephoneNo, Country, State, Address, CreatedDate as [Created Date], CreatedTime as [Created Time] from qry_manufacturer
)
select * from CTE where RowNumber between @StartIndex AND (@StartIndex + @PageSize -1)

end
GO
/****** Object:  StoredProcedure [dbo].[GetProduct]    Script Date: 9/9/2021 8:47:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[GetProduct](@StartIndex int, @PageSize int, @TotalCount int output) as 
BEGIN
SELECT @TotalCount=count(1) from qry_product;
WITH CTE AS 
(
select  top(@StartIndex + @PageSize -1) RowNumber, RecID, ManufacturerName as [Manufacturer Name], ProductName as [Product Name], UnitType as [Unit Type], [Product Type], BuyingPrice as [Buying Price], SellingPrice as [Selling Price], ProductDescription as [Product Description], ProductProfile as [Product Profile], CreatedDate as [Created Date], CreatedTime as [Created Time] from qry_product
)
select * from CTE WHERE RowNumber between @StartIndex and (@StartIndex + @PageSize -1)
END
GO
/****** Object:  StoredProcedure [dbo].[GetProductType]    Script Date: 9/9/2021 8:47:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[GetProductType](@StartIndex int, @PageSize int, @TotalCount int output) as 
BEGIN
select @TotalCount=count(1) from tbl_productType;
WITH CTE AS 
(
SELECT TOP(@StartIndex + @PageSize  -1) row_number() over (order by rec_id desc) as RowNumber, rec_id as [RecID], product_type as [Product Type], product_description as [Product Description], created_date as [Created Date], created_time as [Created Time] from tbl_productType
)
select * from CTE where RowNumber between @StartIndex AND (@StartIndex + @PageSize -1)

END
GO
/****** Object:  StoredProcedure [dbo].[GetPurchaseType]    Script Date: 9/9/2021 8:47:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetPurchaseType](@StartIndex int, @PageSize int, @TotalCount int output) as 
BEGIN
select @TotalCount=count(1) from tbl_purchaseType;
with CTE AS 
(
select top(@StartIndex + @PageSize -1) row_number() over (order by rec_id desc) as RowNumber, rec_id as [RecID],purchase_type_name as [Purchase Type],type_description as [Purchase Type Description], created_date as [Created Date], created_time as [Created Time]   from tbl_purchaseType
)
select * from CTE where RowNumber between @StartIndex AND (@StartIndex + @PageSize -1)
END
GO
/****** Object:  StoredProcedure [dbo].[GetRetailer]    Script Date: 9/9/2021 8:47:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetRetailer](@StartIndex int, @PageSize int, @TotalCount int output) as 
BEGIN

select @TotalCount=count(1) from qry_retailer;
WITH CTE AS 
(
SELECT TOP(@StartIndex + @PageSize -1) RowNumber, RecID, [User Type], Name, Email, TelephoneNo, Country, State, Address, CreatedDate as [Created Date], CreatedTime as [Created Time] from qry_retailer
)
select * from CTE where RowNumber between @StartIndex AND (@StartIndex + @PageSize -1)

end
GO
/****** Object:  StoredProcedure [dbo].[GetRetailerProduct]    Script Date: 9/9/2021 8:47:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[GetRetailerProduct](@StartIndex int, @PageSize int , @TotalCount int output) as 
BEGIN
select @TotalCount=count(1) from qry_stock_tran;
WITH CTE AS 
(
SELECT TOP(@StartIndex + @PageSize -1) row_number() over(order by t.RetailerID) as RowNumber, t.RetailerName as [RetailerName], t.ProductID as [ProductID], t.ProductName as [ProductName], t.[Product Description] as [ProductDescription], t.ProductProfile, p.selling_price as [SellingPrice]
  from qry_one t join tbl_product p on p.product_id=t.ProductID
)
select * from CTE where RowNumber between @StartIndex AND (@StartIndex + @PageSize -1)
END
GO
/****** Object:  StoredProcedure [dbo].[GetStock]    Script Date: 9/9/2021 8:47:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[GetStock](@StartIndex int, @PageSize int, @TotalCount int output) as 
BEGIN 
SELECT @TotalCount=count(1) from qry_stock;
WITH CTE AS 
(
SELECT TOP(@StartIndex + @PageSize -1) RowNumber, RecID, OrderID, FlagOn as [Remark], RetailerName as [Retailer Name], ManufacturerName as [Manufacturer Name], ProductName as [Product Name], ProductDescription as [Product Description], Quantity as [Quantity], PurchasedPrice as [Puchased Price], PurchaseType as [Puchased Type],WareHouseName as [To Warehouse], [OrderedDate ] as [Ordered Date], OrderedTime as [Ordered Time] from qry_stock where Rem>0
)
select * from CTE where RowNumber between @StartIndex and (@StartIndex + @PageSize -1)
END
GO
/****** Object:  StoredProcedure [dbo].[GetStockCancelled]    Script Date: 9/9/2021 8:47:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetStockCancelled](@StartIndex int, @PageSize int, @TotalCount int output) as 
BEGIN 
SELECT @TotalCount=count(1) from qry_stock;
WITH CTE AS 
(
SELECT TOP(@StartIndex + @PageSize -1) RowNumber, RecID, OrderID, FlagOn as [Remark], RetailerName as [Retailer Name], ManufacturerName as [Manufacturer Name], ProductName as [Product Name], ProductDescription as [Product Description], Quantity as [Quantity], PurchasedPrice as [Puchased Price], PurchaseType as [Puchased Type],WareHouseName as [To Warehouse], [OrderedDate ] as [Ordered Date], OrderedTime as [Ordered Time] from qry_stock where Rem=0
)
select * from CTE where RowNumber between @StartIndex and (@StartIndex + @PageSize -1)
END
GO
/****** Object:  StoredProcedure [dbo].[GetTopProduct]    Script Date: 9/9/2021 8:47:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetTopProduct] as 
BEGIN

SELECT TOP 100 * FROM qry_product

END
GO
/****** Object:  StoredProcedure [dbo].[GetTopRetailerProduct]    Script Date: 9/9/2021 8:47:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[GetTopRetailerProduct] as 
BEGIN

SELECT TOP(100) row_number() over(order by t.RetailerID) as RowNumber,t.RetailerID as [RetailerID], t.RetailerName as [RetailerName], t.ProductID as [ProductID], t.ProductName as [ProductName], t.[Product Description] as [ProductDescription], t.ProductProfile, p.selling_price as [SellingPrice]
  from qry_stock_tran t join tbl_product p on p.product_id=t.ProductID

END
GO
/****** Object:  StoredProcedure [dbo].[GetUnitType]    Script Date: 9/9/2021 8:47:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[GetUnitType](@StartIndex int, @PageSize int, @TotalCount int output) as 
BEGIN
select @TotalCount=count(1) from tbl_unitType;
WITH CTE AS 
(
SELECT TOP(@StartIndex + @PageSize  -1) row_number() over (order by rec_id desc) as RowNumber, rec_id as [RecID], unit_type as [Unit Type], unit_description as [Unit Description], created_date as [Created Date], created_time as [Created Time] from tbl_unitType
)
select * from CTE where RowNumber between @StartIndex AND (@StartIndex + @PageSize -1)

END
GO
/****** Object:  StoredProcedure [dbo].[GetUserManagament]    Script Date: 9/9/2021 8:47:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetUserManagament](@StartIndex int, @PageSize int, @TotalCount int output) as 
BEGIN
select @TotalCount=count(1) from qry_usermanagement;
WITH CTE AS 
(
select top(@StartIndex + @PageSize -1) RowNumber, Username as [User Name], UserType as [User Type], CreatedDate as [Created Date], CreatedTime as [Created Time] from qry_usermanagement
)
select * from CTE where RowNumber between @StartIndex  AND (@StartIndex + @PageSize -1)

END
GO
/****** Object:  StoredProcedure [dbo].[GetUserManagement]    Script Date: 9/9/2021 8:47:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[GetUserManagement](@StartIndex int, @PageSize int, @TotalCount int output) as 
BEGIN
select @TotalCount=count(1) from qry_usermanagement;
WITH CTE AS 
(
select top(@StartIndex + @PageSize -1) RowNumber, RecID, Username as [User Name], Password as [User Password], AdministratorID, ManufacturerID, RetailerID, UserType, ProfilePic, CreatedDate as [Created Date], CreatedTime as [Created Time] from qry_usermanagement
)
select * from CTE where RowNumber between @StartIndex  AND (@StartIndex + @PageSize -1)

END
GO
/****** Object:  StoredProcedure [dbo].[GetUserType]    Script Date: 9/9/2021 8:47:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetUserType](@StartIndex int, @PageSize int, @TotalCount int output) as 
BEGIN
SELECT @TotalCount=count(1) from tbl_userType;
WITH CTE AS 
(
select  top(@StartIndex + @PageSize -1 ) row_number() over (order by rec_id desc) as RowNumber, rec_id as [RecID],user_type AS [User Type], type_description as [Type Description], created_date as [Created Date], created_time as [Created Time] from tbl_userType
)

select * from CTE where RowNumber between @StartIndex AND (@StartIndex + @PageSize -1)

END
GO
/****** Object:  StoredProcedure [dbo].[GetWareHouse]    Script Date: 9/9/2021 8:47:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[GetWareHouse](@StartIndex int, @PageSize int, @TotalCount int output) as 
BEGIN
SELECT @TotalCount=count(1) from qry_warehouse;
WITH CTE AS 
(
select top(@StartIndex + @PageSize -1) RowNumber, RecID, RetailerID, BranchName as [Branch Name], WarehouseName as [Warehouse Name], WarehouseDescription as [Warehouse Description], CreatedDate as [CreatedDate], CreatedTime as [Created Time] from qry_warehouse
)
select * from CTE where RowNumber between @StartIndex  AND  (@StartIndex + @PageSize -1)

END
GO
/****** Object:  StoredProcedure [dbo].[RemainStockReport]    Script Date: 9/9/2021 8:47:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[RemainStockReport](@StartIndex int, @PageSize int, @TotalCount int output, @Search int) as 
BEGIN
SELECT @TotalCount=count(1) from qry_remain_stock;
WITH CTE AS 
(
SELECT top(@StartIndex + @PageSize -1) RowNumber, RetailerName, InWareHouse as [In WareHouse], ProductName as [Product Name], StockRemains as [Stock Remains] from qry_remain_stock where  RetailerID=@Search
)
SELECT * from CTE where RowNumber between @StartIndex and (@StartIndex + @PageSize -1)

END
GO
/****** Object:  StoredProcedure [dbo].[ReportManufacturerSales]    Script Date: 9/9/2021 8:47:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[ReportManufacturerSales](@StartIndex int, @PageSize int , @TotalCount int output, @Search int) as 
BEGIN
SELECT @TotalCount=count(1) from qry_report_manufacturer;
WITH CTE AS
(
SELECT TOP(@StartIndex + @PageSize -1) RowNumber, RecID, Remark, ManufacturerName as [Manufacturer Name], RetailerName as [Retailer Name], ProductName as [Product Name], Quantity as [Quantity], SoldPrice * Quantity as [SoldPrice], ToRetailerWareHouse as [To Retailer Warehouse], PurchaseName as [Purchased Name], CreatedDate as [CreatedDate], CreatedTime as [CreatedTime] from qry_report_manufacturer where ManufacturerID=@Search group by RowNumber, RecID, Remark, ManufacturerID, ManufacturerName, RetailerName, ProductName, Quantity, ToRetailerWareHouse, PurchaseName, CreatedDate, CreatedTime, SoldPrice
)
select * from CTE where RowNumber between @StartIndex AND (@StartIndex + @PageSize -1)


END
GO
/****** Object:  StoredProcedure [dbo].[RetailerSalesReports]    Script Date: 9/9/2021 8:47:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[RetailerSalesReports](@StartIndex int, @PageSize int, @TotalCount int output, @Search int) as 
BEGIN
SELECT @TotalCount=count(1) from  qry1;
WITH CTE AS 
(
SELECT TOP(@StartIndex + @PageSize -1) RowNumber, RecID, Remark, RetailerName, ConsumerName, ProductName, Quantity, Price, OrderID, CreatedDate, CreatedTime from qry1 where RetailerID=@Search
)
SELECT * from CTE where RowNumber between @StartIndex AND (@StartIndex + @PageSize -1)

END
GO
