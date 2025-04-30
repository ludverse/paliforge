local get_diff = require("get_diff")

return function(build, forgebuild)
	local home_files = build.home_files
	local diff = get_diff(build.yay_pkgs, forgebuild.yay_pkgs)

	for path, item in pairs(home_files) do
		if item.git then
			local cmd = "git clone '" .. item.git .. "' '" .. HOME_DIR .. "/" .. path .. "'"

			print("[forge] running `" .. cmd .. "`")
			os.execute(cmd)
		elseif item.from then
			os.execute("cp -r '" .. item.from .. "' '" .. path .. "'")
		end
	end
end
