if (([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
	Write-Output 'Running as Administrator!'
	Write-Output '[SETUP] Installing BurntToast!'
	Install-Module -Name BurntToast
	Write-Output '[SETUP] BurntToast Installed Successfully'
}
else
{
	Write-Output 'Running Limited!'

	Write-Output "Can't Install Module Without Administrator Access!"
}
