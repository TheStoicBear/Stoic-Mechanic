author "TheStoicBear"
description "Bears-Mechanic"
version "2.5"

fx_version "cerulean"
game "gta5"
lua54 "yes"

server_script "source/server.lua"
client_script "source/client.lua"

shared_scripts {
    "config.lua",
    "@ND_Core/init.lua",
    "@ox_lib/init.lua"
}
