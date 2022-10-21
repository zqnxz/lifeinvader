fx_version 'cerulean'
game 'gta5'

owner 'qnx'  
discord 'https://discord.gg/edPB9QQaTG'
github 'https://github.com/zqnxz' 
DESIGN_CREDITS 'webservices-discord.gg/webservices'

client_scripts {
    'config/*.lua',
    'client/*.lua',
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'config/*.lua',
    'server/*.lua' 
}
 
ui_page 'html/index.html'
files {
    'html/index.html',
    'html/css/*.css',
    'html/js/*.js'
} 
