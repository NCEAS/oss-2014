SQL tutorial notes
==================

-- Create postgres user accounts for all participants
    -- createuser -d -e -E -l -r -s <username>
    -- for un in `cat ~jones/nceasSI-accounts`; do echo "Creating $un..."; createuser -d -e -E -l -r -s $un; echo "Done with $un."; done

-- Create a database for yourself and connect to it
	createdb testdb_jones
	psql testdb_jones
	\?
	\d
	\pset pager

-- Create a table
    CREATE TABLE sites (
		siteid INT8,
		altitude INT8, 
		habitat VARCHAR(25), 
		CONSTRAINT site_pk PRIMARY KEY (siteid)
	);

-- INSPECT THE TABLE THAT WAS CREATED
	\d
	\d sites
	SELECT * FROM sites;

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

-- SIMPLE SELECTs
	SELECT * from sites;
	SELECT habitat from sites;
	SELECT habitat from sites order by habitat;

-- SELECT with a constraint
	SELECT * from sites where altitude > 500;
	SELECT * from sites where habitat = 'scrub';

-- SELECT with a more complex constraint
	SELECT * from sites where habitat = 'scrub' AND altitude > 500;

-- SELECT with an aggregation function using group by
	SELECT habitat, count(*) from sites group by habitat order by habitat;

-- INTEGRITY CONSTRAINTS: PRIMARY KEY ENFORCEMENT
	INSERT INTO sites (siteid, altitude, habitat) VALUES (1, 721, 'scrub');

-- UPDATE
	UPDATE sites SET altitude=721 where siteid=1;

-- DELETE
	INSERT INTO sites (siteid, altitude, habitat) VALUES (33, 121, 'forest');
	SELECT count(*) from sites;
	DELETE from sites where siteid=33;

-- TRANSACTIONS
	INSERT INTO sites (siteid, altitude, habitat) VALUES (33, 121, 'forest');
	START TRANSACTION;
    DELETE FROM sites WHERE siteid > 7;
	SELECT * from sites order by siteid;
	-- Oh Crap!
	ROLLBACK;
	SELECT * from sites order by siteid;
    
	-- Try again to delete the right set of rows
	START TRANSACTION;
    DELETE FROM sites WHERE siteid > 32;
	SELECT * from sites order by siteid;
	COMMIT;

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

-- Batch load data from a CSV file
	COPY plotobs FROM '/home/jones/plotobs.csv' DELIMITER ',' CSV HEADER;

-- ANOTHER AGGREGATION QUERY
	SELECT sciname, avg(diameter) FROM plotobs GROUP BY sciname ORDER BY sciname;
	
-- SIMPLE INNER JOIN
	SELECT s.siteid, s.altitude, p.obsid, p.plot, p.sciname, p.diameter FROM sites s, plotobs p WHERE p.siteid = s.siteid;

-- UNION for concatenating results of two queries
SELECT * FROM plotobs WHERE diameter > 30
UNION
SELECT * FROM plotobs WHERE diameter < 10;

-- INTERSECT for finding common results between two queries
SELECT * FROM plotobs WHERE diameter > 30
INTERSECT
SELECT * FROM plotobs WHERE diameter < 35;

-- NOT COVERING OUTER JOINS

