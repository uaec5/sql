-- ========================================
--  Create 'customer' table if it doesn't exist
-- ========================================
IF OBJECT_ID('customer', 'U') IS NULL
BEGIN
    CREATE TABLE customer (
        customerID INT PRIMARY KEY,                          -- Unique ID for each customer
        fullName VARCHAR(100) NOT NULL,                      -- Full name is required
        phoneNumber VARCHAR(20),                             -- Optional phone number
        email VARCHAR(100),                                  -- Optional email
        city VARCHAR(50)                                     -- Customer's city
    );
END

-- ========================================
--  Insert customers (only if not already present)
-- ========================================
IF NOT EXISTS (SELECT 1 FROM customer WHERE customerID = 1)
INSERT INTO customer (customerID, fullName, phoneNumber, email, city)
VALUES (1, 'Ahmed Alshehhi', '0501234567', 'ahmed@example.com', 'Abu Dhabi');

IF NOT EXISTS (SELECT 1 FROM customer WHERE customerID = 2)
INSERT INTO customer (customerID, fullName, phoneNumber, email, city)
VALUES (2, 'Fatima Alkaabi', '0507654321', 'fatima@example.com', 'Dubai');

-- ========================================
--  Create 'Table_1' (cars) if it doesn't exist
-- ========================================
IF OBJECT_ID('Table_1', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[Table_1] (
        carID INT PRIMARY KEY,                              -- Unique car ID
        [car name] VARCHAR(100),                            -- Model name of the car
        MODEL INT                                           -- Model year
    );
END

-- ========================================
--  Insert car records (only if not already present)
-- ========================================
IF NOT EXISTS (SELECT 1 FROM [dbo].[Table_1] WHERE carID = 1)
INSERT INTO [dbo].[Table_1] (carID, [car name], MODEL)
VALUES (1, 'Toyota Camry', 2022);

IF NOT EXISTS (SELECT 1 FROM [dbo].[Table_1] WHERE carID = 2)
INSERT INTO [dbo].[Table_1] (carID, [car name], MODEL)
VALUES (2, 'Honda Accord', 2023);

-- ========================================
--  Create 'sales' table if it doesn't exist
-- ========================================
IF OBJECT_ID('sales', 'U') IS NULL
BEGIN
    CREATE TABLE sales (
        saleID INT PRIMARY KEY IDENTITY(1,1),               -- Auto-incrementing sale ID
        customerID INT NOT NULL,                            -- Foreign key to customer
        carID INT NOT NULL,                                 -- Foreign key to car
        saleDate DATE NOT NULL,                             -- Date of sale
        price DECIMAL(10, 2),                               -- Sale price
        FOREIGN KEY (customerID) REFERENCES customer(customerID),
        FOREIGN KEY (carID) REFERENCES [dbo].[Table_1](carID)
    );
END

-- ========================================
--  Insert sales (only if not already present)
-- ========================================
IF NOT EXISTS (
    SELECT 1 FROM sales WHERE customerID = 1 AND carID = 1 AND saleDate = '2024-12-01'
)
INSERT INTO sales (customerID, carID, saleDate, price)
VALUES (1, 1, '2024-12-01', 95000.00);

IF NOT EXISTS (
    SELECT 1 FROM sales WHERE customerID = 2 AND carID = 2 AND saleDate = '2025-01-15'
)
INSERT INTO sales (customerID, carID, saleDate, price)
VALUES (2, 2, '2025-01-15', 120000.00);

-- ========================================
--  View full joined data (sales + customer + car)
-- ========================================
SELECT 
    s.saleID,
    c.fullName,
    c.city,
    t.[car name],
    t.MODEL,
    s.saleDate,
    s.price
FROM 
    sales s
JOIN 
    customer c ON s.customerID = c.customerID
JOIN 
    [dbo].[Table_1] t ON s.carID = t.carID;
