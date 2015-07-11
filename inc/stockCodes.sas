/************************************************************
* NOME PROGRAMMA: stockCodes.sas							*
* DESCRIZIONE   : main file del progetto Capital Market		*
* CHIAMATO DA   : main.sas									*
* CHIAMA        : //										*
* PROGRAMMATORE : Federico Viscioletti						*
* DATA CREAZIONE: 28/12/2014								*
*************************************************************
* FILE(S) INPUT : //										*
* FILE(S) OUTPUT: CAPM.STOCK_CODES							*
*************************************************************
* MODIFICHE     : //										*
* ------------  : 											*
* DATA          : //										*
* MODIFICA #    : //										*
* PROGRAMMATORE : //				 						*
* DESCRIZIONE   : //										*
************************************************************/

proc import datafile="C:\Users\Federico\Documents\My SAS Files\9.3\capm\raw data\stock_codes.csv"
		out=capm.stock_codes_csv
		dbms=dlm replace;
	delimiter=";";
	getnames=yes;
run;

proc import datafile="C:\Users\Federico\Desktop\FTSE_MIB-03012007.csv"
		out=capm.ftse_mib
		dbms=dlm replace;
	delimiter=";";
	getnames=yes;
run;
/*
data CAPM.stock_codes;
   	length id 3 stock_code $20 stock_name $15 stock_des $50;
	infile datalines delimiter=','; 
   	input id stock_code $ stock_name $ stock_des $;
   	datalines;
1,AAPL,APPLE,Apple Inc.
2,AMZN,AMAZON,Amazon.com Inc.
3,BNP.MI,BNP_IT,BNP Paribas
4,BRK-A,BRK_A,Berkshire Hathaway Inc.
5,FB,FACEBOOK,Facebook Inc.
6,GE,GEN_ELEC,General Electric Company Common
7,GOOG,GOOGLE,Google
8,HSBC,HSBC,HSBC Holdings plc. Common
9,JNJ,JOHN_N_JOHN,Johnson & Johnson
10,JPM,JP_MORGAN,J.P. Morgan Chase & Co. Common St
11,MSFT,MICROSOFT,Microsoft Corporation
12,NSRGY,NESTLE_SA,Nestlé S.A.
13,NVS,NOVARTIS,Novartis AG
14,PG,PROC_GAMB,Procter & Gamble Company
15,RDS-B,ROYAL_DUTCH,Royal Dutch Shell PLC
16,ROG.VX,ROCHE_HLDG,Roche Holding AG
17,TM,TOYOTA,Toyota Motor Corporation
18,WFC,WELLS_FARGO,Wells Fargo & Company
19,WMT,WAL_MART,Wal-Mart Stores Inc. 
20,XOM,EXXON_MOBIL,Exxon Mobil Corporation Common
; 
run;
*/

data CAPM.stock_indexes;
	length id 3 stock_code $20 stock_name $15 stock_des $50;
	infile datalines delimiter=',';
	input id stock_index_code $ stock_index_name $ stock_index_des $;
	datalines;
1,%5EDJI,DOW_JONES,Dow Jones Industrial Average
2,FTSEMIB.MI,FTSEMIB,FTSEMIB
;
run;
