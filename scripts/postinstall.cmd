copy .\bin\nodeswitch %AppData%\npm
copy .\bin\nodeswitch.cmd %AppData%\npm
copy .\bin\nodeswitch.ps1 %AppData%\npm
copy .\bin\nodeswitch.sh %AppData%\npm
findstr /m "alias nodeswitch=" %userprofile%\.bash_profile > nul
if %errorlevel% == 1 ( echo alias nodeswitch="source nodeswitch" >> %userprofile%\.bash_profile )
if not exist %AppData%\nodeswitch ( mkdir %AppData%\nodeswitch )
