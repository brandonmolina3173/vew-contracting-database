USE VEW_Contracting_DB;
CREATE TABLE Customer (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Phone VARCHAR(20),
    Email VARCHAR(100),
    Address VARCHAR(255)
);
CREATE TABLE Employee (
    EmployeeID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    JobTitle VARCHAR(50),
    HourlyRate DECIMAL(10,2)
);
CREATE TABLE Material (
    MaterialID INT AUTO_INCREMENT PRIMARY KEY,
    MaterialName VARCHAR(100),
    Quantity INT,
    UnitCost DECIMAL(10,2)
);
CREATE TABLE Project (
    ProjectID INT AUTO_INCREMENT PRIMARY KEY,
    ProjectType VARCHAR(100),
    Location VARCHAR(255),
    StartDate DATE,
    EndDate DATE,
    Status VARCHAR(50),
    TotalCost DECIMAL(10,2),
    CustomerID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);
CREATE TABLE Invoice (
    InvoiceID INT AUTO_INCREMENT PRIMARY KEY,
    InvoiceDate DATE,
    Amount DECIMAL(10,2),
    PaymentStatus VARCHAR(50),
    ProjectID INT,
    FOREIGN KEY (ProjectID) REFERENCES Project(ProjectID)
);

CREATE TABLE Project_Employee (
    ProjectID INT,
    EmployeeID INT,
    PRIMARY KEY (ProjectID, EmployeeID),
    FOREIGN KEY (ProjectID) REFERENCES Project(ProjectID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);
CREATE TABLE Project_Material (
    ProjectID INT,
    MaterialID INT,
    QuantityUsed DECIMAL(10,2),
    PRIMARY KEY (ProjectID, MaterialID),
    FOREIGN KEY (ProjectID) REFERENCES Project(ProjectID),
    FOREIGN KEY (MaterialID) REFERENCES Material(MaterialID)
);
SHOW TABLES;

INSERT INTO Customer (FirstName, LastName, Phone, Email, Address)
VALUES 
('John', 'Smith', '845-555-1234', 'john@email.com', 'New Paltz, NY'),
('Maria', 'Lopez', '845-555-5678', 'maria@email.com', 'Kingston, NY'),
('Carlos', 'Rivera', '845-555-5222', 'carlos@email.com', 'Poughkeepsie, NY'),
('Ashley', 'Green', '845-555-3633', 'ashley@email.com', 'Highland, NY'),
('Michael', 'Johnson', '845-555-4464', 'michael@email.com', 'Woodstock, NY');

SELECT * FROM Customer;
INSERT INTO Employee (FirstName, LastName, JobTitle, HourlyRate)
VALUES
('David', 'Brown', 'Roofing Specialist', 25.00),
('James', 'Wilson', 'Project Manager', 35.00);

INSERT INTO Material (MaterialName, Quantity, UnitCost)
VALUES
('Roof Shingles', 100, 30.00),
('Stone', 200, 15.00);

INSERT INTO Project (ProjectType, Location, StartDate, EndDate, Status, TotalCost, CustomerID)
VALUES
('Roof Repair', 'New Paltz', '2026-04-30', '2026-05-05', 'In Progress', 1500.00, 1);

INSERT INTO Invoice (InvoiceDate, Amount, PaymentStatus, ProjectID)
VALUES
('2026-05-06', 1500.00, 'Unpaid', 1);

INSERT INTO Project_Employee (ProjectID, EmployeeID)
VALUES (1,1);

INSERT INTO Project_Material (ProjectID, MaterialID, QuantityUsed)
VALUES (1,1,50);



UPDATE Project
SET Status = 'Completed'
WHERE ProjectID = 1;



DELETE FROM Project_Material
WHERE ProjectID = 1;



CREATE VIEW ProjectSummary AS
SELECT 
    Project.ProjectID,
    Customer.FirstName,
    Customer.LastName,
    Project.ProjectType,
    Project.Location,
    Project.Status,
    Project.TotalCost
FROM Project
JOIN Customer ON Project.CustomerID = Customer.CustomerID;



SHOW TABLES;









INSERT INTO Project (ProjectType, Location, StartDate, EndDate, Status, TotalCost, CustomerID)
VALUES
('Roof Installation', 'Kingston', '2026-05-10', '2026-05-20', 'Completed', 8500.00, 2),
('Stone Exterior Work', 'New Paltz', '2026-05-12', '2026-05-25', 'In Progress', 5000.00, 3),
('Roof Inspection', 'Highland', '2026-05-15', '2026-05-16', 'Scheduled', 700.00, 4),
('Stone Wall Installation', 'Putnam Valley' , '2025-10-23', '2026-01-28', 'Completed', 2000.00, 5);

INSERT INTO Project_Employee (ProjectID, EmployeeID)
VALUES
(2,1),
(2,2),
(3,2),
(4,1),
(5,2);


SELECT 
    Project.ProjectID,
    Customer.FirstName,
    Customer.LastName,
    Project.ProjectType,
    Project.Location,
    Project.Status,
    Project.TotalCost
FROM Project
JOIN Customer 
ON Project.CustomerID = Customer.CustomerID;











SELECT COUNT(*) AS TotalProjects
FROM Project;

SELECT ProjectID, ProjectType, Location, TotalCost
FROM Project
WHERE TotalCost > (
    SELECT AVG(TotalCost)
    FROM Project
);


SELECT 
    Status,
    COUNT(*) AS NumberOfProjects
FROM Project
GROUP BY Status;

SELECT ProjectID, ProjectType, Location, Status, TotalCost
FROM Project
WHERE ProjectType LIKE '%Roof%';

SELECT ProjectID, ProjectType, Location, Status, TotalCost
FROM Project
WHERE Status = 'Completed'
AND TotalCost >= 2000;




SELECT 
    Project.ProjectID,
    Project.ProjectType,
    Employee.FirstName,
    Employee.LastName,
    Employee.JobTitle
FROM Project
JOIN Project_Employee 
ON Project.ProjectID = Project_Employee.ProjectID
JOIN Employee 
ON Project_Employee.EmployeeID = Employee.EmployeeID;

SHOW TABLES;

SELECT * FROM Project;

SELECT * FROM ProjectSummary;
