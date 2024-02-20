function SetValuesInDictionary(Target: table, Source: table)
	for Key, Value in pairs(Target) do
		if Source[Key] then
			if typeof(Source[Key]) == "table" and Source[Key].get then
				Target[Key]:set(Source[Key]:get())
			else
				Target[Key]:set(Source[Key])
			end
		elseif typeof(Value) == "table" and typeof(Source[Key]) == "table" then
			SetValuesInDictionary(Target[Key], Source[Key])
		end
	end
end

return SetValuesInDictionary
