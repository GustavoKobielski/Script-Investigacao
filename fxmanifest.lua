fx_version 'cerulean'
game 'gta5'

author 'LK Store - Lakxiwn#6388'
description 'Emprego de investigador'
version '1.0.0'

ui_page "nui/index.html"

client_scripts {
	"@vrp/lib/utils.lua",
	"config.lua",
	"client/*"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"config.lua",
	"server/*"
}

files {
	"nui/index.html",
	"nui/ui.js",
	"nui/style.css",
	"nui/images/*"
}

lua54 "yes"