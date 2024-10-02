local find = require("find")

return function(new, old)
	if type(new) == "table" and type(old) == "table" then
		if #new and #old then
			local added = {}
			local removed = {}

			for _, v in ipairs(old) do
				if find(v, new) == nil then
					print("old", v)
					table.insert(removed, v)
				end
			end

			for _, v in ipairs(new) do
				if find(v, old) == nil then
					print("new", v)
					table.insert(added, v)
				end
			end

			return {
				added = added,
				removed = removed
			}
		end

		local diff = {}

		for k, v in pairs(old) do
			if v ~= new[k] then
				diff[k] = nil
			end
		end

		for k, v in pairs(new) do
			if v ~= old[k] then
				diff[k] = diff(new[k], old[k])
			end
		end

		return diff
	end

	return new
end
