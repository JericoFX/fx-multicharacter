fx_version("cerulean")
game("gta5")

description("QB-Multicharacter")
version("1.0.0")

shared_script("config.lua")
client_script("client/main.lua")
server_scripts({
	"@oxmysql/lib/MySQL.lua",
	"server/main.lua",
})

ui_page("html/dist/index.html")

files({
	"html/dist/index.html",
	"html/dist/assets/*.css",
	"html/dist/assets/*.js",
})

dependencies({
	"qb-core",
	"qb-spawn",
})

lua54("yes")
