* 16.10.15;
* STAT 5430 - Macro Basics;
* Amber Tomas;


OPTION MPRINT; /* use this option to see how your macros are resolved by the macro compiler */

************
* macro statements and variables
***********;

* Macro statements always start with a % ;

* Macro variables can be created with the %LET statement;
* To invoke a macro variable, prefix its name with a & ;
* Macro variables are global - they can be defined and
  used anywhere in your program;


* Example: Sashelp.Adsmsg;

%LET levelval = W;

DATA _NULL_;
	PUT "Value of levelval macro variable is &levelval";
	PUT 'Value of levelval macro variable is &levelval'; /* text within single quotes is ignored by the macro compiler - use double quotes if you want to include macro variables within strings! */
RUN; 

%PUT Value of levelval macro variable is &levelval;

%PUT _GLOBAL_;
%PUT _ALL_;

%PUT Today is  &SYSDAY;

* Going back to Adsmsg;

DATA Adsmsg_W;
	SET Sashelp.Adsmsg;
	WHERE level EQ "&levelval"; /* when compiled, &levelval is replaced with the value of that macro variable, so this is equivalent to IF level EQ "W" */
RUN;

PROC PRINT DATA = Adsmsg_W;
	TITLE "Observations of Sashelp.Adsmsg with level equal to &levelval";
RUN;

*********
* macros
*********;

* Macros can be used to easily run a program multiple times, using different values of macro variables each time;
* All macros start with %MACRO and end with %MEND;

* Macro to print observations of Adsmsg for a value of level;

%MACRO Adsprint;
	
	DATA Adsmsg_lev;
		SET Sashelp.Adsmsg;
		IF level = "&levelval";
	RUN;

	PROC PRINT data = Adsmsg_lev;
		TITLE "Observations of Sashelp.Adsmsg with level equal to &levelval";
	RUN;

%MEND Adsprint;

%Adsprint /* note: do not need semi-colon since macro processor replaces macro invocation with compiled SAS code (which consists of statements ending in semi-colons) */

%LET levelval = Q;
%Adsprint

* But even better that using %LET statements to change values of macro variables, add a macro parameter;


*************
* adding parameters to macros
*************;


* Positional and keyword parameters:;
* Positional parameters - must be specified (and in the same order) when the macro is invoked;
* Keyword parameters - do not need to be specified when the macro is invoked;
* A keyword parameter is one followed by an = in the %MACRO statement;
* Positional parameters must be listed before any keyword parameters;
* If you want to set a default value for a parameter, use a keyword parameter;

* Here, levelval is a positional parameter:;

%MACRO Adsprint2(levelval);
	
	DATA Adsmsg_lev;
		SET Sashelp.Adsmsg;
		IF level = "&levelval";
	RUN;

	PROC PRINT data = Adsmsg_lev;
		TITLE "Observations of Sashelp.Adomsg with level equal to &levelval";
	RUN;

%MEND Adsprint2;

%Adsprint2(Q)
%Adsprint2(E)


************
* call symput
***********;

* call symput is a call routine that assigns a value of a variable in a SAS dataset to a macro variable;
* This allows you to use a value from a SAS dataset in expressions etc;
* call symput can only be used in DATA steps;

* Find Make with biggest engine size then print out all 
	cars of this make;

PROC SORT DATA = Sashelp.Cars OUT = SortCars;
	BY DESCENDING EngineSize;
RUN;

DATA temp;
	SET SortCars (OBS = 1);
	CALL SYMPUT("bigmake", Make);

RUN;

%PUT _GLOBAL_;

PROC PRINT data = Cars;
	WHERE Make EQ "&bigmake";
RUN;


*********
* conditional execution
*********;


* %IF %THEN %ELSE can be used to conditionally execute DATA steps and/or PROC steps
  within a macro;


* Example - macro with two parameters: &numvar - the name of a numeric variable in Sashelp.Cars
 and &plot - takes the value TRUE or FALSE
* If &plot EQ TRUE then plot a histogram of the distribution of the observations in the lowest quartile of &numvar
* Else just print out the observations in the lowest quartile to the results viewer;


%MACRO plotq1(numvar, plot = FALSE);

	* first, find Q1 of &numvar and assign it to a macro variable &q1var;
	PROC MEANS DATA = Sashelp.Cars NOPRINT;
		OUTPUT OUT = car_stats
			Q1(&numvar) = &numvar_q1;
	RUN;

	DATA _NULL_;
		SET car_stats;
		CALL SYMPUT(“q1var”, &numvar_q1);
	RUN;

	* subset dataset;

	DATA cars_q1;
		SET Sashelp.Cars;
		WHERE &numvar LT &q1var;
	RUN;

	* Now, make plot or print dataset;

	%IF &plot EQ FALSE %THEN %DO;
		TITLE “Observations in first quartile of &numvar”;
		PROC PRINT DATA = cars_q1;
			VAR &numvar;
		RUN;
	%END;

	%ELSE %IF &plot EQ TRUE %THEN %DO;
		TITLE “Distribution of observations in first quartile of &numvar”;
		PROC SGPLOT DATA = cars_q1;
			HISTOGRAM &numvar;
		RUN;
	%END;

	%ELSE %PUT ‘&plot must be TRUE or FALSE’;

%MEND plotq1;



