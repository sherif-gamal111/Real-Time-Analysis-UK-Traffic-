/*
==================================================================================================================================================================
                                                                  DDL Script --> Create Bronze Tables
==================================================================================================================================================================
Script Purpose:
    This script creates tables in the Bronze Schema, at the first query, checks if the table exists, drops it if not creates one.
    Run this script to redefine the DDL structure of Bronze tables.
==================================================================================================================================================================    
*/

if object_id('bronze.Traffic','U') is not null
	drop table bronze.Traffic;
go
create table bronze.Traffic(
	count_point_id int,
	road_name varchar(30),
	region_id int,
	local_authority_id int,
	direction_of_travel varchar(20), 
	hour int,
	direction varchar(20),
	pedal_cycles int,
	two_wheeled_motor_vehicles int,
	cars int,
	buses int,
	LGVs int,
	HGVs_2_rigid_axle int,
	HGVs_3_rigid_axle int,
	HGVs_4_rigid_axle int,
	HGVs_4_articulated_axle int,
	HGVs_5_articulated_axle int,
	HGVs_6_articulated_axle int,
	all_HGVs int,
	all_motor_vehicles int
)

if object_id('bronze.Date','U') is not null
	drop table bronze.Date;
go
create table bronze.Date(
	count_date date,
	day int,
	month int,
	year int
)

if object_id('bronze.LocalAuthority','U') is not null
	drop table bronze.LocalAuthority;
go
create table bronze.LocalAuthority(
	local_authority_id int,
	local_authority_name varchar(30),
	local_authority_code varchar(50)
)

if object_id('bronze.Location','U') is not null
	drop table bronze.Location;
go
create table bronze.Location(
	easting int,
	northing int,
	latitude int,
	longitude int,
	region_id int,
	local_authority_id int
)

if object_id('bronze.Region','U') is not null
	drop table bronze.Region;
go
create table bronze.Region(
	region_id int,
	region_name varchar(50),
	region_ons_code varchar(50)
)

if object_id('bronze.Road','U') is not null
	drop table bronze.Road;
go
create table bronze.Road(
	road_name varchar(50),
	road_category varchar(30),
	road_type varchar(30),
	start_junction_road_name varchar(70),
	end_junction_road_name varchar(70),
	link_length_km decimal
)
