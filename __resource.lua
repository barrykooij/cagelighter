resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'

description "A simple lighter mod for FiveM"

ui_page 'html/player.html'

files {
	'html/player.html',
	'html/player.js',
	'html/aanstekersfx.mp3'
}

client_script {
	"client.lua"
}

server_script {
  "server.lua"
}
