return function(build, forgebuild)
	local fish_script = [[
# managed by systemforge
# DO NOT EDIT. YOUR CHANGES WILL BE LOST
]]

	local alias_lines = {}
	for key, alias in pairs(build.fish_config.aliases) do
		local escaped_alias = alias:gsub("'", "\\'")
		table.insert(alias_lines, "alias " .. key .. "='" .. escaped_alias .. "'")
	end

	fish_script = fish_script .. "\n" .. table.concat(alias_lines, "\n") .. "\n"

	local env_lines = {}
	for key, val in pairs(build.fish_config.env_vars) do
		local escaped_val = val:gsub("'", "\\'")
		table.insert(env_lines, "set -gx " .. key .. " '" .. escaped_val .. "'")
	end

	fish_script = fish_script .. "\n" .. table.concat(env_lines, "\n") .. "\n"

	for _, extra in ipairs(build.fish_config.config_extra) do
		fish_script = fish_script .. "\n" .. extra .. "\n"
	end

	local handle = io.open(HOME_DIR .. "/.config/fish/config.fish", "w")
	handle:write(fish_script)
end
