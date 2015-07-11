/************************************************************
* NOME PROGRAMMA: historyImport.sas							*
* DESCRIZIONE   : importazione dello storico di chiusura 	*
*				  degli indici nel progetto Capital Market	*
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

X "cd C:\Users\Federico\Documents\My SAS Files\9.3\capm";

%include "inc\lib.sas";

%include "inc\macro.sas";

%historyImport;
