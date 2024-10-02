if PALIFORGE_LUA_LIB_STR then
	-- add lib to path so require can find the other files
	package.path = package.path .. ";" .. PALIFORGE_LUA_LIB_STR .. "/?.lua"
end

HOME_DIR = os.getenv("HOME")

local default_build = {
	yay_pkgs = {},
	fish_config = {
		aliases = {},
		env_variables = {},
		config_extra = {},
	},
	user_dirs = {
		DESKTOP = "$HOME/Desktop",
		DOWNLOAD = "$HOME/Downloads",
		TEMPLATES = "$HOME/Templates",
		PUBLICSHARE = "$HOME/Public",
		DOCUMENTS = "$HOME/Documents",
		MUSIC = "$HOME/Music",
		PICTURES = "$HOME/Pictures",
		VIDEOS = "$HOME/Videos",
	},
}

local json = require("json")

local home = os.getenv("HOME")
local config_path = home .. "/.config/paliforge"

local forgebuild = default_build

local forgebuild_file = io.open(config_path .. "/forgebuild", "r")
if forgebuild_file then
	local forgebuild_data = forgebuild_file:read("*all")
	forgebuild = json.decode(forgebuild_data)
end

EXTRAS = {}
BUILD = default_build

local function insert_items_into_extras(items)
	for k, v in pairs(items) do
		EXTRAS[k] = v
	end
end

insert_items_into_extras(require("extras.zoxide_integration"))

local config_exists_check, err = io.open(config_path .. "/config.lua", "r")
if not config_exists_check then
	error(err)
end

dofile(config_path .. "/config.lua")

require("build.fish_config")(BUILD, forgebuild)
require("build.alacritty_config")(BUILD, forgebuild)
require("build.yay_pkgs")(BUILD, forgebuild)
require("build.user_dirs")(BUILD, forgebuild)

local forgebuild_file = io.open(config_path .. "/forgebuild", "w")
print("[forge] writing forgebuild")
forgebuild_file:write(json.encode(BUILD))
