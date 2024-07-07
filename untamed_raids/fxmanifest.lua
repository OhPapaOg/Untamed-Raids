fx_version "cerulean"
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
game 'rdr3'
lua54 'yes'

author 'OhPapa'
description 'Untamed Raids. A script used to spawn in waves of anemies by command. Can be used for events or any purpose.'
version '1.0.0'


client_scripts {
    'client/*.lua'
}

server_scripts {
    'server/*.lua'
}

shared_scripts {
    'shared/config.lua',
}
