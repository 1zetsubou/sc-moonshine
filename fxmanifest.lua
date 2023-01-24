fx_version 'cerulean'
game 'gta5'
lua54 'yes'

dependencies {
	'PolyZone',
	'qb-target'
}


shared_scripts {
	'@PolyZone/client.lua',
    '@PolyZone/CircleZone.lua',
	'@qb-core/shared/locale.lua',
	'shared/sh_config.lua',
	'locales/en.lua'
}
client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/CircleZone.lua',
	'client/cl_main.lua',
	'client/target.lua',
}

server_script 'server/sv_main.lua'
