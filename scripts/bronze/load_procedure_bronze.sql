/*
===================================================================================================================================================================
                                                      Stored Procedure: Load Bronze Layer with the data from the source system
===================================================================================================================================================================
Description:
    The stored procedure loads data from the source system's CSV files into the bronze schema.
    It performs the following actions:
        1- Truncate the bronze tables before loading data.
        2- Uses BULK INSERT to load data from the CSV Files to the bronze tables
        3- Measures the time that data takes to be loaded into the tables.

    Parameters:
        None --> this stored procedure does not take any parameters or return any values.

    Usage Example:
        EXEC bronze.load_bronze;
===================================================================================================================================================================
*/

exec bronze.load_bronze;

create or alter procedure bronze.load_bronze
as
begin

	declare @start_time datetime, @end_time datetime, @batch_start_time datetime, @batch_end_time datetime
	begin try
	
		set @batch_start_time = getdate()
		print '################################################'
		print '########### Loading the bronze layer ###########'
		print '################################################'

		print '------------------------------------------------';
		print '--------- loading bronze.Traffic table ---------';
		print '------------------------------------------------';

		set @start_time = getdate()
		print '>> Truncating bronze.Traffic';
		truncate table bronze.Traffic;
		
		print '>> Loading bronze.Traffic';
		bulk insert bronze.Traffic
		from 'D:\Important\Depi\Microsoft Data Engineering\Graduation Project\Project\Data Sets\fact\Traffic.csv'
		WITH (
			FIRSTROW = 2,  
			FIELDTERMINATOR = ',',
			tablock
		);
		set @end_time = getdate()
		print 'Load Duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + ' seconds'

		print '------------------------------------------------';
		print '---------- loading bronze.Date table -----------';
		print '------------------------------------------------';

		set @start_time = getdate()
		print '>> Truncating bronze.Date';
		truncate table bronze.Date;

		print '>> Loading bronze.Date';
		bulk insert bronze.Date
		from 'D:\Important\Depi\Microsoft Data Engineering\Graduation Project\Project\Data Sets\dimensions\Date.csv'
		WITH (
			FIRSTROW = 2,  
			FIELDTERMINATOR = ',',
			tablock
		);
		set @end_time = getdate()
		print 'Load Duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + ' seconds'

		print '------------------------------------------------';
		print '----- loading bronze.LocalAuthority table ------';
		print '------------------------------------------------';

		set @start_time = getdate()
		print '>> Truncating bronze.LocalAuthority';
		truncate table bronze.LocalAuthority;

		print '>> Loading bronze.LocalAuthority';
		bulk insert bronze.LocalAuthority
		from 'D:\Important\Depi\Microsoft Data Engineering\Graduation Project\Project\Data Sets\dimensions\LocalAuthority.csv'
		WITH (
			FIRSTROW = 2,  
			FIELDTERMINATOR = ',',
			tablock
		);
		set @end_time = getdate()
		print 'Load Duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + ' seconds'

		print '------------------------------------------------';
		print '--------- loading bronze.Location table --------';
		print '------------------------------------------------';

		set @start_time = getdate()
		print '>> Truncating bronze.Location';
		truncate table bronze.Location;

		print '>> Loading bronze.Location';
		bulk insert bronze.Location
		from 'D:\Important\Depi\Microsoft Data Engineering\Graduation Project\Project\Data Sets\dimensions\Location.csv'
		WITH (
			FIRSTROW = 2,  
			FIELDTERMINATOR = ',',
			tablock
		);
		set @end_time = getdate()
		print 'Load Duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + ' seconds'

		print '------------------------------------------------';
		print '--------- loading bronze.Region table ----------';
		print '------------------------------------------------';

		set @start_time = getdate()
		print '>> Truncating bronze.Region';
		truncate table bronze.Region;

		print '>> Loading bronze.Region';
		bulk insert bronze.Region
		from 'D:\Important\Depi\Microsoft Data Engineering\Graduation Project\Project\Data Sets\dimensions\Region.csv'
		WITH (
			FIRSTROW = 2,  
			FIELDTERMINATOR = ',',
			tablock
		);
		set @end_time = getdate()
		print 'Load Duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + ' seconds'

		print '------------------------------------------------';
		print '---------- loading bronze.table Road -----------';
		print '------------------------------------------------';

		set @start_time = getdate()
		print '>> Truncating bronze.Road';
		truncate table bronze.Road;

		print '>> Loading bronze.Road';
		bulk insert bronze.Road
		from 'D:\Important\Depi\Microsoft Data Engineering\Graduation Project\Project\Data Sets\dimensions\Road.csv'
		WITH (
			FIRSTROW = 2,  
			FIELDTERMINATOR = ',',
			tablock
		);
		set @end_time = getdate()
		print 'Load Duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + ' seconds'

		set @batch_end_time = getdate()
		print '################################################'
		print 'Loading Bronze Layer Is Compeleted'
		print '    - Total Time Duration: ' + cast(datediff(second, @batch_start_time, @batch_end_time) as nvarchar) + ' seconds'
		print '################################################'

	end try
	
	begin catch
		print'============================================================================================================================================================================'
		print'ERROR OCCURED DURING  LOADING BRONZE LAYER';
		print'ERROR MESSAGE' + ERROR_MESSAGE();
		print'ERROR MESSAGE' + CAST (ERROR_MESSAGE() AS NVARCHAR);
		print'ERROR MESSAGE' + CAST (ERROR_STATE() AS NVARCHAR);
		print'============================================================================================================================================================================'
	end catch

end
