/* Part 1.1.a */
FILENAME Trip '/folders/myfolders/Data/trip_data_10_subset.csv';
PROC IMPORT DATAFILE=Trip OUT=Taxi_Trip DBMS= CSV;
RUN;

PROC CONTENTS DATA=Work.Taxi_Trip;
RUN;

/* Part 1.1.b */
FILENAME Fare '/folders/myfolders/Data/trip_fare_10_subset.csv';
PROC IMPORT DATAFILE=Fare OUT=Taxi_Fare DBMS= CSV;
RUN;
PROC CONTENTS DATA=Work.Taxi_Fare;
RUN;

/* Part 1.2 */
DATA Taxi;
    MERGE Taxi_Trip Taxi_Fare;
RUN;

/* SAS Project PART 2 - BIKE DATA ANALYSIS */
/* 10/17/2015 */
/* Group 9 */

/* Prob. 1 Import the data into SAS as a dataset called Bike and make necessary adjustment ( formats, labels etc.) */

DATA Bike;
    INFILE '/folders/myfolders/Data/2013-10_Citi_Bike_trip_data_20K.csv' DLM = ',' DSD FIRSTOBS = 2 ;
    INFORMAT tripdu 8. starttime ANYDTDTM20. stoptime ANYDTDTM20. ssid $6. ssname $50. sslati 15.8 sslongi 15.8 esid $6. esname $50. eslati 15.8
	         eslongi 15.8 bikeid $6. usertp $12. btyear $6. gender $1.;

    /* the variable birthyear is read in as character variable because it includes missing value written as \N */

    FORMAT   tripdu 8. starttime DATETIME20. stoptime DATETIME20. ssid $6. ssname $50. sslati 15.8 sslongi 15.8 esid $6. esname $50. eslati 15.8
	         eslongi 15.8 bikeid $6. usertp $12. btyear $6. gender $1.;
    LABEL    tripdu = 'The duration of the trip in seconds'
	         starttime = 'Time the trip started'
			 stoptime = 'Time the trip ended'
			 ssid = 'Start station id'
			 ssname = 'Start station name'
			 sslati = 'Latitude of the start station'
			 sslongi = 'Longitude of the start station'
			 esid = 'End station id'
			 esname = 'End station name'
			 eslati = 'End station latitude'
			 eslongi = 'End station longitude'
             bikeid = 'ID number of the bike'
			 usertp = 'type of the bike user'
			 btyear = 'birthyear of the bike user'
			 gender = 'gender of the bike user'
			 ;
	INPUT    tripdu starttime stoptime ssid $ ssname $ sslati sslongi esid $ esname $ eslati eslongi bikeid $ usertp $ btyear $ gender $;
	IF btyear EQ '\N' THEN btyear = '';
	btyearnum = INPUT(btyear,4.);
	DROP btyear;
	RENAME btyearnum = btyear;    
RUN;
TITLE 'Check the imported data set';
PROC CONTENTS DATA = Bike;
RUN;
/* When we checked the contents, we found that the label and format of the new btyear variable was wiped out */
/* We added a new lable to birthyear in another data step */
DATA Bike;
    SET Bike;
    LABEL btyear = 'birthyear of the bike user';
RUN;

/* Prob.3 a) Find the earliest/latest date-time any trip started/ended */

PROC MEANS DATA = Bike NOPRINT;
	OUTPUT OUT = TripTime_range (DROP = _TYPE_ _FREQ_)
		MAX(starttime stoptime) = 
		MIN(starttime stoptime) = / AUTONAME ;
RUN;
TITLE 'Earliest and latest Start and stop Time';
PROC PRINT DATA = TripTime_range;
RUN;

/* 
   We got the results:
   Earliest Start Time = 01OCT2013:00:01:08 
   Latest Start Time = 01OCT2013:15:20:58 
   Earliest Stop Time = 01OCT2013:00:04:43 
   Latest Stop Time = 01OCT2013:18:39:41 
*/

/* Prob.3 b) Discard trips that were made at times outside of the range of taxi trips */
/* Get the taxi time range from Part 1 */
/* 
   Earliest Start Time = 01OCT13:07:00:00 
   Latest Start Time = 01OCT13:10:00:00 
   Earliest Stop Time =  01OCT13:07:01:26 
   Latest Stop Time =  01OCT13:12:52:19 
*/

DATA Bike;
    SET Bike;
    WHERE (starttime GE '01OCT2013:07:00:00'DT AND starttime LE '01OCT2013:10:00:00'DT) AND (stoptime GE '01OCT2013:07:01:26'DT AND stoptime LE '01OCT2013:12:52:19'DT);		
RUN;


			






/* Part Three */
/* 1 */
DATA Bike;
	Set Bike;
	IF ssid EQ "417" OR esid EQ "534";
Run;

PROC PRINT DATA = Bike;
RUN;

/* latitude and longitude of the target stations*/
/* 417	Barclay St & Church St	40.71291224	-74.01020234 */
/* 534	Water - Whitehall Plaza	40.70255065	-74.01272340 */
/* We could get the targetregion, that is sslati = (40.7111,40.71472) eslati=(40.70074,40.70436) sslongi = (-74.01258, -74.00782) eslongi = (-74.0151,-74.01034)

/* create two new variables on the Taxi dataset */
DATA Taxi;
	SET Taxi;
	IF (_pickup_latitude GE "40.7111") AND (_pickup_latitude LE "40.7111")
	 	AND (_pickup_longitude GE "-74.01258") AND (_pickup_longitude LE "-74.00782")
		THEN start_within = "TRUE";
	ELSE 
		start_within = "FLASE";
	IF IF (_dropoff_latitude GE "40.70074") AND (_dropoff_latitude LE "40.70436")
	 	AND (_dropoff_longitude GE "-74.0151") AND (_dropoff_longitude LE "-74.01034")
		THEN end_within = "TRUE";
	ELSE 
		end_within = "FLASE";
RUN;

PROC CONTENTS DATA = Taxi;
RUN;

/* 2 */
/* Create a new dataset called TargetTrips */
DATA Taxi;
	SET Taxi;
	IF start_within = "TRUE" AND end_within = "TRUE";
RUN;

DATA Bike;
	SET Bike;
	IF ssid EQ "417" AND esid EQ "534";;
RUN;

DATA TargetTrips;
	SET Bike (RENAME = (tripdu = trip_duration)) 
		Taxi(RENAME = (_trip_time_in_secs = trip_duration));
	IF bikeid EQ  . THEN type = "Taxi";
	ELSE type = "Bike";
RUN;

DATA TargetTrips;
	SET targettrips(KEEP = trip_duration type _fare_amount);
RUN;

PROC CONTENTS DATA = TargetTrips;
RUN;
	
/* 3 */
/* Print out a table that shows the minimum, mean, median, and maximum duration of trips for each mode of transport (bike and taxi), as well as the median fare */
PROC SORT DATA = TargetTrips;
	BY Type;
RUN;

PROC MEANS DATA = TargetTrips MEDIAN;
	OUTPUT OUT = stats(DROP = _TYPE_ _FREQ_)
		MEAN(trip_duration) = 
		MIN(trip_duration) = 
		MAX(trip_duration) = 
		MEDIAN(trip_duration) = 
		MEDIAN(_fare_amount) = / AUTONAME
		;
	BY Type;
RUN;
	
/* 4 */
DATA TargetTrips;
	SET TargetTrips;
	IF type = "Bike" THEN trip_duration1 = trip_duration;
	ELSE trip_duration2 = trip_duration;
RUN;

PROC SGPLOT DATA = TargetTrips;
	TITLE "Trip Duration for Bike and Taxi";
	DENSITY trip_duration1 / CURVELABEL = "Bike";
	DENSITY trip_duration2 / CURVELABEL = "Taxi";	
	XAXIS LABEL = "Time of Trip Duration"; 
	YAXIS LABEL = "Density";
	KEYLEGEND / 
		TITLE = "Type" 
		LOCATION = INSIDE 
		POSITION = TOPRIGHT ACROSS = 1;
RUN;	