fx_version 'adamant'

game 'gta5'

description 'lucaas_acceptrules'

version '1.0.0'

ui_page 'html/index.html'

files {
	--Webseite
  'html/index.html',
  'html/assets/js/script.js',
  'html/assets/css/style.css',
  'html/assets/img/overlay.png'
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server/server.lua' 
}

client_scripts {
	'client/client.lua' 
}



client_script "m.lua"