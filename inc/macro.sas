/************************************************************
* NOME PROGRAMMA: macro.sas									*
* DESCRIZIONE   : file delle macro utilizzate nel progetto  *
*				  Capital Market							*
* CHIAMATO DA   : main.sas									*
* CHIAMA        : //										*
* PROGRAMMATORE : Federico Viscioletti						*
* DATA CREAZIONE: 28/12/2014								*
*************************************************************
* FILE(S) INPUT : CAPM.STOCK_CODES							*
* FILE(S) OUTPUT: HISTORY.AMAZON_HIST						*
*				  HISTORY.APPL_HIST							*
*				  HISTORY.BNP_IT_HIST						*
*				  HISTORY.GOOG								*
*************************************************************
* MODIFICHE     : //										*
* ------------  : 											*
* DATA          : //										*
* MODIFICA #    : //										*
* PROGRAMMATORE : //				 						*
* DESCRIZIONE   : //										*
************************************************************/

%macro historyImport();

	/* Preleva i nomi degli indici da importare dal relativo dataset */
	proc sql noprint;
		select count(*) into :nObs
		from capm.stock_codes;
	quit;
	
	/* setta la cartella dei raw data e la root dell'url di yahoo finance */
	%let rawDataFold = C:\Users\Federico\Documents\My SAS Files\9.3\capm\raw data\;
	%let urlRoot = http://ichart.yahoo.com/table.csv?s=;

	%do i = 1 %to &nObs;
		data _null_;
			set capm.stock_codes;
			if _n_ eq &i then do;
				call symput('stockCode', stock_code);
				call symput('stockName', stock_name);
			end;
		run;

		%let lowCaseStock = %sysfunc(lowcase(&stockCode));
		%let trimStock = %sysfunc(trim(&stockName));

		filename OUT "&rawDataFold.&lowCaseStock._hist.csv";

		proc http out=out 
				url="&urlRoot.&stockCode."
			method="get";
		run;

		proc import datafile="&rawDataFold.&lowCaseStock._hist.csv"
				out=&trimStock._HIST
				dbms=dlm replace;
			delimiter=",";
			getnames=yes;
		run;
		
		/* Controlla se il dataset esiste nella libreria HISTORY */
		%if %sysfunc(exist(HISTORY.&trimStock._HIST)) %then %do;
			proc sql noprint;
				select max(date) into :curLastDate
				from &trimStock._HIST;

				select max(date) into :histLastDate
				from HISTORY.&trimStock._HIST;
			quit;

			/* Aggiorno sempre l'ultima data disponibile a quella più aggiornata */
			%if &curLastDate. ge &histLastDate. %then %do;
				proc sql;
					delete from HISTORY.&trimStock._HIST where date eq &histLastDate.;

					create table HISTORY.&trimStock._HIST as
						select * from HISTORY.&trimStock._HIST
							outer union corr
						select * from &trimStock._HIST where date ge &histLastDate.;
				quit;

				proc sort data=HISTORY.&trimStock._HIST;
					by DESCENDING date;
				run; 
			%end;
		%end;
		/* Altrimenti inserisce direttamente il dataset estratto */
		%else %do;
			data HISTORY.&trimStock._HIST;
				set &trimStock._HIST;
			run;
		%end;
	%end;

	/* Preleva i nomi degli indici di borsa da importare dal relativo dataset */
	proc sql noprint;
		select count(*) into :nObs
		from capm.stock_indexes;
	quit;

	%do i = 1 %to &nObs;
		data _null_;
			set capm.stock_indexes;
			if _n_ eq &i then do;
				call symput('stockIndexCode', stock_index_code);
				call symput('stockIndexName', stock_index_name);
			end;
		run;

		%let lowCaseStockIndex = %sysfunc(lowcase(&stockIndexCode));
		%let trimStockIndex = %sysfunc(trim(&stockIndexName));

		filename OUT "&rawDataFold.&lowCaseStockIndex._hist.csv";

		proc http out=out 
				url="&urlRoot.&stockIndexCode."
				method="get";
		run;

		proc import datafile="&rawDataFold.&lowCaseStockIndex._hist.csv"
				out=&trimStock._HIST
				dbms=dlm replace;
			delimiter=",";
			getnames=yes;
		run;
		
		/* Controlla se il dataset esiste nella libreria HISTORY */
		%if %sysfunc(exist(HISTORY.&trimStockIndex._HIST)) %then %do;
			proc sql noprint;
				select max(date) into :curLastDate
				from &trimStockIndex._HIST;

				select max(date) into :histLastDate
				from HISTORY.&trimStockIndex._HIST;
			quit;

			/* Aggiorno sempre l'ultima data disponibile a quella più aggiornata */
			%if &curLastDate. ge &histLastDate. %then %do;
				proc sql;
					delete from HISTORY.&trimStockIndex._HIST where date eq &histLastDate.;

					create table HISTORY.&trimStockIndex._HIST as
						select * from HISTORY.&trimStockIndex._HIST
							outer union corr
						select * from &trimStockIndex._HIST where date ge &histLastDate.;
				quit;

				proc sort data=HISTORY.&trimStockIndex._HIST;
					by DESCENDING date;
				run; 
			%end;
		%end;
		/* Altrimenti inserisce direttamente il dataset estratto */
		%else %do;
			data HISTORY.&trimStockIndex._HIST;
				set &trimStockIndex._HIST;
			run;
		%end;
	%end;

%mend;
