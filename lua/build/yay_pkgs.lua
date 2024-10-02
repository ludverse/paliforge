local json = require("json")
local get_diff = require("get_diff")

return function(build, forgebuild)
	local diff = get_diff(build.yay_pkgs, forgebuild.yay_pkgs)

	if #diff.removed ~= 0 then
		-- local prefixes_removed = {}

		-- for _, pkg_with_prefix in ipairs(diff.removed) do
		-- print(pkg_with_prefix)
		-- local _, pkg_name = string.match(pkg_with_prefix, "([^/]+)/([^/]+)")
		-- table.insert(prefixes_removed, pkg_name)
		-- end

		local cmd = "sudo apt-get remove " .. table.concat(diff.removed, " ")

		print("[forge] running `" .. cmd .. "`")
		interactively_run(cmd)
	end

	if #diff.added ~= 0 then
		local cmd = "sudo apt-get install " .. table.concat(diff.added, " ")

		print("[forge] running `" .. cmd .. "`")
		interactively_run(cmd)
	end
end
