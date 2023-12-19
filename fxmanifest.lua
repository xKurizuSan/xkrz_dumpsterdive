fx_version "bodacious"

game "gta5"

author "xKurizu"
description "ESX Dumpsterdive/Trashsearch"
version "1.0.0"

shared_scripts {
    '@ox_lib/init.lua',
	'@es_extended/imports.lua', 
    'config.lua'    
}

client_script "client/main.lua"

server_script "server/main.lua"

lua54 'yes'