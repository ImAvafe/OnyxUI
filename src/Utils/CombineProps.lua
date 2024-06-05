local function CombineProps(PreferredProps: { [string]: any }, Props: { [string]: any })
	for Key, Value in pairs(PreferredProps) do
		if Props[Key] == nil then
			Props[Key] = Value
		end
	end

	return Props
end

return CombineProps
