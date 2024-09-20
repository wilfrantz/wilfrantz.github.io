---
title: Domain Engine SQL Database schema 
date: 2024-08-18 11:33:00 +0800
categories: [Blogging, Tutorial]
tags: [C++, MySQL, SWE]
pin: false 
math: true
mermaid: true
image: 
---

### 1. **Database Schema Design**

Create several tables to handle the different components of the JSON data. The main tables could be:

- **`domains`**: Store basic information about the domain.
- **`appraisal`**: Store appraisal values and related data.
- **`keyword_stats`**: Store keyword statistics.
- **`sales_history`**: Store historical sales data.
- **`trademarks`**: Store trademark information.
- **`web`**: Store web-related statistics.
- **`whois`**: Store WHOIS-related data.

### 2. **Table Definitions**

Here’s how the tables in MySQL could be define:

#### **`domains` Table**

```sql
CREATE TABLE domains (
    id INT AUTO_INCREMENT PRIMARY KEY,
    domain_name VARCHAR(255),
    sld VARCHAR(255),
    tld VARCHAR(10),
    category VARCHAR(255),
    language VARCHAR(50),
    char_pattern VARCHAR(10),
    num_hyphens INT,
    num_numbers INT,
    num_words INT,
    is_cctld BOOLEAN,
    is_ntld BOOLEAN,
    has_dns BOOLEAN,
    traffic_estimate INT,
    pagerank INT,
    wayback_age INT,
    wayback_records INT
);
```

#### **`appraisal` Table**

```sql
CREATE TABLE appraisal (
    id INT AUTO_INCREMENT PRIMARY KEY,
    domain_id INT,
    appraised_value DECIMAL(10, 2),
    appraised_monetization_value DECIMAL(10, 2),
    appraised_wholesale_value DECIMAL(10, 2),
    avg_sales_price DECIMAL(10, 2),
    FOREIGN KEY (domain_id) REFERENCES domains(id)
);
```

#### **`keyword_stats` Table**

```sql
CREATE TABLE keyword_stats (
    id INT AUTO_INCREMENT PRIMARY KEY,
    domain_id INT,
    keyword VARCHAR(255),
    competition VARCHAR(50),
    cpc DECIMAL(10, 2),
    global_search_volume INT,
    local_search_volume INT,
    month INT,
    type VARCHAR(50),
    FOREIGN KEY (domain_id) REFERENCES domains(id)
);
```

#### **`sales_history` Table**

```sql
CREATE TABLE sales_history (
    id INT AUTO_INCREMENT PRIMARY KEY,
    domain_id INT,
    sale_date DATE,
    domain_sold VARCHAR(255),
    sale_price DECIMAL(10, 2),
    source VARCHAR(255),
    FOREIGN KEY (domain_id) REFERENCES domains(id)
);
```

#### **`trademarks` Table**

```sql
CREATE TABLE trademarks (
    id INT AUTO_INCREMENT PRIMARY KEY,
    domain_id INT,
    trademark_term VARCHAR(255),
    trademark_risk INT,
    trademark_probability DECIMAL(5, 2),
    FOREIGN KEY (domain_id) REFERENCES domains(id)
);
```

#### **`web` Table**

```sql
CREATE TABLE web (
    id INT AUTO_INCREMENT PRIMARY KEY,
    domain_id INT,
    backlink_ips INT,
    backlink_ips_unique INT,
    backlink_subnets INT,
    backlink_subnets_unique INT,
    web_links_external INT,
    web_links_external_unique INT,
    web_links_internal INT,
    web_pages INT,
    FOREIGN KEY (domain_id) REFERENCES domains(id)
);
```

#### **`whois` Table**

```sql
CREATE TABLE whois (
    id INT AUTO_INCREMENT PRIMARY KEY,
    domain_id INT,
    whois_age INT,
    whois_create_date DATE,
    whois_expire_date DATE,
    whois_is_private BOOLEAN,
    whois_reg_email VARCHAR(255),
    whois_reg_name VARCHAR(255),
    FOREIGN KEY (domain_id) REFERENCES domains(id)
);
```

### 3. **Populating the Tables**

Once the tables are created, populate them by parsing the JSON data and inserting the relevant data into the respective tables.

Here's a simplified example of how to insert data into the `domains` table:

```sql
INSERT INTO domains (
    domain_name, sld, tld, category, language, char_pattern, num_hyphens, num_numbers, num_words, is_cctld, is_ntld, has_dns, traffic_estimate, pagerank, wayback_age, wayback_records
) VALUES (
    'zwry.com', 'zwry', 'com', 'Other -- Common Adjectives', 'english', 'CCCC', 0, 0, 1, 0, 0, 1, 0, 0, 2006, 8
);
```

### 4. **Considerations**

- **Normalization**: The design above normalizes the data by splitting it into multiple related tables. This avoids data redundancy.
- **Indexes**: The creation of indexes on frequently queried columns will insure better performance.
- **Foreign Keys**: The use of foreign keys ensures data integrity between the related tables.
