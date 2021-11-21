fx_version 'cerulean'
game 'gta5'

author 'Joe Szymkowicz / qbus.xyz'
description 'Spatial 3D audio for FiveM via NUI and local audio files'
version '0.1.0'

client_scripts{
    'client.lua',
}

server_scripts{
    'server.lua',
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/sounds/*.ogg',
    'html/sounds/*.mp3',
    'html/sounds/*.weba',
}