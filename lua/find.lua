return function(needle, haystack)
	for i, v in ipairs(haystack) do
		if needle == v then
			return i
		end
	end

	return nil
end
