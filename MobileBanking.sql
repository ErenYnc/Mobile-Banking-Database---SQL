-- Online Mobile Banking Database Project

-- Step 1: Create Database
CREATE DATABASE OnlineMobileBanking;
USE OnlineMobileBanking;

-- Step 2: Create Tables

CREATE TABLE Cus_Address (
    AddressID INT PRIMARY KEY,
    Country VARCHAR(20) NOT NULL,
    City VARCHAR(20) NOT NULL,
    Street VARCHAR(50) NOT NULL,
    Zip_Code SMALLINT NOT NULL
);

CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    FName VARCHAR(20) NOT NULL,
    LName VARCHAR(20) NOT NULL,
    PhoneNum CHAR(11) UNIQUE,
    AddressID INT,
    FOREIGN KEY (AddressID) REFERENCES Cus_Address(AddressID)
);

CREATE TABLE Deposit_Account (
    DepositAccount_ID INT PRIMARY KEY,
    CustomerID INT,
    Currency_Type VARCHAR(20),
    Balance MONEY DEFAULT 0,
    Interest_Rate SMALLINT CHECK (Interest_Rate BETWEEN 0 AND 100),
    Maturity_Date DATE NOT NULL,
    Status_ CHAR(1) CHECK (Status_ IN ('Y', 'N')),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

CREATE TABLE Deposit_Transaction (
    DepositTransaction_ID INT PRIMARY KEY,
    DepositAccount_ID INT,
    Transaction_Type VARCHAR(20) NOT NULL,
    Amount MONEY NOT NULL,
    Transaction_Date DATETIME NOT NULL,
    Description_ VARCHAR(100),
    FOREIGN KEY (DepositAccount_ID) REFERENCES Deposit_Account(DepositAccount_ID)
);

CREATE TABLE Loan_Application (
    LoanApp_ID INT PRIMARY KEY,
    CustomerID INT,
    Loan_Type VARCHAR(20) NOT NULL,
    Amount_Request MONEY NOT NULL,
    App_Date DATE NOT NULL,
    Status_ CHAR(1) CHECK (Status_ IN ('Y', 'N')),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

CREATE TABLE Loan (
    Loan_ID INT PRIMARY KEY,
    LoanApp_ID INT,
    Interest_Rate SMALLINT CHECK (Interest_Rate BETWEEN 0 AND 100),
    Loan_term SMALLINT NOT NULL,
    Monthly_Payment MONEY,
    StartDate DATE,
    EndDate DATE,
    Status_ CHAR(1) CHECK (Status_ IN ('Y', 'N')),
    FOREIGN KEY (LoanApp_ID) REFERENCES Loan_Application(LoanApp_ID)
);

CREATE TABLE Credit_Card (
    Card_No BIGINT PRIMARY KEY,
    CustomerID INT,
    Card_Type VARCHAR(15) NOT NULL,
    Expration_Date DATE NOT NULL,
    CVV CHAR(3) NOT NULL,
    Credit_Limit MONEY,
    Minimum_Payment MONEY,
    Interest_Rate SMALLINT CHECK (Interest_Rate BETWEEN 0 AND 100),
    Status_ CHAR(1) CHECK (Status_ IN ('Y', 'N')),
    Billing_Cycle VARCHAR(10) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

CREATE TABLE BankAccount (
    BankAccount_ID INT PRIMARY KEY,
    CustomerID INT,
    Account_Type VARCHAR(50),
    Balance MONEY DEFAULT 0,
    Open_Date DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

CREATE TABLE Transaction_ (
    Transaction_ID INT PRIMARY KEY,
    BankAccount_ID INT,
    Transaction_Type VARCHAR(15),
    Amount MONEY NOT NULL,
    Transaction_Date DATETIME,
    From_Currency VARCHAR(50) NOT NULL,
    To_Currency VARCHAR(50) NOT NULL,
    FOREIGN KEY (BankAccount_ID) REFERENCES BankAccount(BankAccount_ID)
);

CREATE TABLE DebitCard (
    Card_No CHAR(16) PRIMARY KEY,
    BankAccount_ID INT,
    Card_Type VARCHAR(50) NOT NULL,
    Expration_Date DATE NOT NULL,
    CVV CHAR(3) NOT NULL,
    FOREIGN KEY (BankAccount_ID) REFERENCES BankAccount(BankAccount_ID)
);

CREATE TABLE StockAccount (
    StockAccount_ID INT PRIMARY KEY,
    CustomerID INT,
    Balance MONEY DEFAULT 0,
    Open_Date DATE,
    Status_ CHAR(1) CHECK (Status_ IN ('Y', 'N')),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

CREATE TABLE Stock_Transaction (
    StockTransaction_ID INT PRIMARY KEY,
    StockAccount_ID INT,
    Stock_Symbol VARCHAR(5) NOT NULL,
    Transaction_Type VARCHAR(50),
    ShareAmount INT NOT NULL,
    PricePer_Share MONEY DEFAULT 0,
    Transaction_Date DATETIME NOT NULL,
    FOREIGN KEY (StockAccount_ID) REFERENCES StockAccount(StockAccount_ID)
);


-- Step 3: Insert Sample Data

INSERT INTO Cus_Address (AddressID, Country, City, Street, Zip_Code) VALUES
(1, 'Türkiye', 'Ýstanbul', 'Yýlmaz Caddesi', 34000),
(2, 'Türkiye', 'Malatya', 'Aslaner Caddesi', 44000),
(3, 'Türkiye', 'Konya', 'Kocaþahin Caddesi', 42000),
(4, 'Türkiye', 'Giresun', 'Yenice Caddesi', 28000),
(5, 'Türkiye', 'Ýstanbul', 'Esenler', 34000);

INSERT INTO Customer (CustomerID, FName, LName, PhoneNum, AddressID) VALUES
(1, 'Volkan', 'Yýlmaz', '05538575100', 1),
(2, 'Eren', 'Yenice', '05396244134', 2),
(3, 'Ömer', 'Aslaner', '05511358643', 3),
(4, 'Muhammed', 'Kocaþahin', '05350149876', 4),
(5, 'Mustafa', 'Kocaþahin', '05361234571', 5);

INSERT INTO Deposit_Account (DepositAccount_ID, CustomerID, Currency_Type, Balance, Interest_Rate, Maturity_Date, Status_) VALUES
(1, 1, 'TRY', 10000, 15, '2025-12-31', 'Y'),
(2, 2, 'USD', 5000, 10, '2026-05-20', 'Y'),
(3, 3, 'EUR', 8000, 12, '2028-02-10', 'N'),
(4, 4, 'TRY', 15000, 20, '2027-11-15', 'Y'),
(5, 5, 'USD', 20000, 18, '2026-08-30', 'N');

INSERT INTO Deposit_Transaction (DepositTransaction_ID, DepositAccount_ID, Transaction_Type, Amount, Transaction_Date, Description_) VALUES
(1, 1, 'Para Yatýrma', 5000, '2025-01-10', 'Yatýrým amaçlý para yatýrýldý'),
(2, 2, 'Para Çekme', 1000, '2025-01-12', 'Ödeme için para çekildi'),
(3, 3, 'Para Yatýrma', 2000, '2025-01-13', 'Kampanya için ek yatýrýldý'),
(4, 4, 'Para Çekme', 3000, '2025-01-14', 'Acil nakit çekiþ'),
(5, 5, 'Para Yatýrma', 10000, '2025-01-15', 'Yüksek faizli mevduat yatýrýldý');

INSERT INTO Loan_Application (LoanApp_ID, CustomerID, Loan_Type, Amount_Request, App_Date, Status_) VALUES
(1, 1, 'Ýhtiyaç Kredisi', 50000, '2025-01-01', 'Y'),
(2, 2, 'Konut Kredisi', 200000, '2025-01-05', 'N'),
(3, 3, 'Taþýt Kredisi', 100000, '2025-01-10', 'Y'),
(4, 4, 'Ýhtiyaç Kredisi', 25000, '2025-01-12', 'Y'),
(5, 5, 'Konut Kredisi', 300000, '2025-01-15', 'N');

INSERT INTO Loan (Loan_ID, LoanApp_ID, Interest_Rate, Loan_term, Monthly_Payment, StartDate, EndDate, Status_) VALUES
(1, 1, 18, 24, 2500, '2025-02-01', '2027-02-01', 'Y'),
(2, 3, 15, 36, 3000, '2025-02-10', '2028-02-10', 'Y'),
(3, 4, 20, 12, 2200, '2025-02-15', '2026-02-15', 'Y'),
(4, 5, 22, 60, 4000, '2025-03-01', '2030-03-01', 'N'),
(5, 2, 10, 48, 1800, '2025-03-05', '2029-03-05', 'N');

INSERT INTO Credit_Card (Card_No, CustomerID, Card_Type, Expration_Date, CVV, Credit_Limit, Minimum_Payment, Interest_Rate, Status_, Billing_Cycle) VALUES
(1234567890123456, 1, 'Visa', '2028-12-31', '123', 20000, 1000, 15, 'Y', 'Aylýk'),
(2345678901234567, 2, 'MasterCard', '2027-11-30', '234', 15000, 800, 18, 'Y', 'Aylýk'),
(3456789012345678, 3, 'American Express', '2029-02-28', '345', 25000, 1200, 12, 'N', 'Aylýk'),
(4567890123456789, 4, 'Discover', '2026-03-31', '456', 30000, 1500, 10, 'Y', 'Aylýk'),
(5678901234567890, 5, 'Visa', '2028-07-31', '567', 50000, 2500, 20, 'N', 'Aylýk');

INSERT INTO BankAccount (BankAccount_ID, CustomerID, Account_Type, Balance, Open_Date) VALUES
(1, 1, 'Vadesiz Hesap', 5000, '2025-01-01'),
(2, 2, 'Vadesiz Hesap', 2000, '2025-01-05'),
(3, 3, 'Vadesiz Hesap', 3000, '2025-01-10'),
(4, 4, 'Vadesiz Hesap', 4000, '2025-01-12'),
(5, 5, 'Vadesiz Hesap', 1500, '2025-01-15');

INSERT INTO Transaction_ (Transaction_ID, BankAccount_ID, Transaction_Type, Amount, Transaction_Date, From_Currency, To_Currency) VALUES
(1, 1, 'Para Yatýrma', 1000, '2025-01-02', 'TRY', 'TRY'),
(2, 2, 'Para Çekme', 500, '2025-01-06', 'TRY', 'TRY'),
(3, 3, 'Para Yatýrma', 2000, '2025-01-11', 'TRY', 'TRY'),
(4, 4, 'Para Çekme', 1500, '2025-01-13', 'TRY', 'TRY'),
(5, 5, 'Para Yatýrma', 500, '2025-01-16', 'TRY', 'TRY');

INSERT INTO DebitCard (Card_No, BankAccount_ID, Card_Type, Expration_Date, CVV) VALUES
('4361736812729124', 1, 'MasterCard', '2027-12-31', '123'),
('8571821731283188', 2, 'Visa', '2026-11-30', '234'),
('2345678934562532', 3, 'Maestro', '2028-09-30', '345'),
('9876545678987657', 4, 'Discover', '2025-10-31', '456'),
('2345665432567876', 5, 'MasterCard', '2029-03-31', '567');

INSERT INTO StockAccount (StockAccount_ID, CustomerID, Balance, Open_Date, Status_) VALUES
(1, 1, 10500, '2025-01-02', 'Y'),
(2, 2, 21000, '2025-01-06', 'Y'),
(3, 3, 15900, '2025-01-11', 'N'),
(4, 4, 50911, '2025-01-13', 'Y'),
(5, 5, 25432, '2025-01-16', 'N');

INSERT INTO Stock_Transaction (StockTransaction_ID, StockAccount_ID, Stock_Symbol, Transaction_Type, ShareAmount, PricePer_Share, Transaction_Date) VALUES
(1, 1, 'AAPL', 'Alýþ', 10, 1500, '2025-01-03'),
(2, 2, 'GOOG', 'Satýþ', 5, 2000, '2025-01-07'),
(3, 3, 'TSLA', 'Alýþ', 15, 700, '2025-01-12'),
(4, 4, 'MSFT', 'Satýþ', 20, 2500, '2025-01-14'),
(5, 5, 'AMZN', 'Alýþ', 8, 3000, '2025-01-17');

-- Step 4: Example Queries

SELECT c.CustomerID, c.FName, c.LName, ca.Country, ca.City
FROM Customer c
JOIN Cus_Address ca ON c.AddressID = ca.AddressID;

SELECT c.CustomerID, c.FName, c.LName, da.DepositAccount_ID, da.Balance
FROM Deposit_Account da
JOIN Customer c ON da.CustomerID = c.CustomerID;

SELECT da.DepositAccount_ID, dt.Transaction_Type, dt.Amount, dt.Transaction_Date
FROM Deposit_Account da
JOIN Deposit_Transaction dt ON da.DepositAccount_ID = dt.DepositAccount_ID;

SELECT l.Loan_ID, la.Loan_Type, la.Amount_Request, l.Interest_Rate, l.Monthly_Payment
FROM Loan l
JOIN Loan_Application la ON l.LoanApp_ID = la.LoanApp_ID;

SELECT c.CustomerID, c.FName, c.LName, cc.Card_No, cc.Card_Type, ba.Account_Type
FROM Customer c
JOIN Credit_Card cc ON c.CustomerID = cc.CustomerID
JOIN BankAccount ba ON c.CustomerID = ba.CustomerID;

SELECT c.CustomerID, c.FName, c.LName, SUM(da.Balance) AS Total_Balance
FROM Customer c
JOIN Deposit_Account da ON c.CustomerID = da.CustomerID
GROUP BY c.CustomerID, c.FName, c.LName
HAVING SUM(da.Balance) > 10000;

SELECT CustomerID, FName, LName
FROM Customer
WHERE EXISTS (SELECT 1 FROM Credit_Card WHERE CustomerID = Customer.CustomerID);

SELECT c.CustomerID, c.FName, c.LName, cc.Card_Type
FROM Customer c
JOIN Credit_Card cc ON c.CustomerID = cc.CustomerID
WHERE cc.Card_Type IN ('Visa', 'MasterCard');

SELECT cc.Card_Type, SUM(ba.Balance) AS Total_Balance
FROM BankAccount ba
JOIN Customer c ON ba.CustomerID = c.CustomerID
JOIN Credit_Card cc ON c.CustomerID = cc.CustomerID
GROUP BY cc.Card_Type;

SELECT c.CustomerID, c.FName, c.LName
FROM Customer c
JOIN BankAccount ba ON c.CustomerID = ba.CustomerID
INTERSECT
SELECT c.CustomerID, c.FName, c.LName
FROM Customer c
JOIN Credit_Card cc ON c.CustomerID = cc.CustomerID;

SELECT c.CustomerID, c.FName, c.LName
FROM Customer c
JOIN Credit_Card cc ON c.CustomerID = cc.CustomerID
EXCEPT
SELECT c.CustomerID, c.FName, c.LName
FROM Customer c
JOIN BankAccount ba ON c.CustomerID = ba.CustomerID;

SELECT sa.StockAccount_ID, st.Stock_Symbol, st.Transaction_Type, st.ShareAmount, st.PricePer_Share
FROM StockAccount sa
INNER JOIN Stock_Transaction st ON sa.StockAccount_ID = st.StockAccount_ID
WHERE st.Transaction_Type = 'Alýþ';

SELECT la.LoanApp_ID, la.Loan_Type, la.Amount_Request, la.App_Date
FROM Loan l
INNER JOIN Loan_Application la ON l.LoanApp_ID = la.LoanApp_ID
WHERE l.Status_ = 'Y';

SELECT c.CustomerID, c.FName, c.LName, SUM(ba.Balance) AS Total_Balance
FROM Customer c
INNER JOIN BankAccount ba ON c.CustomerID = ba.CustomerID
GROUP BY c.CustomerID, c.FName, c.LName;

SELECT cc.Card_Type, COUNT(*) AS Number_of_Cards
FROM Credit_Card cc
GROUP BY cc.Card_Type;

SELECT c.CustomerID, c.FName, c.LName, AVG(ba.Balance) AS Avg_Balance
FROM Customer c
INNER JOIN BankAccount ba ON c.CustomerID = ba.CustomerID
GROUP BY c.CustomerID, c.FName, c.LName;

SELECT MAX(da.Balance) AS Max_Balance
FROM Deposit_Account da;

SELECT MIN(cc.Credit_Limit) AS Min_Credit_Limit
FROM Credit_Card cc;

SELECT c.CustomerID, c.FName, c.LName, ba.Balance
FROM Customer c
LEFT JOIN BankAccount ba ON c.CustomerID = ba.CustomerID;

SELECT c.CustomerID, c.FName, c.LName, cc.Card_No
FROM Customer c
RIGHT JOIN Credit_Card cc ON c.CustomerID = cc.CustomerID;

SELECT cc.Card_Type, AVG(cc.Interest_Rate) AS Avg_Interest_Rate
FROM Credit_Card cc
GROUP BY cc.Card_Type;

SELECT c.CustomerID, c.FName, c.LName
FROM Customer c
INNER JOIN Credit_Card cc ON c.CustomerID = cc.CustomerID
WHERE cc.Card_No IN (1234567890123456, 2345678901234567);

SELECT c.CustomerID, c.FName, c.LName, COUNT(cc.Card_No) AS Card_Count
FROM Customer c
INNER JOIN Credit_Card cc ON c.CustomerID = cc.CustomerID
GROUP BY c.CustomerID, c.FName, c.LName
HAVING COUNT(cc.Card_No) > 2;

SELECT sa.StockAccount_ID, COUNT(st.StockTransaction_ID) AS Total_Transactions
FROM StockAccount sa
INNER JOIN Stock_Transaction st ON sa.StockAccount_ID = st.StockAccount_ID
GROUP BY sa.StockAccount_ID;

SELECT c.CustomerID, c.FName, c.LName
FROM Customer c
WHERE NOT EXISTS (SELECT 1 FROM Credit_Card cc WHERE cc.CustomerID = c.CustomerID);

SELECT c.CustomerID, c.FName, c.LName, SUM(da.Balance) AS Total_Balance
FROM Customer c
INNER JOIN Deposit_Account da ON c.CustomerID = da.CustomerID
GROUP BY c.CustomerID, c.FName, c.LName
HAVING SUM(da.Balance) > 10000;

SELECT ba.BankAccount_ID, cc.Card_No, ba.Balance
FROM BankAccount ba
LEFT JOIN Credit_Card cc ON ba.CustomerID = cc.CustomerID;

SELECT CustomerID, FName, LName
FROM Customer
WHERE FName LIKE 'A%';

SELECT c.CustomerID, c.FName, c.LName, SUM(dt.Amount) AS TotalDeposit
FROM Deposit_Transaction dt
JOIN Deposit_Account da ON dt.DepositAccount_ID = da.DepositAccount_ID
JOIN Customer c ON da.CustomerID = c.CustomerID
GROUP BY c.CustomerID, c.FName, c.LName;

SELECT c.CustomerID, c.FName, c.LName, la.Loan_Type, la.Amount_Request, la.Status_
FROM Loan_Application la
JOIN Customer c ON la.CustomerID = c.CustomerID
WHERE la.Status_ = 'Y';

-- Step 5: Updates and Deletes

UPDATE Customer 
SET PhoneNum = '5559876543' 
WHERE CustomerID = 3;

UPDATE BankAccount 
SET Balance = 2000.00 
WHERE BankAccount_ID = 1;

UPDATE Credit_Card 
SET Interest_Rate = 15 
WHERE Card_No = 2345678901234567;

UPDATE StockAccount 
SET Balance = 12000.00 
WHERE StockAccount_ID = 5;

UPDATE Deposit_Account 
SET Interest_Rate = 6 
WHERE DepositAccount_ID = 1;

DELETE FROM Customer 
WHERE CustomerID = 4;

DELETE FROM BankAccount 
WHERE BankAccount_ID = 2;

DELETE FROM Credit_Card 
WHERE Card_No = 2345678901234567;

DELETE FROM StockAccount 
WHERE StockAccount_ID = 2;

DELETE FROM Deposit_Account 
WHERE DepositAccount_ID = 3;

-- Step 6: Alter and Drop

ALTER TABLE BankAccount 
ADD Account_Status VARCHAR(20) DEFAULT 'Active';

ALTER TABLE Customer 
ALTER COLUMN PhoneNum CHAR(15);

ALTER TABLE Credit_Card 
ADD Billing_Cycle VARCHAR(10) NOT NULL;

ALTER TABLE Deposit_Account 
ADD Account_Type VARCHAR(50);

ALTER TABLE Loan 
DROP COLUMN StartDate;

DROP TABLE Deposit_Transaction;
DROP TABLE Credit_Card;
DROP TABLE Transaction_;
DROP TABLE DebitCard;
DROP TABLE Loan_Application;

-- Step 7: Views

CREATE VIEW CustomerWithAddress AS 
SELECT c.CustomerID, c.FName, c.LName, ca.Country, ca.City, ca.Street, ca.Zip_Code 
FROM Customer c 
JOIN Cus_Address ca ON c.AddressID = ca.AddressID;
GO

CREATE VIEW ActiveLoans AS 
SELECT c.CustomerID, c.FName, c.LName, la.Loan_Type, la.Amount_Request, la.App_Date, la.Status_ 
FROM Loan_Application la 
JOIN Customer c ON la.CustomerID = c.CustomerID 
WHERE la.Status_ = 'Y';
GO

CREATE VIEW DepositAccountSummary AS 
SELECT c.CustomerID, c.FName, c.LName, da.DepositAccount_ID, da.Currency_Type, da.Balance, da.Interest_Rate 
FROM Deposit_Account da 
JOIN Customer c ON da.CustomerID = c.CustomerID;
GO

CREATE VIEW BankTransactionSummary AS 
SELECT ba.CustomerID, ba.BankAccount_ID, bt.Transaction_Type, bt.Amount, bt.Transaction_Date 
FROM Transaction_ bt 
JOIN BankAccount ba ON bt.BankAccount_ID = ba.BankAccount_ID;
GO

CREATE VIEW CreditCardDetails AS 
SELECT c.CustomerID, c.FName, c.LName, cc.Card_No, cc.Card_Type, cc.Credit_Limit, cc.Status_ 
FROM Credit_Card cc 
JOIN Customer c ON cc.CustomerID = c.CustomerID;
GO

CREATE VIEW LoanPaymentStatus AS 
SELECT l.Loan_ID, l.Loan_term, l.Monthly_Payment, l.StartDate, l.EndDate, la.Status_ 
FROM Loan l 
JOIN Loan_Application la ON l.LoanApp_ID = la.LoanApp_ID;
GO

CREATE VIEW StockAccountSummary AS 
SELECT sa.StockAccount_ID, sa.CustomerID, sa.Balance, sa.Status_ 
FROM StockAccount sa;
GO

CREATE VIEW DebitCardDetails AS 
SELECT db.Card_No, db.Card_Type, db.BankAccount_ID, db.Expration_Date 
FROM DebitCard db;
GO

CREATE VIEW CustomerLoanStatus AS 
SELECT c.CustomerID, c.FName, c.LName, la.Loan_Type, la.Amount_Request, la.Status_ 
FROM Loan_Application la 
JOIN Customer c ON la.CustomerID = c.CustomerID;
GO

CREATE VIEW ActiveDepositAccounts AS 
SELECT c.CustomerID, c.FName, c.LName, da.DepositAccount_ID, da.Currency_Type, da.Balance 
FROM Deposit_Account da 
JOIN Customer c ON da.CustomerID = c.CustomerID 
WHERE da.Status_ = 'Y';

-- Step 8: Indexes

CREATE INDEX idx_customer_fname ON Customer(FName);
CREATE INDEX idx_depositaccount_balance ON Deposit_Account(Balance);
CREATE INDEX idx_transaction_date ON Transaction_(Transaction_Date);
CREATE INDEX idx_bankaccount_balance ON BankAccount(Balance);
CREATE INDEX idx_creditcard_customerid ON Credit_Card(CustomerID);
CREATE INDEX idx_stockaccount_balance ON StockAccount(Balance);
CREATE INDEX idx_loanapplication_status ON Loan_Application(Status_);
CREATE INDEX idx_deposittransaction_amount ON Deposit_Transaction(Amount);
CREATE INDEX idx_customer_lname ON Customer(LName);
CREATE INDEX idx_loan_term ON Loan(Loan_term);

