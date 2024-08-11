---
title: MySQL Cheat Sheet 
date: 2024-08-09 11:33:00 +0800
categories: [Blog, Tutorial]
tags: [SQL, MySQL, SWE]
pin: false 
math: true
mermaid: true
image: 
---

MySQL is one of the most popular relational database management systems (RDBMS) in the world. Whether you’re just starting out or you’re a seasoned developer, this cheat sheet will help you navigate MySQL more efficiently. This guide covers a broad spectrum of MySQL commands, functions, and tips that are essential for day-to-day database management.

Table of Content

- [1. **Setting Up MySQL**](#1-setting-up-mysql)
  - [Installing MySQL](#installing-mysql)
  - [Starting MySQL](#starting-mysql)
  - [Accessing MySQL](#accessing-mysql)
- [2. **Basic MySQL Commands**](#2-basic-mysql-commands)
  - [Create a Database](#create-a-database)
  - [Select a Database](#select-a-database)
  - [Show Databases](#show-databases)
  - [Drop a Database](#drop-a-database)
  - [Show Tables in a Database](#show-tables-in-a-database)
  - [Describe the Structure of a Table](#describe-the-structure-of-a-table)
- [3. **Table Operations**](#3-table-operations)
  - [Create a Table](#create-a-table)
  - [Show the Table Schema](#show-the-table-schema)
  - [Drop a Table](#drop-a-table)
  - [Rename a Table](#rename-a-table)
  - [Alter a Table](#alter-a-table)
  - [Truncate a Table](#truncate-a-table)
- [4. **CRUD Operations**](#4-crud-operations)
  - [Insert Data](#insert-data)
  - [Insert Multiple Rows](#insert-multiple-rows)
  - [Select Data](#select-data)
  - [Update Data](#update-data)
  - [Delete Data](#delete-data)
- [5. **Querying Data**](#5-querying-data)
  - [WHERE Clause](#where-clause)
  - [AND, OR, NOT](#and-or-not)
  - [ORDER BY Clause](#order-by-clause)
  - [LIMIT Clause](#limit-clause)
  - [BETWEEN Clause](#between-clause)
  - [LIKE and Wildcards](#like-and-wildcards)
  - [IN Clause](#in-clause)
  - [DISTINCT Clause](#distinct-clause)
- [6. **Advanced MySQL Queries**](#6-advanced-mysql-queries)
  - [JOINS](#joins)
  - [GROUP BY](#group-by)
  - [HAVING Clause](#having-clause)
  - [Subqueries](#subqueries)
  - [UNION](#union)
- [7. **Indexes and Keys**](#7-indexes-and-keys)
  - [Create an Index](#create-an-index)
  - [Drop an Index](#drop-an-index)
  - [Unique Index](#unique-index)
  - [Primary Key](#primary-key)
  - [Foreign Key](#foreign-key)
- [8. **Transactions**](#8-transactions)
  - [Start a Transaction](#start-a-transaction)
  - [Commit a Transaction](#commit-a-transaction)
  - [Rollback a Transaction](#rollback-a-transaction)
  - [Savepoints](#savepoints)
- [9. **User Management and Security**](#9-user-management-and-security)
  - [Create a User](#create-a-user)
  - [Grant Privileges](#grant-privileges)
  - [Show Grants](#show-grants)
  - [Revoke Privileges](#revoke-privileges)
  - [Drop a User](#drop-a-user)
  - [Change User Password](#change-user-password)
- [10. **Backup and Restore**](#10-backup-and-restore)
  - [Backup a Database](#backup-a-database)
  - [Restore a Database](#restore-a-database)
  - [Backup Specific Tables](#backup-specific-tables)
  - [Backup All Databases](#backup-all-databases)
- [11. **Optimization and Maintenance**](#11-optimization-and-maintenance)
  - [Check Table for Errors](#check-table-for-errors)
  - [Repair a Table](#repair-a-table)
  - [Optimize a Table](#optimize-a-table)
  - [Analyze a Table](#analyze-a-table)
  - [Viewing Server Status](#viewing-server-status)
  - [Show Current Users](#show-current-users)
- [12. **MySQL Functions**](#12-mysql-functions)
  - [String Functions](#string-functions)
  - [Date Functions](#date-functions)
  - [Aggregate Functions](#aggregate-functions)
- [13. **Stored Procedures and Functions**](#13-stored-procedures-and-functions)
  - [Creating a Stored Procedure](#creating-a-stored-procedure)
  - [Executing a Stored Procedure](#executing-a-stored-procedure)
  - [Dropping a Stored Procedure](#dropping-a-stored-procedure)
  - [Creating a Stored Function](#creating-a-stored-function)
  - [Dropping a Stored Function](#dropping-a-stored-function)
- [14. **Triggers**](#14-triggers)
  - [Creating a Trigger](#creating-a-trigger)
  - [Dropping a Trigger](#dropping-a-trigger)
- [15. **Views**](#15-views)
  - [Creating a View](#creating-a-view)
  - [Selecting from a View](#selecting-from-a-view)
  - [Dropping a View](#dropping-a-view)
- [16. **Replication and High Availability**](#16-replication-and-high-availability)
  - [Setting Up Master-Slave Replication](#setting-up-master-slave-replication)
  - [Checking Replication Status](#checking-replication-status)
  - [Stopping and Starting Replication](#stopping-and-starting-replication)
- [17. **MySQL Best Practices**](#17-mysql-best-practices)
  - [Use Consistent Naming Conventions](#use-consistent-naming-conventions)
  - [Normalize Your Database](#normalize-your-database)
  - [Backup Regularly](#backup-regularly)
  - [Monitor Performance](#monitor-performance)
  - [Secure Your MySQL Installation](#secure-your-mysql-installation)
  - [Index Appropriately](#index-appropriately)
  - [Regularly Update MySQL](#regularly-update-mysql)
- [Conclusion](#conclusion)

## 1. **Setting Up MySQL**

### Installing MySQL

- **On Ubuntu:**

  ```bash
  sudo apt-get update
  sudo apt-get install mysql-server
  ```

- **On CentOS:**

  ```bash
  sudo yum update
  sudo yum install mysql-server
  ```

- **On macOS:**

  ```bash
  brew install mysql
  ```

### Starting MySQL

- **Start MySQL:**

  ```bash
  sudo systemctl start mysql
  ```

- **Enable MySQL to start on boot:**

  ```bash
  sudo systemctl enable mysql
  ```

### Accessing MySQL

```bash
mysql -u root -p
```

## 2. **Basic MySQL Commands**

### Create a Database

```sql
CREATE DATABASE db_name;
```

### Select a Database

```sql
USE db_name;
```

### Show Databases

```sql
SHOW DATABASES;
```

### Drop a Database

```sql
DROP DATABASE db_name;
```

### Show Tables in a Database

```sql
SHOW TABLES;
```

### Describe the Structure of a Table

```sql
DESCRIBE table_name;
```

## 3. **Table Operations**

### Create a Table

```sql
CREATE TABLE table_name (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    age INT,
    email VARCHAR(100)
);
```

### Show the Table Schema

```sql
SHOW CREATE TABLE table_name;
```

### Drop a Table

```sql
DROP TABLE table_name;
```

### Rename a Table

```sql
RENAME TABLE old_table_name TO new_table_name;
```

### Alter a Table

- **Add a column:**

  ```sql
  ALTER TABLE table_name ADD COLUMN column_name data_type;
  ```

- **Modify a column:**

  ```sql
  ALTER TABLE table_name MODIFY COLUMN column_name new_data_type;
  ```

- **Drop a column:**

  ```sql
  ALTER TABLE table_name DROP COLUMN column_name;
  ```

### Truncate a Table

```sql
TRUNCATE TABLE table_name;
```

## 4. **CRUD Operations**

 > create, read, update and delete.

### Insert Data

```sql
INSERT INTO table_name (column1, column2, column3) VALUES (value1, value2, value3);
```

### Insert Multiple Rows

```sql
INSERT INTO table_name (column1, column2) VALUES 
(value1_1, value2_1),
(value1_2, value2_2),
(value1_3, value2_3);
```

### Select Data

- **Select all columns:**

  ```sql
  SELECT * FROM table_name;
  ```

- **Select specific columns:**

  ```sql
  SELECT column1, column2 FROM table_name;
  ```

### Update Data

```sql
UPDATE table_name SET column1 = value1, column2 = value2 WHERE condition;
```

### Delete Data

```sql
DELETE FROM table_name WHERE condition;
```

## 5. **Querying Data**

### WHERE Clause

```sql
SELECT * FROM table_name WHERE column_name = value;
```

### AND, OR, NOT

```sql
SELECT * FROM table_name WHERE column1 = value1 AND (column2 = value2 OR column3 = value3);
```

### ORDER BY Clause

```sql
SELECT * FROM table_name ORDER BY column_name ASC;
SELECT * FROM table_name ORDER BY column_name DESC;
```

### LIMIT Clause

```sql
SELECT * FROM table_name LIMIT number_of_rows;
```

### BETWEEN Clause

```sql
SELECT * FROM table_name WHERE column_name BETWEEN value1 AND value2;
```

### LIKE and Wildcards

- **Find values that start with 'a':**

  ```sql
  SELECT * FROM table_name WHERE column_name LIKE 'a%';
  ```

- **Find values that end with 'a':**

  ```sql
  SELECT * FROM table_name WHERE column_name LIKE '%a';
  ```

- **Find values that contain 'a':**

  ```sql
  SELECT * FROM table_name WHERE column_name LIKE '%a%';
  ```

### IN Clause

```sql
SELECT * FROM table_name WHERE column_name IN (value1, value2, value3);
```

### DISTINCT Clause

```sql
SELECT DISTINCT column_name FROM table_name;
```

## 6. **Advanced MySQL Queries**

### JOINS

- **Inner Join:**

  ```sql
  SELECT columns FROM table1
  INNER JOIN table2 ON table1.column = table2.column;
  ```

- **Left Join:**

  ```sql
  SELECT columns FROM table1
  LEFT JOIN table2 ON table1.column = table2.column;
  ```

- **Right Join:**

  ```sql
  SELECT columns FROM table1
  RIGHT JOIN table2 ON table1.column = table2.column;
  ```

### GROUP BY

```sql
SELECT column_name, COUNT(*) FROM table_name
GROUP BY column_name;
```

### HAVING Clause

```sql
SELECT column_name, COUNT(*) FROM table_name
GROUP BY column_name
HAVING COUNT(*) > 1;
```

### Subqueries

- **Subquery in SELECT:**

  ```sql
  SELECT column_name, (SELECT COUNT(*) FROM another_table WHERE condition) 
  FROM table_name;
  ```

- **Subquery in WHERE:**

  ```sql
  SELECT column_name FROM table_name
  WHERE column_name IN (SELECT column_name FROM another_table WHERE condition);
  ```

### UNION

```sql
SELECT column_name FROM table1
UNION
SELECT column_name FROM table2;
```

## 7. **Indexes and Keys**

### Create an Index

```sql
CREATE INDEX index_name ON table_name (column_name);
```

### Drop an Index

```sql
DROP INDEX index_name ON table_name;
```

### Unique Index

```sql
CREATE UNIQUE INDEX index_name ON table_name (column_name);
```

### Primary Key

```sql
ALTER TABLE table_name ADD PRIMARY KEY (column_name);
```

### Foreign Key

```sql
ALTER TABLE table_name
ADD CONSTRAINT fk_name FOREIGN KEY (column_name) REFERENCES other_table(column_name);
```

## 8. **Transactions**

### Start a Transaction

```sql
START TRANSACTION;
```

### Commit a Transaction

```sql
COMMIT;
```

### Rollback a Transaction

```sql
ROLLBACK;
```

### Savepoints

```sql
SAVEPOINT savepoint_name;
ROLLBACK TO savepoint_name;
```

## 9. **User Management and Security**

### Create a User

```sql
CREATE USER 'username'@'host' IDENTIFIED BY 'password';
```

### Grant Privileges

```sql
GRANT ALL PRIVILEGES ON database_name.* TO 'username'@'host';
```

### Show Grants

```sql
SHOW GRANTS FOR 'username'@'host';
```

### Revoke Privileges

```sql
REVOKE ALL PRIVILEGES ON database_name.* FROM 'username'@'host';
```

### Drop a User

```sql
DROP USER 'username'@'host';
```

### Change User Password

```sql
ALTER USER 'username'@'host' IDENTIFIED BY 'new_password';
```

## 10. **Backup and Restore**

### Backup a Database

```bash
mysqldump -u username -p database_name > backup.sql
```

### Restore a Database

```bash
mysql -u username -p database_name < backup.sql
```

### Backup Specific Tables

```bash
mysqldump -u username -p database_name table1 table2 > backup.sql
```

### Backup All Databases

```bash
mysqldump -u username -p --all-databases > all_databases_backup.sql
```

## 11. **Optimization and Maintenance**

### Check Table for Errors

```sql
CHECK TABLE table_name;
```

### Repair a Table

```sql
REPAIR TABLE table_name;
```

### Optimize a Table

```sql
OPTIMIZE TABLE table_name;
```

### Analyze a Table

```sql
ANALYZE TABLE table_name;
```

### Viewing Server Status

```sql
SHOW STATUS;
```

### Show Current Users

```sql
SELECT user, host FROM mysql.user;
```

## 12. **MySQL Functions**

### String Functions

- **Concatenate Strings:**

  ```sql
  SELECT CONCAT('Hello', ' ', 'World!');
  ```

- **Length of a String:**

  ```sql
  SELECT LENGTH('Hello World!');
  ```

- **Substring:**

  ```sql
  SELECT SUBSTRING('Hello World!', 1, 5);
  ```

### Date Functions

- **Current Date:**

  ```sql
  SELECT CURDATE();
  ```

- **Current Time:**

  ```sql
  SELECT CURTIME();
  ```

- **Add Date:**

  ```sql
  SELECT DATE_ADD('2024-08-10', INTERVAL 10 DAY);
  ```

### Aggregate Functions

- **COUNT:**

  ```sql
  SELECT COUNT(*) FROM table_name;
  ```

- **SUM:**

  ```sql
  SELECT SUM(column_name)
  ```

  Continuing from where we left off:

```sql
SELECT SUM(column_name) FROM table_name;
```

- **AVG:**

  ```sql
  SELECT AVG(column_name) FROM table_name;
  ```

- **MIN:**

  ```sql
  SELECT MIN(column_name) FROM table_name;
  ```

- **MAX:**

  ```sql
  SELECT MAX(column_name) FROM table_name;
  ```

## 13. **Stored Procedures and Functions**

### Creating a Stored Procedure

```sql
DELIMITER //
CREATE PROCEDURE procedure_name (IN param1 datatype, OUT param2 datatype)
BEGIN
    -- SQL statements
    SELECT column_name INTO param2 FROM table_name WHERE condition;
END //
DELIMITER ;
```

### Executing a Stored Procedure

```sql
CALL procedure_name(param1, @param2);
SELECT @param2;
```

### Dropping a Stored Procedure

```sql
DROP PROCEDURE procedure_name;
```

### Creating a Stored Function

```sql
DELIMITER //
CREATE FUNCTION function_name (param1 datatype) RETURNS datatype
BEGIN
    -- SQL statements
    RETURN expression;
END //
DELIMITER ;
```

### Dropping a Stored Function

```sql
DROP FUNCTION function_name;
```

## 14. **Triggers**

### Creating a Trigger

```sql
CREATE TRIGGER trigger_name
BEFORE/AFTER INSERT/UPDATE/DELETE
ON table_name FOR EACH ROW
BEGIN
    -- SQL statements
END;
```

### Dropping a Trigger

```sql
DROP TRIGGER trigger_name;
```

## 15. **Views**

### Creating a View

```sql
CREATE VIEW view_name AS
SELECT columns FROM table_name WHERE condition;
```

### Selecting from a View

```sql
SELECT * FROM view_name;
```

### Dropping a View

```sql
DROP VIEW view_name;
```

## 16. **Replication and High Availability**

### Setting Up Master-Slave Replication

1. **On the Master:**
   - **Edit the MySQL configuration file** (usually `my.cnf` or `my.ini`):

     ```bash
     [mysqld]
     server-id=1
     log-bin=mysql-bin
     ```

   - **Restart the MySQL server:**

     ```bash
     sudo systemctl restart mysql
     ```

   - **Grant Replication Privileges:**

     ```sql
     GRANT REPLICATION SLAVE ON *.* TO 'replica_user'@'%' IDENTIFIED BY 'password';
     FLUSH PRIVILEGES;
     ```

   - **Get the binary log file and position:**

     ```sql
     SHOW MASTER STATUS;
     ```

2. **On the Slave:**
   - **Edit the MySQL configuration file:**

     ```bash
     [mysqld]
     server-id=2
     ```

   - **Restart the MySQL server:**

     ```bash
     sudo systemctl restart mysql
     ```

   - **Configure the Slave:**

     ```sql
     CHANGE MASTER TO
     MASTER_HOST='master_ip',
     MASTER_USER='replica_user',
     MASTER_PASSWORD='password',
     MASTER_LOG_FILE='mysql-bin.000001',
     MASTER_LOG_POS=12345;
     ```

   - **Start the Slave:**

     ```sql
     START SLAVE;
     ```

### Checking Replication Status

```sql
SHOW SLAVE STATUS\G;
```

### Stopping and Starting Replication

- **Stop the Slave:**

  ```sql
  STOP SLAVE;
  ```

- **Start the Slave:**

  ```sql
  START SLAVE;
  ```

## 17. **MySQL Best Practices**

### Use Consistent Naming Conventions

- Stick to lowercase letters, underscores for spaces, and singular names for tables (e.g., `user`, `order_item`).

### Normalize Your Database

- Ensure your database is normalized to at least the third normal form (3NF) to reduce redundancy and improve data integrity.

### Backup Regularly

- Set up automated backups and always test your backup recovery process.

### Monitor Performance

- Use tools like `mysqltuner` to monitor and optimize the performance of your MySQL database.

### Secure Your MySQL Installation

- Run `mysql_secure_installation` after setting up MySQL to enhance security.

### Index Appropriately

- Index columns that are frequently used in `WHERE`, `JOIN`, and `ORDER BY` clauses, but avoid over-indexing as it can slow down `INSERT`, `UPDATE`, and `DELETE` operations.

### Regularly Update MySQL

- Keep your MySQL version up to date with the latest security patches and performance improvements.

## Conclusion

This `MySQL` cheat sheet provides a solid foundation for managing databases efficiently. Whether you’re working on a small project or a large-scale application, understanding these commands, functions, and best practices will help you get the most out of `MySQL`. Keep this guide handy as you develop and maintain your databases to ensure smooth and effective database management.
