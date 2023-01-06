$nodeswitch1stParameter = $args[0]
$nodeswitch2ndParameter = $args[1]

if ( $nodeswitch1stParameter -ne $null ) {
    if ( $nodeswitch2ndParameter -ne $null ) {
        if ( $args[2] -ne $null ) {
            echo "Incorrect command"
        } else {
            curl -f https://nodejs.org/download/release/v$nodeswitch2ndParameter 2>&1>$null
            if ( $LASTEXITCODE -eq 0 ) {
                if ( $nodeswitch1stParameter -eq "add" ) {
                    curl -s -o $env:AppData\nodeswitch\$nodeswitch2ndParameter.zip https://nodejs.org/download/release/v$nodeswitch2ndParameter/node-v$nodeswitch2ndParameter-win-x64.zip > $null
                    tar -xf $env:AppData\nodeswitch\$nodeswitch2ndParameter.zip -C $env:AppData\nodeswitch
                    del $env:AppData\nodeswitch\$nodeswitch2ndParameter.zip
                    move $env:AppData\nodeswitch\node-v$nodeswitch2ndParameter-win-x64 $env:AppData\nodeswitch\$nodeswitch2ndParameter > nul
                } elseif ( $nodeswitch1stParameter -eq "remove" ) {
                    if ( Test-Path -Path $env:AppData\nodeswitch\$nodeswitch2ndParameter ) { Remove-Item -Recurse $env:AppData\nodeswitch\$nodeswitch2ndParameter }
                } elseif ( $nodeswitch1stParameter -eq "use" ) {
                    if ( $global:nodeswitchDefaultPATH -eq $null ) {
                        $global:nodeswitchDefaultPATH = $env:Path
                        $env:Path = $env:Path.split('C:\Program Files\nodejs\;')[0] + $env:Path.split('C:\Program Files\nodejs\;')[1] + ";$env:AppData\nodeswitch\$nodeswitch2ndParameter"
                    } else {
                        $env:Path = $global:nodeswitchDefaultPATH.split('C:\Program Files\nodejs\;')[0] + $global:nodeswitchDefaultPATH.split('C:\Program Files\nodejs\;')[1] + ";$env:AppData\nodeswitch\$nodeswitch2ndParameter"
                    }
                } else {
                    echo "Incorrect command"
                }
            } else {
                echo "Node version not found"
            }
        }
    } else {
        if ( $nodeswitch1stParameter -eq "list" ) {
            dir -n $env:AppData\nodeswitch
        } elseif ( $nodeswitch1stParameter -eq "default" ) {
            if ( $global:nodeswitchDefaultPATH -ne $null ) {
                $env:Path = $global:nodeswitchDefaultPATH
            }
        } else {
            echo "Incorrect command"
        }
    }
} else {
    echo "Incorrect command"
}