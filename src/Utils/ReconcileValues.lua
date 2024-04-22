function SetValuesInDictionary(Target: { [any]: any }, Source: { [any]: any })
	for Key, Value in pairs(Target) do
		if typeof(Value) == "table" and Value.set then
			if typeof(Source[Key]) == "table" and Source[Key].get then
				Value:set(Source[Key]:get())
			elseif Source[Key] ~= nil then
				Value:set(Source[Key])
			end
		elseif typeof(Value) == "table" then
			if typeof(Source[Key]) == "table" then
				SetValuesInDictionary(Value, Source[Key])
			end
		end
	end
end

return SetValuesInDictionary
