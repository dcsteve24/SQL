-- =============================================
-- Create/Populate Database Script
-- Steven Craig 20Oct19
-- For school project CTU CS660 IP3
-- MICROSOFT SQL SERVER
-- =============================================
USE master
GO

-- Drop the database if it already exists --
IF  EXISTS (
	SELECT name 
		FROM sys.databases 
		WHERE name = 'GoodExcuse'
)
DROP DATABASE GoodExcuse
GO

-- Create Database --
CREATE DATABASE GoodExcuse
GO

-- Swtich to Database --
USE GoodExcuse

-- Create Tables --
-- Customers
CREATE TABLE tblCustomers (
	CustomerID INT IDENTITY(1,1) PRIMARY KEY,
	Username NVARCHAR(255) NOT NULL UNIQUE,
	PasswordHash BINARY(64) NOT NULL,
	Salt NVARCHAR(MAX) NOT NULL,
	FirstName NVARCHAR(MAX) NOT NULL,
	MiddleName NVARCHAR(MAX),
	LastName NVARCHAR(MAX) NOT NULL,
	Sex CHAR(1),
	DOB DATE NOT NULL,
	AddressID INT UNIQUE
)

-- Orders
CREATE TABLE tblOrders (
	SaleID INT IDENTITY(1,1) PRIMARY KEY,
	OrderID UNIQUEIDENTIFIER NOT NULL,
	CustomerID INT,
	StoreID INT,
	Barcode BIGINT NOT NULL,
	ProductQty INT NOT NULL,
	ShoppingMethod NVARCHAR(10) NOT NULL,
	PaymentMethod NVARCHAR(10) NOT NULL,
	DateofPurchase DATE NOT NULL,
	PreTaxTotal MONEY NOT NULL,
	TaxAmount MONEY NOT NULL,
	TotalPrice MONEY NOT NULL
)

-- Store
CREATE TABLE tblStore (
	StoreID INT IDENTITY(1,1) PRIMARY KEY,
	StoreShortName NVARCHAR(10),
	AddressID INT UNIQUE
)

-- SalesTax
CREATE TABLE tblSalesTax (
	StateAbrv NVARCHAR(2) NOT NULL PRIMARY KEY,
	StateFullName NVARCHAR(20) NOT NULL UNIQUE,
	SalesTax DEC(6,3) NOT NULL
)

-- Address
CREATE TABLE tblAddress (
	AddressID INT IDENTITY(1,1) PRIMARY KEY,
	StreetAddress NVARCHAR(MAX) NOT NULL,
	City NVARCHAR(50) NOT NULL,
	StateAbrv NVARCHAR(2) NOT NULL,
	Country NVARCHAR(20) NOT NULL,
	ZipCode INT NOT NULL,
	ContactPhone INT NOT NULL,
	ContactEmail NVARCHAR(MAX) NOT NULL
)

-- Products
CREATE TABLE tblProducts (
	Barcode BIGINT NOT NULL PRIMARY KEY,
	StoreID INT,
	Manufacturer NVARCHAR(MAX) NOT NULL,
	MakeModel NVARCHAR(MAX) NOT NULL,
	RestockCost MONEY NOT NULL,
	CustomerCost MONEY NOT NULL,
	GenderAssociation NVARCHAR(1),
	Department NVARCHAR(20) NOT NULL,
	Category NVARCHAR(MAX) NOT NULL,
	Descrip NVARCHAR(MAX) NOT NULL,
	QtyTotal INT NOT NULL,
	QtyShelf INT NOT NULL
)

-- Setup Foreign Keys
ALTER TABLE tblCustomers ADD FOREIGN KEY (AddressID) REFERENCES tblAddress(AddressID)
ALTER TABLE tblOrders ADD FOREIGN KEY (CustomerID) REFERENCES tblCustomers(CustomerID)
ALTER TABLE tblOrders ADD FOREIGN KEY (StoreID) REFERENCES tblStore(StoreID)
ALTER TABLE tblOrders ADD FOREIGN KEY (Barcode) REFERENCES tblProducts(Barcode)
ALTER TABLE tblStore ADD FOREIGN KEY (AddressID) REFERENCES tblAddress(AddressID)
ALTER TABLE tblAddress ADD FOREIGN KEY (StateAbrv) REFERENCES tblSalesTax(StateAbrv)
ALTER TABLE tblProducts ADD FOREIGN KEY (StoreID) REFERENCES tblStore(StoreID)

-- Populate the tables in the database with 20 fields each --
-- StateTax -- Because of foriegn key relations have to start here and work our way up
INSERT INTO tblSalesTax VALUES
	('AL', 'Alabama', 4),
	('AK', 'Alaska', 0),
	('AZ', 'Arizona', 5.6),
	('AR', 'Arkansas', 6.5),
	('CA', 'California', 7.25),
	('CO', 'Colorado', 2.9),
	('CT', 'Connecticut', 6.35),
	('DE', 'Delaware', 0),
	('FL', 'Florida', 6),
	('GA', 'Georgia', 4),
	('HI', 'Hawaii', 4),
	('ID', 'Idaho', 6),
	('IL', 'Illinois', 6.25),
	('IN', 'Indiana', 7),
	('IA', 'Iowa', 6),
	('KS', 'Kansas', 6.5),
	('KY', 'Kentucky', 6),
	('LA', 'Louisiana', 4.45),
	('ME', 'Maine', 5.5),
	('MD', 'Maryland', 6),
	('MA', 'Massachusetts', 6.25),
	('MI', 'Michigan', 6),
	('MN', 'Minnesota', 6.875),
	('MS', 'Mississippi', 7),
	('MO', 'Missouri', 4.225),
	('MT', 'Montana', 0),
	('NE', 'Nebraska', 5.5),
	('NV', 'Nevada', 4.6),
	('NH', 'New Hampshire', 0),
	('NJ', 'New Jersey', 6.625),
	('NM', 'New Mexico', 5.125),
	('NY', 'New York', 4),
	('NC', 'North Carolina', 4.75),
	('ND', 'North Dakota', 5),
	('OH', 'Ohio', 5.75),
	('OK', 'Oklahoma', 4.5),
	('OR', 'Oregon', 0),
	('PA', 'Pennsylvania', 6),
	('RI', 'Rhode Island', 7),
	('SC', 'South Carolina', 6),
	('SD', 'South Dakota', 4.5),
	('TN', 'Tennessee', 7),
	('TX', 'Texas', 6.25),
	('UT', 'Utah', 4.85),
	('VT', 'Vermont', 6),
	('VA', 'Virginia', 4.3),
	('WA', 'Washington', 6.5),
	('WV', 'West Virginia', 6),
	('WI', 'Wisconsin', 5),
	('WY', 'Wyoming', 4)

-- Address
INSERT INTO tblAddress VALUES 
--Customers
	('111 Pecan Drive', 'Colorado Springs', 'CO', 'USA', 80916, 8675309, 'billyjoe@gmail.com'),
	('128 Peanut Drive', 'Dallas', 'TX', 'USA', 75001, 8675309, 'frankshotdogs@gmail.com'),
	('4242 Galaxy Lane', 'Indianapolis', 'IN', 'USA', 46221, 8675309, 'answertotheuniverse@yahoo.com'),
	('2424 Jeff Drive', 'Fort Wayne', 'IN', 'USA', 46774, 8675309, 'jeffgordonrules@aol.com'),
	('1212 Testing Blvd', 'Boston', 'MA', 'USA', 02101, 8675309, 'testing12@gmail.com'),
	('666 Hell Lane', 'Hell', 'MI', 'USA', 48169, 8675309, 'itshothere@gmail.com'),
	('123 Count Road', 'Tuscan', 'AZ', 'USA', 85641, 8675309, 'icancounttothree@gmail.com'),
	('314 Pi Blvd', 'Memphis', 'TN', 'USA', 37501, 8675309, 'sqrtofpi@gmail.com'),
	('1234 Happy Days Drive', 'Milwaukee', 'WI', 'USA', 53201, 8675309, 'ehhhhhh@gmail.com'),
	('1010 Halfway Rd', 'Oakland', 'CA', 'USA', 94501, 8675309, 'Raiders@gmail.com'),
	('911 Help Way', 'Stockton', 'CA', 'USA', 95208, 8675309, 'helpisontheway@aol.com'),
	('666 Witchcraft Way', 'Salem', 'MA', 'USA', 01970, 8675309, 'IputaSpellonYou@gmail.com'),
	('10110 Bits Way', 'Tacoma', 'WA', 'USA', 53201, 8675309, 'byteme@gmail.com'),
	('2020 Tomany Dr', 'Colorado Springs', 'CO', 'USA', 80916, 8675309, '20istomany@gmail.com'),
	('1600 Pennsylvania Ave', 'Washington D.C.', 'MD', 'USA', 20006, 8675309, 'mrpresident@gmail.com'),
	('140 Coke Ave', 'Atlanta', 'GA', 'USA', 30305, 8675309, 'itstherealthing@gmail.com'),
	('150 Pepsi Way', 'Purchase', 'NY', 'USA', 10577, 8675309, 'thechoiceofanewgeneration@gmail.com'),
	('150 Dr Pepper Ave', 'Charleston', 'TX', 'USA', 75432, 8675309, '23flavors@gmail.com'),
	('22 Tent Ave Suit 20', 'Denver', 'CO', 'USA', 20006, 8675309, 'imoutofjokes@gmail.com'),
	('12345 Sequential Way', 'Modesto', 'CA', 'USA', 95352, 8675309, 'stillout@gmail.com'),
--Business
	('1111 Money Way', 'Yonkers', 'NY', 'USA', 10470, 8675309, 'yonkeroffice@goodexcuse.org'),
	('2121 Rich Drive', 'Tempe', 'AZ', 'USA', 85280, 8675309, 'tempeoffice@goodexcuse.org'),
	('3131 Billionare Way', 'Sioux Falls', 'SD', 'USA', 57106, 8675309, 'siouxfallsffice@goodexcuse.org'),
	('4141 Grand Street', 'Salem', 'GA', 'USA', 31016, 8675309, 'salemoffice@goodexcuse.org'),
	('5151 Millionare Blvd', 'Clarksville', 'TN', 'USA', 37042, 8675309, 'clarksvilleoffice@goodexcuse.org'),
	('6161 Investment Way', 'Kansas City', 'KS', 'USA', 64111, 8675309, 'kansascityoffice@goodexcuse.org'),
	('7171 Loot Lane', 'Naperville', 'IL', 'USA', 60490, 8675309, 'napervilleoffice@goodexcuse.org'),
	('8181 Wad Way', 'Paterson', 'NJ', 'USA', 07510, 8675309, 'patersonoffice@goodexcuse.org'),
	('9191 Singles St', 'Miramar', 'FL', 'USA', 33025, 8675309, 'miramaoffice@goodexcuse.org'),
	('1010 Nickel Drive', 'West Valley', 'UT', 'USA', 84119, 8675309, 'westvalleyoffice@goodexcuse.org'),
	('11 Coin Circle', 'Columbia', 'SC', 'USA', 29202, 8675309, 'columbiaoffice@goodexcuse.org'),
	('1212 Dime Drive', 'Lafayette', 'LA', 'USA', 70505, 8675309, 'lafayetteoffice@goodexcuse.org'),
	('1313 Bucks Way', 'Ann Arbor', 'MI', 'USA', 48107, 8675309, 'annarboroffice@goodexcuse.org'),
	('1414 Benjamin Blvd', 'Cambridge', 'MA', 'USA', 02140, 8675309, 'cambridgeoffice@goodexcuse.org'),
	('1515 Dough St', 'West Jordan', 'UT', 'USA', 84084, 8675309, 'westjordanoffice@goodexcuse.org'),
	('1616 Cheddar Circle', 'Elgin', 'IL', 'USA', 60170, 8675309, 'elginoffice@goodexcuse.org'),
	('1717 Bill Bay', 'Billings', 'MT', 'USA', 59103, 8675309, 'billingsoffice@goodexcuse.org'),
	('1818 Moola Rd', 'Tyler', 'TX', 'USA', 75711, 8675309, 'tyleroffice@goodexcuse.org'),
	('1919 Scratch St', 'Lakewood', 'NJ', 'USA', 80235, 8675309, 'lakewoodoffice@goodexcuse.org'),
	('2020 Large Lane', 'Tuscaloosa', 'AL', 'USA', 35452, 8675309, 'tuscaloosaoffice@goodexcuse.org')

-- Customers; Salt prevents dictionary attacks
DECLARE @Salt as UNIQUEIDENTIFIER=NEWID()
INSERT INTO tblCustomers VALUES ('billyjoe',  HASHBYTES('SHA2_512', 'Password1'+CAST(@Salt as NVARCHAR(40))), @Salt, 'Billy', 'John', 'Joe', 'M', '1950-12-01', 1)
SET @Salt=NEWID()
INSERT INTO tblCustomers VALUES ('frankshotdogs22',  HASHBYTES('SHA2_512', 'Password2'+CAST(@Salt as NVARCHAR(40))), @Salt, 'Frank', 'Alan', 'Crow', 'M', '1940-03-12', 2)
SET @Salt=NEWID()
INSERT INTO tblCustomers VALUES ('hitchhikerguidetothegalaxy',  HASHBYTES('SHA2_512', 'Password3'+CAST(@Salt as NVARCHAR(40))), @Salt, 'Haggunenon', 'Underfleet', 'Commander', 'M', '1960-06-24', 3)
SET @Salt=NEWID()
INSERT INTO tblCustomers VALUES ('jeffgordonrules',  HASHBYTES('SHA2_512', 'Password4'+CAST(@Salt as NVARCHAR(40))), @Salt, 'Jeff', 'Michael', 'Gordon', 'M', '1971-08-04', 4)
SET @Salt=NEWID()
INSERT INTO tblCustomers VALUES ('testdummy',  HASHBYTES('SHA2_512', 'Password5'+CAST(@Salt as NVARCHAR(40))), @Salt, 'Test', 'The', 'Dummy', 'M', '1999-09-09', 5)
SET @Salt=NEWID()
INSERT INTO tblCustomers VALUES ('devilsadvocate',  HASHBYTES('SHA2_512', 'Password6'+CAST(@Salt as NVARCHAR(40))), @Salt, 'Thomas', 'John', 'Ellis', 'M', '1978-11-17', 6)
SET @Salt=NEWID()
INSERT INTO tblCustomers VALUES ('sesamestreetcount',  HASHBYTES('SHA2_512', 'Password7'+CAST(@Salt as NVARCHAR(40))), @Salt, 'Count', 'Von', 'Count', 'M', '1972-01-31', 7)
SET @Salt=NEWID()
INSERT INTO tblCustomers VALUES ('sliceofpi',  HASHBYTES('SHA2_512', 'Password8'+CAST(@Salt as NVARCHAR(40))), @Salt, 'William', '', 'Jones', 'M', '1675-01-01', 8)
SET @Salt=NEWID()
INSERT INTO tblCustomers VALUES ('propbablymyimagination',  HASHBYTES('SHA2_512', 'Password9'+CAST(@Salt as NVARCHAR(40))), @Salt, 'Arthur', 'Herbert', 'Fonzarelli', 'M', '1974-02-28', 9)
SET @Salt=NEWID()
INSERT INTO tblCustomers VALUES ('goRaiders',  HASHBYTES('SHA2_512', 'Password10'+CAST(@Salt as NVARCHAR(40))), @Salt, 'Kenneth', 'Michael', 'Stabler', 'M', '1945-12-25', 10)
SET @Salt=NEWID()
INSERT INTO tblCustomers VALUES ('911Inventor',  HASHBYTES('SHA2_512', 'Password11'+CAST(@Salt as NVARCHAR(40))), @Salt, 'Ernest', 'Rankin', 'Fite', 'M', '1916-09-01', 11)
SET @Salt=NEWID()
INSERT INTO tblCustomers VALUES ('witchway',  HASHBYTES('SHA2_512', 'Password12'+CAST(@Salt as NVARCHAR(40))), @Salt, 'Sybil', '', 'Leek', 'F', '1917-02-22', 12)
SET @Salt=NEWID()
INSERT INTO tblCustomers VALUES ('computerinventor',  HASHBYTES('SHA2_512', 'Password13'+CAST(@Salt as NVARCHAR(40))), @Salt, 'Charles', '', 'Babbage', 'M', '1791-12-26', 13)
SET @Salt=NEWID()
INSERT INTO tblCustomers VALUES ('WhyisThereSoMany',  HASHBYTES('SHA2_512', 'Password14'+CAST(@Salt as NVARCHAR(40))), @Salt, 'Stephanie', 'Lynn', 'Smith', 'F', '1992-02-28', 14)
SET @Salt=NEWID()
INSERT INTO tblCustomers VALUES ('OrangeisthenewBlack',  HASHBYTES('SHA2_512', 'Password15'+CAST(@Salt as NVARCHAR(40))), @Salt, 'Donald', 'John', 'Trump', 'M', '1946-06-14', 15)
SET @Salt=NEWID()
INSERT INTO tblCustomers VALUES ('cokezerosugar',  HASHBYTES('SHA2_512', 'Password16'+CAST(@Salt as NVARCHAR(40))), @Salt, 'John', 'Stith', 'Pemberton', 'M', '1831-07-08', 16)
SET @Salt=NEWID()
INSERT INTO tblCustomers VALUES ('newgenerationschoice',  HASHBYTES('SHA2_512', 'Password17'+CAST(@Salt as NVARCHAR(40))), @Salt, 'Caleb', 'Davis', 'Bradham', 'M', '1867-05-27', 17)
SET @Salt=NEWID()
INSERT INTO tblCustomers VALUES ('tasteof23flavors',  HASHBYTES('SHA2_512', 'Password18'+CAST(@Salt as NVARCHAR(40))), @Salt, 'Charles', 'Courtice', 'Alderton', 'M', '1857-06-21', 18)
SET @Salt=NEWID()
INSERT INTO tblCustomers VALUES ('sligon',  HASHBYTES('SHA2_512', 'Password19'+CAST(@Salt as NVARCHAR(40))), @Salt, 'Sami', 'Lee', 'Ligon', 'F', '1971-11-22', 19)
SET @Salt=NEWID()
INSERT INTO tblCustomers VALUES ('oprahprime',  HASHBYTES('SHA2_512', 'Password20'+CAST(@Salt as NVARCHAR(40))), @Salt, 'Oprah', 'Gail', 'Winfrey', 'F', '1954-01-29', 20)

-- Store 
INSERT INTO tblStore VALUES 
	('YNY', 21),
	('TAZ', 22),
	('SFSD', 23),
	('SGA', 24),
	('CTN', 25),
	('KCKS', 26),
	('NIL', 27),
	('PNJ', 28),
	('MFL', 29),
	('WVUT', 30),
	('CSC', 31),
	('LLA', 32),
	('AAMI', 33),
	('CMA', 34),
	('WJUT', 35),
	('EIL', 36),
	('BMT', 37),
	('TTX', 38),
	('LNJ', 39),
	('TAL', 40)

-- Products
INSERT INTO tblProducts VALUES 
	(3471736197, 1, 'Boshel', 'Dog Nail Clipper and Trimmer', 10.99, 13.99, '', 'Pets', 'Dogs', 'RECOMMENDED BY PROFESSIONALS', 2000, 248),
	(5570762561, 2, 'Evagloss', 'Wart Remover Max Strength', 16.90, 19.99, '', 'Health', 'Warts', 'MAXIMUM STRENGTH WART REMOVER', 1500, 421),
	(5535129885, 3, 'Apeman', 'Dash Cam 1080P HD', 31.99, 39.99, '', 'Car', 'Accessories', '1080P FULL HD DASH CAM W/ SUPER WIDE ANGLE', 1000, 113),
	(5653348831, 4, 'Sampeel', 'Basic V Neck Short Sleeve', 18.69, 19.99, 'F', 'Clothing', 'Shirt', 'Unique design casual v neck t-shirt', 3000, 463),
	(2941021105, 5, 'Sidefeel', 'Hooded Knit Cardigans Button Sweater', 45.59, 49.99, 'F', 'Clothing', 'Sweater', 'Gorgeous cable knit sweater', 1250, 106),
	(4427328441, 6, 'Leviot', 'Vista 200 Air Purifier', 68.99, 79.99, '', 'Health', 'Purifier', '3 Stage Filtration, Sleep Mode, and Night Light!', 1300, 211),
	(4885948640, 7, 'AstroAI', 'Gitial Multimeter', 30.99, 39.99, '', 'Electrical', 'Multimeter', 'Professional level features', 800, 108),
	(6194223689, 8, 'Deblano', 'Infant Toddler Bowknot Moccasinss Shoes', 13.99, 15.99, 'B', 'Clothing', 'Infants', 'Soft material', 925, 214),
	(5010250627, 9, 'Grace Karin', 'Women 3/4 Sleeve Formal Cocktail Dress', 32.99, 39.99, 'F', 'Clothing', 'Dress', 'Zipper Closure, Kneee Length', 950, 320),
	(7461935940, 10, 'Perlesmith', 'TV Wall Mount for 26-55" TV', 16.99, 19.99, '', 'Furniture', 'Wall Mount', 'Universal design fits most 26-55 inch TVs', 466, 50),
	(6654600624, 11, 'Simari', 'WeightLifting Workout Gloves', 16.98, 19.99, 'B', 'Fitness', 'Gloves', 'Protects your hands fully', 951, 215),
	(7933518575, 12, 'Fabula', '22lb Weighted Blanket', 56.94, 59.99, 'B', 'Bedding', 'Blanket', 'Designed for comfortable sleep', 460, 80),
	(0883229253, 13, 'JTech', 'Apple IPhone 6 Case', 6.79, 9.99, '', 'Technology', 'Phone Case', 'Shock-absorbant design', 150, 35),
	(6192410840, 14, 'Marinos', 'Funky Colorful Dress Socks', 30.59, 34.99, 'M', 'Clothing', 'Socks', 'Moisture Control, Maximum durability', 726, 301),
	(6782605612, 15, 'Monily', '18K Gold Plated Necklace', 7.80, 9.99, 'B', 'Jewelry', 'Necklace', 'Many Sizes Available!', 425, 123),
	(0525938268, 16, 'Levis', '505 Refular Fit Jeans', 59.50, 64.99, 'M', 'Clothing', 'Pants', 'Original Levis Jeans', 600, 400),
	(5014696773, 17, 'Ruring', 'High Waist Yoga Pants', 15.99, 19.99, 'F', 'Clothing', 'Pants', 'Non see-through, moisture-wicking', 942, 600),
	(7965680171, 18, 'Kaliyadi', 'Polarized Sunglasses', 16.99, 19.99, 'B', 'Accessories', 'Sunglasses', 'Protect your eyes with style!', 567, 128),
	(7704939839, 19, 'Bird & Blooms', 'Print Magazine', 5.00, 6.99, '', 'Magazine', 'Nature', 'Read about the worlds birds and flowers!', 400, 300),
	(4027221796, 20, 'Fabio Valenti', 'Genuine Leather Belt', 20.99, 24.99, 'M', 'Accessories', 'Belts', '100% pure genuine leather belt', 800, 352)

-- Orders; Order generates a new GUID every order for easy tracking of a single set of purchases.
DECLARE @OrderIDTemp as UNIQUEIDENTIFIER=NEWID()
INSERT INTO tblOrders VALUES
	(@OrderIDTemp, 4, 6, 3471736197, 2, 'Physical', 'Credit', '2019-09-21', 27.98, 1.95, 54.80),
	(@OrderIDTemp, 4, 6, 6654600624, 1, 'Physical', 'Credit', '2019-09-21', 19.99, 1.39, 21.38),
	(@OrderIDTemp, 4, 6, 7965680171, 1, 'Physical', 'Credit', '2019-09-21', 19.99, 1.39, 21.38)
SET @OrderIDTemp=NEWID()
INSERT INTO tblOrders VALUES 
	(@OrderIDTemp, 8, 2, 7965680171, 1, 'Physical', 'Credit', '2019-08-22', $19.99, $1.39, $21.38)
SET @OrderIDTemp=NEWID()
INSERT INTO tblOrders VALUES 
	(@OrderIDTemp, 15, 9, 7933518575, 1, 'Virtual', 'Credit', '2019-06-23', 59.99, 4.19, 64.18),
	(@OrderIDTemp, 15, 9, 0525938268, 3, 'Virtual', 'Credit', '2019-06-23', 194.97, 13.64, 208.61)
SET @OrderIDTemp=NEWID()
INSERT INTO tblOrders VALUES 
	(@OrderIDTemp, 3, 18, 4027221796, 1, 'Physical', 'Cash', '2017-04-24', 24.99, 1.74, 26.73),
	(@OrderIDTemp, 3, 18, 6782605612, 2, 'Physical', 'Cash', '2017-04-24', 19.98, 1.39, 21.37),
	(@OrderIDTemp, 3, 18, 5010250627, 1, 'Physical', 'Cash', '2017-04-24', 39.99, 2.79, 42.78),
	(@OrderIDTemp, 3, 18, 7461935940, 1, 'Physical', 'Cash', '2017-04-24', 19.99, 1.39, 21.38),
	(@OrderIDTemp, 3, 18, 2941021105, 1, 'Physical', 'Cash', '2017-04-24', 49.99, 3.49, 53.48)
SET @OrderIDTemp=NEWID()
INSERT INTO tblOrders VALUES 
	(@OrderIDTemp, 12, 12, 7461935940, 1, 'Physical', 'Credit', '2019-02-25', 19.99, 1.39, 21.38)
SET @OrderIDTemp=NEWID()
INSERT INTO tblOrders VALUES 
	(@OrderIDTemp, 14, 12, 5014696773, 1, 'Physical', 'Cash', '2019-01-26', 19.99, 1.39, 21.38)
SET @OrderIDTemp=NEWID()
INSERT INTO tblOrders VALUES 
	(@OrderIDTemp, 19, 1, 4885948640, 1, 'Virtual', 'Credit', '2019-11-27', 39.99, 2.79, 42.78)
SET @OrderIDTemp=NEWID()
INSERT INTO tblOrders VALUES 
	(@OrderIDTemp, 6, 16, 6654600624, 1, 'Virtual', 'Credit', '2019-06-28', 19.99, 1.39, 21.38),
	(@OrderIDTemp, 6, 16, 6194223689, 1, 'Virtual', 'Credit', '2019-06-28', 15.99, 1.11, 17.10),
	(@OrderIDTemp, 6, 16, 6192410840, 1, 'Virtual', 'Credit', '2019-06-28', 34.99, 2.44, 37.43)
SET @OrderIDTemp=NEWID()
INSERT INTO tblOrders VALUES 
	(@OrderIDTemp, 4, 15, 0883229253, 1, 'Physical', 'Credit', '2019-12-22', 9.99, 0.69, 10.68)
SET @OrderIDTemp=NEWID()
INSERT INTO tblOrders VALUES 
	(@OrderIDTemp, 19, 10, 7704939839, 1, 'Virtual', 'Credit', '2019-03-23', 6.99, 0.48, 7.47),
	(@OrderIDTemp, 19, 10, 5570762561, 1, 'Virtual', 'Credit', '2019-03-23', 19.99, 1.39, 21.38)