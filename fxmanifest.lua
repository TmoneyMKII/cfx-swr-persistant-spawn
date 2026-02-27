fx_version 'cerulean'
game 'gta5'

name 'cfx-swr-persistant-spawn'
author 'GitHub Copilot'
description 'Persistent spawn locations using a local SQLite database file'
version '1.0.0'

files {
    'config.json'
}

server_script 'server/main.js'
client_script 'client/main.lua'
