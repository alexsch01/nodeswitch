nodeswitchAPPDATA=$(cygpath -u $APPDATA)

if [ "$1" != "" ]; then
    if [ "$2" != "" ]; then
        if [ "$3" != "" ]; then
            echo "Incorrect command"
        else
            if [ "$1" = "remove" ]; then
                if [ -d "$nodeswitchAPPDATA/nodeswitch/$2" ]; then
                    rm -rf $nodeswitchAPPDATA/nodeswitch/$2
                else
                    echo "Node version not installed"
                fi
            elif [ "$1" = "use" ]; then
                if [ "$2" = "default" ]; then
                    if [ ! -z "$nodeswitchDefaultPATH" ]; then
                        export PATH=$nodeswitchDefaultPATH
                    fi
                else
                    if [ -d "$nodeswitchAPPDATA/nodeswitch/$2" ]; then
                        if [ -z "$nodeswitchDefaultPATH" ]; then
                            export nodeswitchDefaultPATH=$PATH
                            export PATH=$nodeswitchAPPDATA/nodeswitch/$2:$PATH
                        else
                            export PATH=$nodeswitchAPPDATA/nodeswitch/$2:$nodeswitchDefaultPATH
                        fi
                    else
                        echo "Node version not installed"
                    fi
                fi
            elif [ "$1" = "add" ]; then
                if [ ! -d "$nodeswitchAPPDATA/nodeswitch/$2" ]; then
                    curl -f https://nodejs.org/download/release/v$2/ &>/dev/null
                    if [ $? -eq 0 ]; then
                        curl -s -o $nodeswitchAPPDATA/nodeswitch/$2.zip https://nodejs.org/download/release/v$2/node-v$2-win-x64.zip > /dev/null

                        if [ $? -ne 0 ]; then
                            rm $nodeswitchAPPDATA/nodeswitch/$2.zip
                            echo "Node version not created"
                            exit
                        fi

                        unzip -d $nodeswitchAPPDATA/nodeswitch -o $nodeswitchAPPDATA/nodeswitch/$2.zip > /dev/null

                        if [ $? -ne 0 ]; then
                            rm $nodeswitchAPPDATA/nodeswitch/$2.zip
                            rm -rf $nodeswitchAPPDATA/nodeswitch/node-v$2-win-x64
                            echo "Node version not created"
                            exit
                        fi

                        rm $nodeswitchAPPDATA/nodeswitch/$2.zip
                        mv $nodeswitchAPPDATA/nodeswitch/node-v$2-win-x64 $nodeswitchAPPDATA/nodeswitch/$2 > /dev/null
                    else
                        echo "Node version not found"
                    fi
                else
                    echo "Node version already added"
                fi
            else
                echo "Incorrect command"
            fi
        fi
    else
        if [ "$1" = "list" ]; then
            dir -1 $nodeswitchAPPDATA/nodeswitch
        elif [ "$1" = "path" ]; then
            echo "$nodeswitchAPPDATA/nodeswitch"
        else
            echo "Incorrect command"
        fi
    fi
else
    echo "Incorrect command"
fi
