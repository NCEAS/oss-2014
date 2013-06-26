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
    INSERT INTO sites (siteid, altitude, habitat) VALUES (1, 722, 'scrub');
    INSERT INTO sites (siteid, altitude, habitat) VALUES (2, 805, 'scrub');
    INSERT INTO sites (siteid, altitude, habitat) VALUES (3, 887, 'grass');
    INSERT INTO sites (siteid, altitude, habitat) VALUES (4, 920, 'grass');
    INSERT INTO sites (siteid, altitude, habitat) VALUES (5, 110, 'forest');
    INSERT INTO sites (siteid, altitude, habitat) VALUES (6, 192, 'scrub');
    INSERT INTO sites (siteid, altitude, habitat) VALUES (7, 121, 'forest');
    INSERT INTO sites (siteid, altitude, habitat) VALUES (8, 108, 'grass');

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
	UPDATE sites set altitude=721 where siteid=1;

-- DELETE
	INSERT INTO sites (siteid, altitude, habitat) VALUES (9, 121, 'forest');
	SELECT count(*) from sites;
	DELETE from sites where siteid=9;

-- TRANSACTIONS
	INSERT INTO sites (siteid, altitude, habitat) VALUES (9, 121, 'forest');
	START TRANSACTION;
    DELETE FROM sites WHERE siteid > 7;
	SELECT * from sites order by siteid;
	-- Oh Crap!
	ROLLBACK;
	SELECT * from sites order by siteid;
    
	-- Try again to delete the right set of rows
	START TRANSACTION;
    DELETE FROM sites WHERE siteid > 8;
	SELECT * from sites order by siteid;
	COMMIT;

-- CREATE ANOTHER TABLE THAT WILL BE RELATED TO site
    CREATE TABLE plotobs (
		obsid INT8,
		siteid INT8, 
		plot INT8, 
		subplot INT8, 
		date_sampled DATE, 
		sciname VARCHAR(100),
		abund INT8,
		pctcover INT8,
		CONSTRAINT plotobs_pk PRIMARY KEY (obsid),
		CONSTRAINT plotobs_site_fk FOREIGN KEY (siteid) REFERENCES sites
	);

-- Batch load data from a CSV file

	

-- ACID
-- CRUD

