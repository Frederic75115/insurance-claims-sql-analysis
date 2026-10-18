-- Task 1: Database Schema Creation
-- Create Customers, PolicyTypes, Policies, and Claims in dependency order.
-- SERIAL primary keys identify each record; foreign keys connect the tables.
-- CustomerID links policies to customers, PolicyTypeID links policies to types,
-- and PolicyID links claims to policies.

-- Define tables: Customers, Policies, Claims, PolicyTypes.

---1. Customers Table---------
-- Store customer names, demographics, and contact address information.
CREATE TABLE Customers (
    CustomerID SERIAL PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DateOfBirth DATE,
    Gender CHAR(1),
    Address VARCHAR(100),
    City VARCHAR(50),
    State VARCHAR(50),
    ZipCode VARCHAR(10)
);

---2. PolicyTypes Table

-- Store the available insurance categories and their descriptions.
CREATE TABLE PolicyTypes (
    PolicyTypeID SERIAL PRIMARY KEY,
    PolicyTypeName VARCHAR(50),
    Description TEXT
);

----3. Policies Table

-- Store coverage dates and premiums, with references to customers and types.
CREATE TABLE Policies (
    PolicyID SERIAL PRIMARY KEY,
    CustomerID INT REFERENCES Customers(CustomerID),
    PolicyTypeID INT REFERENCES PolicyTypes(PolicyTypeID),
    PolicyStartDate DATE,
    PolicyEndDate DATE,
    Premium DECIMAL(10,2)
);

---4. Claims Table

-- Store claim dates, amounts, descriptions, and statuses for each policy.
CREATE TABLE Claims (
    ClaimID SERIAL PRIMARY KEY,
    PolicyID INT REFERENCES Policies(PolicyID),
    ClaimDate DATE,
    ClaimAmount DECIMAL(10,2),
    ClaimDescription TEXT,
    ClaimStatus VARCHAR(50)
);