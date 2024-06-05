local function CombineProps(Source: { [string]: any }, Target: { [string]: any })
	for Key, Value in pairs(Source) do
		Target[Key] = Value
	end

	return Target
end

return CombineProps
