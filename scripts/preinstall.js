if(!process.env.npm_config_global) {
    console.log('This npm module can only be installed globally')
    process.exit(1)
}

if(process.platform != 'win32' || process.arch != 'x64') {
    console.log('This npm module is only for Microsoft Windows x64')
    process.exit(1)
}
