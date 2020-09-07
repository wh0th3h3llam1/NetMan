@ECHO OFF

SET internet=".\internet.ps1"
SET no_internet=".\no_internet.ps1"


:init
	SET /A prev=0

	SET /P "delay=Enter Delay in Seconds [Default Value is Ten Sec]:" || SET "delay=10"


:net_check

	ping -n 2 -w 1000 google.com > NUL

	IF ERRORLEVEL 1 (
		echo No Internet
		SET /A flag=1
	) ELSE (
		echo Internet working
		SET /A flag=0
	)

	rem IF NOT DEFINED prev SET "prev="
	IF [%prev%] NEQ [%flag%] (
		SET /A prev=%flag%

		rem :notifyAgain

		IF %flag% EQU 0 (
			echo Internet working
			echo Executing Internet.ps1

			Powershell.exe -executionpolicy remotesigned -File %internet%

			IF ERRORLEVEL 1 (
				echo "Error Executing internet.ps1"
				rem GOTO :notifyAgain
			)

			echo Executed Internet.ps1
		) ELSE (
			echo No Internet

			echo Executing No-Internet.ps1

			Powershell.exe -executionpolicy remotesigned -File %no_internet%

			IF ERRORLEVEL 1 (
				echo "Error Executing internet.ps1"
				rem GOTO :notifyAgain
			)
			echo Executed No-Internet.ps1
		)
	)

	timeout /t %delay% /nobreak > NUL

	GOTO net_check


rem https://ss64.com/nt/if.html
