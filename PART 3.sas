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
/* We could get the targetregion, that is sslati = (40.7111,40.71472) eslati=(40.70074,40.70436) sslongi = (-74.01258, -74.00782) eslongi = (-74.0151,-74.01034) */

/* create two new variables on the Taxi dataset */
DATA Taxi;
	SET Taxi;
	IF ((_pickup_latitude GE 40.7111) AND (_pickup_latitude LE 40.71472))
	 	AND 
	 	((_pickup_longitude GE -74.01258) AND (_pickup_longitude LE -74.00782))
		THEN 
		start_within = "T";
	ELSE 
		start_within = "F";
	IF ((_dropoff_latitude GE 40.70074) AND (_dropoff_latitude LE 40.70436))
	 	AND 
	 	((_dropoff_longitude GE -74.0151) AND (_dropoff_longitude LE -74.01034))
		THEN 
		end_within = "T";
	ELSE 
		end_within = "F";
RUN;

PROC CONTENTS DATA = Taxi;
RUN;

/* 2 */
/* modify the Taxi and Bike dataset */
DATA Taxi;
	SET Taxi;
	IF start_within = "T" AND end_within = "T";
RUN;

DATA Bike;
	SET Bike;
	IF ssid EQ "417" AND esid EQ "534";;
RUN;

/* Create a new dataset called TargetTrips */
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
/* Output the density curve for the time of trip duration */
ODS LISTING GPATH = "/folders/myfolders/dataset" STYLE = JOURNAL;

PROC SGPANEL DATA = TargetTrips;
	PANELBY type / ROWS = 2 ;
	TITLE "Trip Duration for Bike and Taxi";
	DENSITY trip_duration;	
	COLAXIS LABEL = "Time of Trip Duration"; 
	ROWAXIS LABEL = "Density";
	KEYLEGEND / 
		TITLE = "The Type of Density Curve" ;
RUN;	