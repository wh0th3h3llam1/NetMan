rem Batch Script to reset network configuration for Windows.
rem

@echo off


echo Releasing I.P. Address...
ipconfig /release
IF ERRORLEVEL 1 (
	echo Couldn't Release I.P. Address
	EXIT /B 1
)

echo Checking if IP adddress is released...
ipconfig /all | findstr "IPv4"

echo Flushing DNS...
ipconfig /flushdns
IF ERRORLEVEL 1 (
	echo Couldn't Flush DNS
	EXIT /B 1
)

echo Renewing I.P. Address...
ipconfig /renew
IF ERRORLEVEL 1 (
	echo Couldn't Renew I.P. Address
	EXIT /B 1
)

echo Setting the New DNS...
netsh int ip set dns
IF ERRORLEVEL 1 (
	echo Couldn't Set New DNS
	EXIT /B 1
)

echo Resetting the Winsock...
netsh winsock reset
IF ERRORLEVEL 1 (
	echo Couldn't Reset Winsock
	EXIT /B 1
)

echo.
echo Network Settings Reset Successfully.
echo.
echo Reboot the System for changes to take place.
echo.

SET /p choice="Do you want to Reboot the System? [Y/n] : "

IF %choice%==y (
	echo.
	echo Rebooting the System in 20 Seconds...
	echo Type shutdown /a to cancel
	shutdown /r /t 20
	PAUSE

) ELSE (
	echo.
	echo Please Reboot the System for the changes to take place...
)
