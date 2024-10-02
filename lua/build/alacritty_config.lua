local TOML = require("../toml")

return function(build, forgebuild)
	if build.alacritty_config then
		local config_data = [[
# managed by systemforge
# DO NOT EDIT. YOUR CHANGES WILL BE LOST
]]

		config_data = config_data .. TOML.encode(build.alacritty_config)

		local handle = io.open(HOME_DIR .. "/.config/alacritty/alacritty.toml", "w")
		handle:write(config_data)
	end
end
