---
title: MySQL Cheat Sheet 
date: 2024-08-09 11:33:00 +0800
categories: [Blog, Tutorial]
tags: [SQL, MySQL, SWE]
pin: true 
math: true
mermaid: true
image: 
---

`MySQL` is one of the most popular relational database management systems (`RDBMS`) in the world. Whether you’re just starting out or you’re a seasoned developer, this cheat sheet will help you navigate MySQL more efficiently. This guide covers a broad spectrum of MySQL commands, functions, and tips that are essential for day-to-day database management.

## **Basic MySQL Commands**

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
DESCRIBE tableName;
```

## **Table Operations**

### Create a Table

```sql
CREATE TABLE tableName (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    age INT,
    email VARCHAR(100)
);
```

### Show the Table Schema

```sql
SHOW CREATE TABLE tableName;
```

### Drop a Table

```sql
DROP TABLE tableName;
```

### Rename a Table

```sql
RENAME TABLE old_tableName TO newTableName;
```

### Alter a Table

- **Add a column:**

  ```sql
  ALTER TABLE tableName ADD COLUMN columnName data_type;
  ```

- **Rename a column:**

  ```sql
  ALTER TABLE tableName RENAME COLUMN oldcolumnName TO newcolumnName;
  ```

- **Modify a column:**

  ```sql
  ALTER TABLE tableName MODIFY COLUMN columnName new_data_type;
  ```

- **Drop a column:**

  ```sql
  ALTER TABLE tableName DROP COLUMN columnName;
  ```

### Truncate a Table

```sql
TRUNCATE TABLE tableName;
```

## **CRUD Operations**

 > create, read, update and delete.

### Insert Data

```sql
INSERT INTO tableName (column1, column2, column3) VALUES (value1, value2, value3);
```

### Insert Multiple Rows

```sql
INSERT INTO tableName (column1, column2) VALUES 
(value1_1, value2_1),
(value1_2, value2_2),
(value1_3, value2_3);
```

### Select Data

- **Select all columns:**

  ```sql
  SELECT * FROM tableName;
  ```

- **Select specific columns:**

  ```sql
  SELECT column1, column2 FROM tableName;
  ```

### Update Data

```sql
UPDATE tableName SET column1 = value1, column2 = value2 WHERE condition;
```

### Delete Data

```sql
DELETE FROM tableName WHERE condition;
```

## **Querying Data**

### WHERE Clause

```sql
SELECT * FROM tableName WHERE columnName = value;
```

### AND, OR, NOT

```sql
SELECT * FROM tableName WHERE column1 = value1 AND (column2 = value2 OR column3 = value3);
```

### ORDER BY Clause

```sql
SELECT * FROM tableName ORDER BY columnName ASC;
SELECT * FROM tableName ORDER BY columnName DESC;
```

### LIMIT Clause

```sql
SELECT * FROM tableName LIMIT number_of_rows;
```

### BETWEEN Clause

```sql
SELECT * FROM tableName WHERE columnName BETWEEN value1 AND value2;
```

### LIKE and Wildcards

- **Find values that start with 'a':**

  ```sql
  SELECT * FROM tableName WHERE columnName LIKE 'a%';
  ```

- **Find values that end with 'a':**

  ```sql
  SELECT * FROM tableName WHERE columnName LIKE '%a';
  ```

- **Find values that contain 'a':**

  ```sql
  SELECT * FROM tableName WHERE columnName LIKE '%a%';
  ```

### IN Clause

```sql
SELECT * FROM tableName WHERE columnName IN (value1, value2, value3);
```

### DISTINCT Clause

```sql
SELECT DISTINCT columnName FROM tableName;
```

## **Advanced MySQL Queries**

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
SELECT columnName, COUNT(*) FROM tableName
GROUP BY columnName;
```

### HAVING Clause

```sql
SELECT columnName, COUNT(*) FROM tableName
GROUP BY columnName
HAVING COUNT(*) > 1;
```

### Subqueries

- **Subquery in SELECT:**

  ```sql
  SELECT columnName, (SELECT COUNT(*) FROM another_table WHERE condition) 
  FROM tableName;
  ```

- **Subquery in WHERE:**

  ```sql
  SELECT columnName FROM tableName
  WHERE columnName IN (SELECT columnName FROM another_table WHERE condition);
  ```

### UNION

```sql
SELECT columnName FROM table1
UNION
SELECT columnName FROM table2;
```

## **Indexes and Keys**

### Create an Index

```sql
CREATE INDEX index_name ON tableName (columnName);
```

### Drop an Index

```sql
DROP INDEX index_name ON tableName;
```

### Unique Index

```sql
CREATE UNIQUE INDEX index_name ON tableName (columnName);
```

### Primary Key

```sql
ALTER TABLE tableName ADD PRIMARY KEY (columnName);
```

### Foreign Key

```sql
ALTER TABLE tableName
ADD CONSTRAINT fk_name FOREIGN KEY (columnName) REFERENCES other_table(columnName);
```

## **Transactions**

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

## **User Management and Security**

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

## **Backup and Restore**

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

## **Optimization and Maintenance**

### Check Table for Errors

```sql
CHECK TABLE tableName;
```

### Repair a Table

```sql
REPAIR TABLE tableName;
```

### Optimize a Table

```sql
OPTIMIZE TABLE tableName;
```

### Analyze a Table

```sql
ANALYZE TABLE tableName;
```

### Viewing Server Status

```sql
SHOW STATUS;
```

### Show Current Users

```sql
SELECT user, host FROM mysql.user;
```

## **MySQL Functions**

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
  SELECT COUNT(*) FROM tableName;
  ```

- **SUM:**

  ```sql
  SELECT SUM(columnName)
  ```

  Continuing from where we left off:

```sql
SELECT SUM(columnName) FROM tableName;
```

- **AVG:**

  ```sql
  SELECT AVG(columnName) FROM tableName;
  ```

- **MIN:**

  ```sql
  SELECT MIN(columnName) FROM tableName;
  ```

- **MAX:**

  ```sql
  SELECT MAX(columnName) FROM tableName;
  ```

## **Stored Procedures and Functions**

### Creating a Stored Procedure

```sql
DELIMITER //
CREATE PROCEDURE procedure_name (IN param1 datatype, OUT param2 datatype)
BEGIN
    -- SQL statements
    SELECT columnName INTO param2 FROM tableName WHERE condition;
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

## **Triggers**

### Creating a Trigger

```sql
CREATE TRIGGER trigger_name
BEFORE/AFTER INSERT/UPDATE/DELETE
ON tableName FOR EACH ROW
BEGIN
    -- SQL statements
END;
```

### Dropping a Trigger

```sql
DROP TRIGGER trigger_name;
```

## **Views**

### Creating a View

```sql
CREATE VIEW view_name AS
SELECT columns FROM tableName WHERE condition;
```

### Selecting from a View

```sql
SELECT * FROM view_name;
```

### Dropping a View

```sql
DROP VIEW view_name;
```

## **Replication and High Availability**

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

## **MySQL Best Practices**

### Use Consistent Naming Conventions

- Stick to lowercase letters, underscores for spaces, and singular names for tables (e.g., `user`, `order_item`).

### Normalize Your Database

- Ensure your database is normalized to at least the third normal form (3NF) to reduce redundancy and improve data integrity.

### Backup Regularly

- Set up automated backups and always test your backup recovery process.

### Monitor Performance

- Use tools like `mysqltuner` to monitor and optimize the performance of `MySQL` database.

### Secure Your MySQL Installation

- Run `mysql_secure_installation` after setting up MySQL to enhance security.

### Index Appropriately

- Index columns that are frequently used in `WHERE`, `JOIN`, and `ORDER BY` clauses, but avoid over-indexing as it can slow down `INSERT`, `UPDATE`, and `DELETE` operations.

### Regularly Update MySQL

- Keep `MySQL` version up to date with the latest security patches and performance improvements.

## Conclusion

This `MySQL` cheat sheet provides a solid foundation for managing databases efficiently. Whether you’re working on a small project or a large-scale application, understanding these commands, functions, and best practices will help you get the most out of `MySQL`. Keep this guide handy as you develop and maintain your databases to ensure smooth and effective database management.
