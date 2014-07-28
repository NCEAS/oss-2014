# SQL tutorial notes

## Create postgres user accounts for all participants

In order to connect to a postgres database, you must have an account that grants you permission to connect, and to perform the other operations you need, such as creating tables or reading data from tables.  In general, users can be created with the commandline utility:

- createuser -d -e -E -l -r -s <username>

Specifically, I have already created accounts for course participants using a bash script as follows:

```bash
for un in `cat ~jones/nceasSI-accounts`; do echo "Creating $un..."; createuser -d -e -E -l -r -s $un; echo "Done with $un."; done
```

## Creating a database

Users that are authorized can create a database, either at the main sql prompt, or via the `createdb` command line utility.  Use the following commands to create a database for yourself, ensuring that you change the name of your database to use your username.

```bash
# Create a database for yourself and connect to it
createdb testdb_jones # Ensure this uses your own username
psql testdb_jones
\?
\d
\pset pager
```

## Create a table

Once you have a database for which you have write access, you can create tables, add data to those tables, and manipulate them. Tables are relations that contain data following a set of constraints that you establish in a table definition.  

```sql
-- Create a table
CREATE TABLE sites (
	siteid INT8,
	altitude INT8, 
	habitat VARCHAR(25), 
	CONSTRAINT site_pk PRIMARY KEY (siteid)
);
```

## Inspect the table that was created

Postgres provides tools for inspecting the objects in your schema, and you can see the list of all of your tables and other objects using `\d`. Once the object exists, you can issye a `SQL SELECT` to view the data in the table.  In this case, the table has no rows yet, and so the `SELECT` command shows zero rows returned.

```sql
\d
\d sites
SELECT * FROM sites;
```

## Insert data

Inserting data can be done one row at a time using the `INSERT` command.  With this command, you name the table to be inserted into, the fields that you want to populate, and a list of values to be populated.  Depending on how the table was created, some columns may have default values set which will be created even if that row is not manipulated.

```sql
-- INSERT SOME DATA INTO THE TABLE
INSERT INTO sites (siteid, altitude, habitat) VALUES (1, 722, 'riparian');
INSERT INTO sites (siteid, altitude, habitat) VALUES (2, 805, 'riparian');
INSERT INTO sites (siteid, altitude, habitat) VALUES (3, 887, 'mixed');
INSERT INTO sites (siteid, altitude, habitat) VALUES (4, 920, 'mixed');
INSERT INTO sites (siteid, altitude, habitat) VALUES (5, 110, 'forest');
INSERT INTO sites (siteid, altitude, habitat) VALUES (6, 192, 'mixed');
INSERT INTO sites (siteid, altitude, habitat) VALUES (7, 121, 'forest');
INSERT INTO sites (siteid, altitude, habitat) VALUES (8, 108, 'riparian');
INSERT INTO sites (siteid, altitude, habitat) VALUES (9, 722, 'riparian');
INSERT INTO sites (siteid, altitude, habitat) VALUES (10, 805, 'riparian');
INSERT INTO sites (siteid, altitude, habitat) VALUES (11, 887, 'mixed');
INSERT INTO sites (siteid, altitude, habitat) VALUES (12, 920, 'mixed');
INSERT INTO sites (siteid, altitude, habitat) VALUES (13, 110, 'forest');
INSERT INTO sites (siteid, altitude, habitat) VALUES (14, 192, 'mixed');
INSERT INTO sites (siteid, altitude, habitat) VALUES (15, 121, 'forest');
INSERT INTO sites (siteid, altitude, habitat) VALUES (16, 108, 'riparian');
INSERT INTO sites (siteid, altitude, habitat) VALUES (17, 722, 'riparian');
INSERT INTO sites (siteid, altitude, habitat) VALUES (18, 805, 'riparian');
INSERT INTO sites (siteid, altitude, habitat) VALUES (19, 887, 'mixed');
INSERT INTO sites (siteid, altitude, habitat) VALUES (20, 920, 'mixed');
INSERT INTO sites (siteid, altitude, habitat) VALUES (21, 110, 'forest');
INSERT INTO sites (siteid, altitude, habitat) VALUES (22, 192, 'mixed');
INSERT INTO sites (siteid, altitude, habitat) VALUES (23, 121, 'forest');
INSERT INTO sites (siteid, altitude, habitat) VALUES (24, 108, 'riparian');
INSERT INTO sites (siteid, altitude, habitat) VALUES (25, 722, 'riparian');
INSERT INTO sites (siteid, altitude, habitat) VALUES (26, 805, 'riparian');
INSERT INTO sites (siteid, altitude, habitat) VALUES (27, 887, 'mixed');
INSERT INTO sites (siteid, altitude, habitat) VALUES (28, 920, 'mixed');
INSERT INTO sites (siteid, altitude, habitat) VALUES (29, 110, 'forest');
INSERT INTO sites (siteid, altitude, habitat) VALUES (30, 192, 'mixed');
INSERT INTO sites (siteid, altitude, habitat) VALUES (31, 121, 'forest');
INSERT INTO sites (siteid, altitude, habitat) VALUES (32, 108, 'riparian');
```

## How to query

Queries against database tables are performed using the `SELECT` command, which allows you to specify which tables to query, and any query conditions to be met.  For example, start with a simple select that just returns all of the rows of the `sites` table.  Then issue queries that select the 'habitat' column from the sites table.  And finally, select the 'habitat' column, and sort it.

```sql
-- SIMPLE SELECTs
SELECT * from sites;
SELECT habitat from sites;
SELECT habitat from sites order by habitat;
```

## Adding constraints

The `WHERE` clause is used to impose constraints on the query, such that all constraints must be met for any given row to be returned.  Below, we first search for all plots with an `altitude` value greater than 500, and then where the `habitat` value matches the string `scrub`.

```sql
-- SELECT with a constraint
SELECT * from sites where altitude > 500;
SELECT * from sites where habitat = 'scrub';
```

# More complex constraints

Complex constraints can be constructed using boolean operators to logically combine clauses. All clauses must evaluate to `TRUE` for a constraint to be satisfied.  For example, below we request records with two constraints, which both must be met.

```sql
-- SELECT with a more complex constraint
SELECT * from sites where habitat = 'scrub' AND altitude > 500;
```
# Group functions

SQL provides the ability to group results using a grouping variable along with an aggregation function.  This allows calculation of the sum of a column grouped by another column (e.g., sum of tree height by species).  In the example below, we count the number of records in each habitat.  To use `group by`, records must be sorted by the gourping variables, which is accomplished with the `order by` clause.

```sql
-- SELECT with an aggregation function using group by
SELECT habitat, count(*) from sites group by habitat order by habitat;
```

## Integrity constraints

```sql
-- INTEGRITY CONSTRAINTS: PRIMARY KEY ENFORCEMENT
INSERT INTO sites (siteid, altitude, habitat) VALUES (1, 721, 'scrub');
```

## Updating records by changing the values (think twice before doing this)

```sql
-- UPDATE
UPDATE sites SET altitude=721 where siteid=1;
```

## Deleting a record

```sql
-- DELETE
INSERT INTO sites (siteid, altitude, habitat) VALUES (33, 121, 'forest');
SELECT count(*) from sites;
DELETE from sites where siteid=33;
```

## Transactions: ensuring the success of all operations

```sql
-- TRANSACTIONS
INSERT INTO sites (siteid, altitude, habitat) VALUES (33, 121, 'forest');
START TRANSACTION;
   DELETE FROM sites WHERE siteid > 7;
SELECT * from sites order by siteid;
-- Oh Crap!
ROLLBACK;
SELECT * from sites order by siteid;
```

```sql
-- Try again to delete the right set of rows
START TRANSACTION;
DELETE FROM sites WHERE siteid > 32;
SELECT * from sites order by siteid;
COMMIT;
```

# Using `COPY` for larger databases

```sql
-- CREATE ANOTHER TABLE THAT WILL BE RELATED TO site
CREATE TABLE plotobs (
	obsid INT8,
	siteid INT8, 
	plot CHAR(10), 
	date_sampled DATE, 
	sciname VARCHAR(100),
	diameter NUMERIC,
	condition VARCHAR(10),
	CONSTRAINT plotobs_pk PRIMARY KEY (obsid),
	CONSTRAINT plotobs_site_fk FOREIGN KEY (siteid) REFERENCES sites
);
```

```sql
-- Batch load data from a CSV file
COPY plotobs FROM '/home/jones/training/2014-oss/day-08/sql-basics/plotobs.csv' DELIMITER ',' CSV HEADER;
```

## Calulating an average

```sql
-- ANOTHER AGGREGATION QUERY
SELECT sciname, avg(diameter) FROM plotobs GROUP BY sciname ORDER BY sciname;
```

## Inner joins
	
```sql
-- SIMPLE INNER JOIN
SELECT s.siteid, s.altitude, p.obsid, p.plot, p.sciname, p.diameter FROM sites s, plotobs p WHERE p.siteid = s.siteid;
```

## Concatenate query results

```sql
-- UNION for concatenating results of two queries
SELECT * FROM plotobs WHERE diameter > 30
UNION
SELECT * FROM plotobs WHERE diameter < 10;
```

## Merge query results

```sql
-- INTERSECT for finding common results between two queries
SELECT * FROM plotobs WHERE diameter > 30
INTERSECT
SELECT * FROM plotobs WHERE diameter < 35;
```

-- NOT COVERING OUTER JOINS

