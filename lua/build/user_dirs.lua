return function(build, forgebuild)
	local dirs_file = [[
# managed by systemforge
# DO NOT EDIT. YOUR CHANGES WILL BE LOST
]]

	local user_dirs = {
		DESKTOP = "$HOME/Desktop",
		DOWNLOAD = "$HOME/Downloads",
		TEMPLATES = "$HOME/Templates",
		PUBLICSHARE = "$HOME/Public",
		DOCUMENTS = "$HOME/Documents",
		MUSIC = "$HOME/Music",
		PICTURES = "$HOME/Pictures",
		VIDEOS = "$HOME/Videos",
	}

	for k, v in pairs(build.user_dirs) do
		user_dirs[k] = v
	end

	for name, path in pairs(user_dirs) do
		dirs_file = dirs_file .. "\nXDG_" .. name .. "_DIR=\"" .. path .. "\""
	end

	local handle = io.open(HOME_DIR .. "/.config/user-dirs.dirs", "w")
	handle:write(dirs_file)
end
