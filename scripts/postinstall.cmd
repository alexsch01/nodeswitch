copy .\bin\nodeswitch.cmd %AppData%\npm
copy .\bin\nodeswitch.ps1 %AppData%\npm
if not exist %AppData%\nodeswitch ( mkdir %AppData%\nodeswitch )