@echo off

set internet="./internet.ps1"
set no_internet="./no_internet.ps1"

:loop

ping -n 2 -w 1000 google.com > NUL
if errorlevel 1 (
	rem echo No Internet
	Powershell.exe -executionpolicy remotesigned -File  %no_internet%

)else (
	rem echo Internet working
	Powershell.exe -executionpolicy remotesigned -File  %internet%
)

goto loop
