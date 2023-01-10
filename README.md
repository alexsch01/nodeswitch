# nodeswitch

Node version switcher for Microsoft Windows x64

https://github.com/alexsch01/nodeswitch

<br>

#### How To Install

```
npm install -g nodeswitch

*****
Node versions installed by this tool are in the "C:\Users\YOUR_USERNAME\AppData\Roaming\nodeswitch" folder
*****
```

#### Examples

```
nodeswitch add 12.16.3
nodeswitch add 18.13.0

nodeswitch remove 12.16.3
nodeswitch remove 18.13.0

nodeswitch use 12.16.3
nodeswitch use 18.13.0

nodeswitch use default

nodeswitch list
```

#### How To Uninstall

```
npm uninstall -g nodeswitch

*****
In the "C:\Users\YOUR_USERNAME\AppData\Roaming\npm" folder, delete 2 files: nodeswitch.cmd and nodeswitch.ps1
In the "C:\Users\YOUR_USERNAME\.bash_profile" file, remove the line [alias nodeswitch="source nodeswitch"]
*****
```
