set character_set_client=utf8;
set character_set_results=utf8;
set character_set_connection=utf8;
set character_set_server=utf8;
set character_set_database=utf8;
DROP TABLE IF EXISTS `data`;
create table data(nd int(10) primary key, jh int(10), ji int(10), gh int(10), gi int(10), gc int(10), cn int(10) );
load data local infile "seoul_air.csv" into table data fields terminated by ',' enclosed by '"' lines terminated by '\n' ignore 1 rows;
