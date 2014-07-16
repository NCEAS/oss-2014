
-- insert custom spatial reference system
INSERT into spatial_ref_sys
  (srid, auth_name, auth_srid, proj4text, srtext)
  values (100001, 'sr-org', 100001,
    '+proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=23 +lon_0=-96 +x_0=0 +y_0=0 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs ',
    'PROJCS["Albers Conical Equal Area", GEOGCS["NAD83", DATUM["North_American_Datum_1983", SPHEROID["GRS 1980",6378137,298.2572221010002, AUTHORITY["EPSG","7019"]], TOWGS84[0,0,0,0,0,0,0], AUTHORITY["EPSG","6269"]], PRIMEM["Greenwich",0], UNIT["degree",0.0174532925199433], AUTHORITY["EPSG","4269"]], PROJECTION["Albers_Conic_Equal_Area"], PARAMETER["standard_parallel_1",29.5], PARAMETER["standard_parallel_2",45.5], PARAMETER["latitude_of_center",23], PARAMETER["longitude_of_center",-96], PARAMETER["false_easting",0], PARAMETER["false_northing",0], UNIT["metre",1, AUTHORITY["EPSG","9001"]]]'
);
