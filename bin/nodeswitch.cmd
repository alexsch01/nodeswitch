@echo off

if not "%1" == "" (
    if not "%2" == "" (
        if not "%3" == "" (
            echo Incorrect command
        ) else (
            if "%1" == "remove" (
                if exist %AppData%\nodeswitch\%2 (
                    rmdir /s /q %AppData%\nodeswitch\%2
                ) else (
                    echo Node version not installed
                )
            ) else if "%1" == "use" (
                if "%2" == "default" (
                    if defined nodeswitchDefaultPATH (
                        set "PATH=%nodeswitchDefaultPATH%"
                    )
                ) else (
                    if exist %AppData%\nodeswitch\%2 (
                        if not defined nodeswitchDefaultPATH (
			    set "nodeswitchDefaultPATH=%PATH%"
			    set "PATH=%AppData%\nodeswitch\%2;%PATH%"
                        ) else (
			    set "PATH=%AppData%\nodeswitch\%2;%nodeswitchDefaultPATH%"
                        )
                    ) else (
                        echo Node version not installed
                    )
                )
            ) else if "%1" == "add" (
                if not exist %AppData%\nodeswitch\%2 (
                    curl -f https://nodejs.org/download/release/v%2/ > nul 2>&1 && (
                        curl -s -o %AppData%\nodeswitch\%2.zip https://nodejs.org/download/release/v%2/node-v%2-win-x64.zip > nul || (
                            del %AppData%\nodeswitch\%2.zip
                            echo Node version not created
                            exit
                        )

                        tar -xf %AppData%\nodeswitch\%2.zip -C %AppData%\nodeswitch || (
                            del %AppData%\nodeswitch\%2.zip
                            rd /s /q %AppData%\nodeswitch\node-v%2-win-x64
                            echo Node version not created
                            exit
                        )

                        del %AppData%\nodeswitch\%2.zip
                        move %AppData%\nodeswitch\node-v%2-win-x64 %AppData%\nodeswitch\%2 > nul
                    ) || (
                        echo Node version not found
                    )
                ) else (
                    echo Node version already added
                )
            ) else (
                echo Incorrect command
            )
        )
    ) else (
        if "%1" == "list" (
            dir /b %AppData%\nodeswitch
        ) else if "%1" == "path" (
            echo %AppData%\nodeswitch
        ) else (
            echo Incorrect command
        )
    )
) else (
    echo Incorrect command
)

@echo on

