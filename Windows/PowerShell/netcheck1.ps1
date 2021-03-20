# GitHub : http://github.com/wh0th3h3llam1
# Author : wh0th3h3llam1

# PowerShell script to check if your device has an internet connection.
# It will check for internet connection every n seconds.
# If state is changed, the script will notify you

# Version 0.1

function logo {
	Write-Host "          _      ___                  _ "
	Write-Host "__      _| |__  / _ \  __ _ _ __ ___ / |"
	Write-Host "\ \ /\ / / '_ \| | | |/ _\` | '_ \` _ \| |"
	Write-Host " \ V  V /| | | | |_| | (_| | | | | | | |"
	Write-Host "  \_/\_/ |_| |_|\___/ \__,_|_| |_| |_|_|"
	Write-Host "                                    v0.1"
	Write-Host ""
	Write-Host ""
	Write-Host "            _       _               _    "
	Write-Host " _ __   ___| |_ ___| |__   ___  ___| | __"
	Write-Host "| '_ \ / _ \ __/ __| '_ \ / _ \/ __| |/ /"
	Write-Host "| | | |  __/ || (__| | | |  __/ (__|   < "
	Write-Host "|_| |_|\___|\__\___|_| |_|\___|\___|_|\_\"
	Write-Host "                                     v0.1"
	Write-Host ""
	Write-Host ""

}

function install_burnt_toast {
	if (([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
	{
		Write-Output 'Running as Administrator!'
		Write-Output '[SETUP] Installing BurntToast!'
		Install-Module -Name BurntToast
	}
	else
	{
		Write-Output 'Running Limited!'

		Write-Output "Can't Install Module Without Administrator Access!"
	}
}

function setup
{
	if(Get-InstalledModule -Name BurntToast -MinimumVersion 0.7.2 2> $null)
	{
		Write-Host "[INFO] BurntToast is Installed"
	}
	else {
		Write-Host "[INFO] BurntToast is not Installed"
		Write-Host "[INFO] Installing BurntToast"
		# install_burnt_toast
		# PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& {Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File "".\setup.ps1""' -Verb RunAs}"

		$ThisScriptsDirectory="~dp0"

		$PowerShellScriptPath=$ThisScriptsDirectory + "setup.ps1"

		PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& {Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File ""$PowerShellScriptPath""' -Verb RunAs}";


		if($?)
		{
			continue
		}
		else
		{
			Write-Host "Error Installing BurntToast"
			exit 1
		}
	}
}


function init
{
	$major=(Get-Host).Version.Major
	$minor=(Get-Host).Version.Minor

	Write-Host "You are running on PowerShell Version $major.$minor"
	Write-Host ""

	$prev=0
	$delay=Read-Host "Enter Delay in Seconds [Default Value is Ten Sec] "

	# If PowerShell Version is 7 or Higher
	# if($major -ge 7)
	# {
	# 	$delay ?? 10
	# }

	if ($delay -eq 0) {
		exit 0
	}

	if (!$delay -or $delay -lt 0) {
		$delay=10
	}
	return $delay
}


function net_check ($delay)
{
	while($true)
	{
		ping -n 2 -w 1000 google.com > $null
		# ping -n 2 -w 1000 google.com | out-null

		if ($?)
		{
			Write-Host "Internet Working"
			[int] $flag=0
		}
		else
		{
			Write-Host "No Internet"
			[int] $flag=1
		}

		if ($prev -ne $flag)
		{
			$prev=$flag
			if ($flag -eq 0)
			{
				Write-Host "Internet Working"
				New-BurntToastNotification -Text "Internet Connection Restored", "You can Surf the Internet now" -AppLogo '..\check_mark.png'
			}
			else
			{
				Write-Host "No Internet"
				New-BurntToastNotification -Text "The Network is Down", "You will be Notified when Internet is Restored" -AppLogo '..\red_cross.png'
			}
		}

		Start-Sleep $delay
	}
}

logo
setup
$delay = init
net_check($delay)

