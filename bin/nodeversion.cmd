@echo off
@REM cmd /c "npm pack && npm i -g nodeswitch-1.0.0.tgz && del nodeswitch-1.0.0.tgz"

if not "%1" == "" (
    if not "%2" == "" (
        if not "%3" == "" (
            echo Incorrect command
        ) else (
            curl -f https://nodejs.org/download/release/v%2 > nul 2>&1
            if %ERRORLEVEL% equ 0 (
                if "%1" == "add" (
                    curl -s -o %AppData%\nodeswitch\%2.zip https://nodejs.org/download/release/v%2/node-v%2-win-x64.zip > nul
                    tar -xf %AppData%\nodeswitch\%2.zip -C %AppData%\nodeswitch
                    del %AppData%\nodeswitch\%2.zip
                    move %AppData%\nodeswitch\node-v%2-win-x64 %AppData%\nodeswitch\%2 > nul
                ) else if "%1" == "remove" (
                    if exist %AppData%\nodeswitch\%2 ( rmdir /s /q %AppData%\nodeswitch\%2 )
                ) else if "%1" == "use" (
                    if exist %AppData%\nodeswitch\%2 (
                        if not defined nodeswitchDefaultPATH (
                            set "nodeswitchDefaultPATH=%PATH%"
                            set "PATH=%PATH:C:\Program Files\nodejs\;=%;%AppData%\nodeswitch\%2"
                        ) else (
                            set "PATH=%nodeswitchDefaultPATH:C:\Program Files\nodejs\;=%;%AppData%\nodeswitch\%2"
                        )
                    ) else (
                        echo Node version not installed
                    )
                ) else (
                    echo Incorrect command
                )
            ) else (
                echo Node version not found
            )
        )
    ) else (
        if "%1" == "list" (
            dir /b %AppData%\nodeswitch
        ) else if "%1" == "default" (
            if defined nodeswitchDefaultPATH (
                set "PATH=%nodeswitchDefaultPATH%"
            )
        ) else (
            echo Incorrect command
        )
    )
) else (
    echo Incorrect command
)