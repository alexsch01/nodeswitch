$nodeswitch1stParameter = $args[0]
$nodeswitch2ndParameter = $args[1]
 
if ( $nodeswitch1stParameter -ne $null ) {
    if ( $nodeswitch2ndParameter -ne $null ) {
        if ( $args[2] -ne $null ) {
            echo "Incorrect command"
        } else {
            if ( $nodeswitch1stParameter -eq "remove" ) {
                if ( Test-Path -Path $env:AppData\nodeswitch\$nodeswitch2ndParameter ) {
                    Remove-Item -Recurse $env:AppData\nodeswitch\$nodeswitch2ndParameter
                } else {
                    echo "Node version not installed"
                }
            } elseif ( $nodeswitch1stParameter -eq "use" ) {
                if ( $nodeswitch2ndParameter -eq "default" ) {
                    if ( $global:nodeswitchDefaultPATH -ne $null ) {
                        $env:Path = $global:nodeswitchDefaultPATH
                    }
                } else {
                    if ( Test-Path -Path $env:AppData\nodeswitch\$nodeswitch2ndParameter ) {
                        if ( $global:nodeswitchDefaultPATH -eq $null ) {
                            $global:nodeswitchDefaultPATH = $env:Path
                            $env:Path = cmd /c "echo %PATH:C:\Program Files\nodejs\;=%;$env:AppData\nodeswitch\$nodeswitch2ndParameter"
                        } else {
                            $env:Path = echo $global:nodeswitchDefaultPATH
                            $env:Path = cmd /c "echo %PATH:C:\Program Files\nodejs\;=%;$env:AppData\nodeswitch\$nodeswitch2ndParameter"
                        }
                    } else {
                        echo "Node version not installed"
                    }
                }
            } elseif ( $nodeswitch1stParameter -eq "add" ) {
                if ( -not ( Test-Path -Path $env:AppData\nodeswitch\$nodeswitch2ndParameter ) ) {
                    cmd /c "curl -f https://nodejs.org/download/release/v$nodeswitch2ndParameter > nul 2>&1"
                    if ( $LASTEXITCODE -eq 0 ) {
                        cmd /c "curl -s -o $env:AppData\nodeswitch\$nodeswitch2ndParameter.zip https://nodejs.org/download/release/v$nodeswitch2ndParameter/node-v$nodeswitch2ndParameter-win-x64.zip > nul"
                        tar -xf $env:AppData\nodeswitch\$nodeswitch2ndParameter.zip -C $env:AppData\nodeswitch
                        del $env:AppData\nodeswitch\$nodeswitch2ndParameter.zip
                        cmd /c "move $env:AppData\nodeswitch\node-v$nodeswitch2ndParameter-win-x64 $env:AppData\nodeswitch\$nodeswitch2ndParameter > nul"
                    } else {
                        echo "Node version not found" 
                    }
                } else {
                    echo "Node version already added"
                }
            } else {
                echo "Incorrect command"
            }
        }
    } else {
        if ( $nodeswitch1stParameter -eq "list" ) {
            dir -n $env:AppData\nodeswitch 
        } else {
            echo "Incorrect command"
        }
    }
} else {
    echo "Incorrect command"
}