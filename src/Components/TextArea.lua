--[=[
		@class TextArea
		
		Like [`TextInput`](/api/TextInput), but dedicated for multi-line use-cases.
]=]

local OnyxUI = script.Parent.Parent
local Util = require(OnyxUI.Util)

local TextInput = require(OnyxUI.Components.TextInput)

export type Props = TextInput.Props & {}

--[=[
		@within TextArea
		@interface TextAreaProps

		@field ... TextInputProps
		@field ... TextAreaProps
]=]
return function(Props: Props)
	return TextInput(Util.CombineProps(Props, {
		AutomaticSize = Enum.AutomaticSize.None,
		TextWrapped = true,
		MultiLine = true,
	}))
end
