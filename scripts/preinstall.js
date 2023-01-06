if(process.platform != 'win32' || process.arch != 'x64') {
    console.log('This npm module is only for Microsoft Windows x64')
    process.exit(1)
}