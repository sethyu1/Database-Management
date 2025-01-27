@ECHO OFF
REM ***************************************************************
REM Author:       Shiqi Yu
REM Date Written: June 19 2024
REM Purpose:      Generate a menu system so users can select what report to run
REM Date Revised: June 19 2024
REM Last Revised by: Shiqi Yu
REM **************************************************************
REM Display the menu. Validate the item selected and take appropriate action.
REM **************************************************************
:DisplayMenu
CLS
ECHO.
ECHO Home Report Generator
ECHO.
ECHO 1. Generate Home Report
ECHO 2. Exit
ECHO.
SET choice=
SET /P choice=Enter your choice: 
IF '%choice%'=='' GOTO NothingSelected
IF '%choice%'=='1' GOTO GenerateReport
IF '%choice%'=='2' GOTO ExitSelected
REM ***************************************************************
REM An invalid menu number was selected. Display an error then redisplay the menu.
REM ***************************************************************
ECHO.
ECHO Error - Invalid choice entered. Please choose a valid option.
ECHO.
PAUSE
GOTO DisplayMenu
REM ****************************************************************
REM The user just pressed enter. Display an error then redisplay the menu.
REM ****************************************************************
:NothingSelected
   ECHO.
   ECHO Error - No choice entered. Please choose an option displayed.
   ECHO.
   PAUSE
   GOTO DisplayMenu
REM *************************************************************
REM The user selected option 1. Generate the report, then redisplay the menu.
REM *************************************************************
:GenerateReport
    CLS
    IF NOT EXIST C:\DBMSDBII\A3\Reports MKDIR C:\DBMSDBII\A3\Reports
       REM SQLPLUS /nolog @Assignmentmp 

       SET /P homeID=Enter a valid HomeID:	
       ECHO Creating Report

       REM replace the -P switch with your password. replace -S switch with your server name
       sqlcmd -S SethCanada\GINSENG -i Home_Report.sql -o Home_Report.txt -U sa -P 147741 -v home_id=%homeID%

	PAUSE
    GOTO DisplayMenu
REM **************************************************************
REM The user selected termination. End the batch script.
REM **************************************************************
:ExitSelected